//=============================================================================
// Mk781Shotgun.
//
// The Mk781 auto shottie, aka the LASERLASER
// Silencer increases accuracy. Lowres poers.
// alt fire puts in fancy shells.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mk781Shotgun extends BallisticProShotgun;

var()	bool	bHasSuppressor;
var()   bool	bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() sound		SilencerOnTurnSound;		// Silencer screw on sound
var() sound		SilencerOffTurnSound;		//

var() bool		bHasAltShells;
var() Name		SGPrepAnim;			//Anim to use for loading special shells
var() Name		ReloadAltAnim;			//Anim to use for Reloading special shells
var() Name		ReloadAnimEmpty;		//Anim to use for Reloading from 0

var() Sound		GrenLoadSound;		//
var() float     VisGrenades;		//Rockets currently visible in tube.
var() int       Grenades;		//Rockets currently in the gun.
var() int		StartingGrenades;
var() byte		PreviousWeaponMode;		//Used to store the last referenced firemode pre Alt
var() bool		bReady;			//Weapon ready for alt fire
var   byte				ShellIndex;

var()	bool		bIsSlug;

var()	bool		bHasLAM;
var()   byte		GearStatus;			//LAM configuration
var()   bool		bLaserOn, bOldLaserOn;
var()   LaserActor  Laser;
var() 	Sound		LaserOnSound;
var() 	Sound		LaserOffSound;
var()   Emitter	    LaserDot;

var() Projector	    FlashLightProj;
var() Emitter		FlashLightEmitter;
var() bool		    bLightsOn;
var() bool		    bFirstDraw;
var() vector		TorchOffset;
var() Sound		    TorchOnSound;
var() Sound		    TorchOffSound;

struct RevInfo
{
	var() name	Shellname;
};
var() RevInfo	Shells[6];

replication
{
	// Things the server should send to the client.
	reliable if(Role==ROLE_Authority)
		Grenades, bReady, bLaserOn;
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer, ServerFlashLight, ServerSwitchLaser;
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsClassicOrRealism())
	{
		StartingGrenades = 6;
	}
	Grenades = StartingGrenades;
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;

	//Do not use default to save postnetreceived shit
	if (bLaserOn != bOldLaserOn)
	{
		OnLaserSwitched();

		bOldLaserOn = bLaserOn;
        ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	bHasLAM=false;
	bHasSuppressor=true;
	bHasAltShells=true;
	bIsSlug=false;
	
	if (InStr(WeaponParams.LayoutTags, "slug") != -1)
	{
		bIsSlug=true;
	}
	if (InStr(WeaponParams.LayoutTags, "lam") != -1)
	{
		bHasLAM=true;
	}
	if (InStr(WeaponParams.LayoutTags, "no_suppressor") != -1)
	{
		bHasSuppressor=false;
	}
	if (InStr(WeaponParams.LayoutTags, "no_alt") != -1)
	{
		bHasAltShells=false;
		StartingGrenades = 0;
	}
	if (InStr(WeaponParams.LayoutTags, "start_suppressed") != -1)
	{
		bSilenced = true;
		BFireMode[0].bAISilent = true;
		
		Mk781PrimaryFire(FireMode[0]).SwitchSilencerMode(true);
		Mk781SecondaryFire(FireMode[1]).SwitchSilencerMode(true);
		ParamsClasses[GameStyleIndex].static.OverrideFireParams(self,3);
	}
}

simulated function OnAimParamsChanged()
{
	Super.OnAimParamsChanged();

	if (bSilenced)
		ApplySuppressorAim();
	if (bLaserOn)
		ApplyLaserAim();
}

//Now adds initial ammo in all cases
function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
    if ( FireMode[m] != None && FireMode[m].AmmoClass != None )
    {
		Ammo[m] = Ammunition(Instigator.FindInventoryType(FireMode[m].AmmoClass));
        if (Ammo[m] == None)
        {
            Ammo[m] = Spawn(FireMode[m].AmmoClass, instigator);
            Instigator.AddInventory(Ammo[m]);
        }
		//Dropped pickup, just add ammo
        if ((WP != None) && (WP.bDropped || WP.AmmoAmount[m] > 0))
			Ammo[m].AddAmmo(WP.AmmoAmount[m]);
		//else add initial complement
		//if was just spawned and (wasn't dropped or there's no pickup) and (firemodes don't match)
		else if (bJustSpawned && (WP==None || !WP.bDropped) && m == 0)
			Ammo[m].AddAmmo(Ammo[m].InitialAmount);
        Ammo[m].GotoState('');
	}
}

//====================
//SPECIAL AMMO CODE
//====================

simulated function EmptyAltFire (byte Mode)
{
	if (Grenades <= 0 && ClientState == WS_ReadyToFire && FireCount < 1 && Instigator.IsLocallyControlled())
		ServerStartReload(Mode);
}

simulated function DrawWeaponInfo(Canvas Canvas)
{
	NewDrawWeaponInfo(Canvas, 0.705*Canvas.ClipY);
}

//Modified to subtract active grenades and add little icons
simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local int i,Count;
	local float ScaleFactor2;

	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;
	local int	TempNum;

	DrawCrosshairs(C);
	
	//Draw grenades, they're not accounted for in alternative HUD
	ScaleFactor = C.ClipX / 1600;
	ScaleFactor2 = 99 * C.ClipX/3200;
	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = class'HUD'.Default.WhiteColor;
	if (bHasAltShells)
	{
		Count = Min(8,Grenades);
		for( i=0; i<Count; i++ )
		{
			C.SetPos(C.ClipX - (0.5*i+1) * ScaleFactor2, C.ClipY - 100 * ScaleFactor * class'HUD'.default.HudScale);
			C.DrawTile( Texture'BWBP_SKC_Tex.M1014.M1014-SGIcon',ScaleFactor2, ScaleFactor2, 0, 0, 128, 128);
		}
	}
	if (bSkipDrawWeaponInfo)
		return;

	// Draw the spare ammo amount
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	if (!bNoMag)
	{
		Temp = GetHUDAmmoText(0);
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 140 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		
		TempNum = Ammo[1].AmmoAmount;
		C.TextSize(TempNum, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 140 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(TempNum, false);
	}

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
		C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 150 * ScaleFactor * class'HUD'.default.HudScale - YL2 - YL;
		C.DrawText(WeaponModes[CurrentWeaponMode].ModeName, false);
	}

	// This is pretty damn disgusting, but the weapon seems to be the only way we can draw extra info on the HUD
	// Would be nice if someone could have a HUD function called along the inventory chain
	if (SprintControl != None && SprintControl.Stamina < SprintControl.MaxStamina)
	{
		SprintFactor = SprintControl.Stamina / SprintControl.MaxStamina;
		C.CurX = C.OrgX  + 5    * ScaleFactor * class'HUD'.default.HudScale;
		C.CurY = C.ClipY - 330  * ScaleFactor * class'HUD'.default.HudScale;
		if (SprintFactor < 0.2)
			C.SetDrawColor(255, 0, 0);
		else if (SprintFactor < 0.5)
			C.SetDrawColor(64, 128, 255);
		else
			C.SetDrawColor(0, 0, 255);
		C.DrawTile(Texture'Engine.MenuWhite', 200 * ScaleFactor * class'HUD'.default.HudScale * SprintFactor, 30 * ScaleFactor * class'HUD'.default.HudScale, 0, 0, 1, 1);
	}
}

//Triggered when a holder shell needs to get lost
simulated function Special_ShellRemove()
{
	VisGrenades-=1;
	UpdateBones();
}

//Function called by alt fire to play SG special load animation.
simulated function PrepAltFire()
{
	PlayAnim(SGPrepAnim,1.0, 0.0);
	ReloadState = RS_Cocking;
}

//Triggered when the SG pump animation finishes
simulated function Special_GrenadeReady()
{
	ReloadState = RS_None;	
	bReady = true;
	Grenades -=1;
	WeaponModes[0].ModeName="X-007 Loaded";
	WeaponModes[1].ModeName="X-007 Loaded";
}

//Triggered after Alt nade is shot.
simulated function PrepPriFire()
{
	WeaponModes[0].ModeName=default.WeaponModes[0].ModeName;
	WeaponModes[1].ModeName=default.WeaponModes[1].ModeName;
}

//For inserting a shell while reloading
simulated function Special_ShellsIn()
{
	local int GrenadesNeeded;

	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);
	ReloadState = RS_PostClipIn;	
	GrenadesNeeded=6-Grenades;
	if (GrenadesNeeded > Ammo[1].AmmoAmount)
		GrenadesNeeded = Ammo[1].AmmoAmount;
	if (Role == ROLE_Authority)
	{
		Mk781SecondaryFire(FireMode[1]).bLoaded = true;
		Grenades += GrenadesNeeded;
		Ammo[1].UseAmmo (GrenadesNeeded, True);
	}
	VisGrenades=Grenades;
		
	UpdateBones();
}

simulated function bool IsGrenadeLoaded()
{
	return Mk781SecondaryFire(FireMode[1]).bLoaded;
}

function ServerStartReload (optional byte i)
{
	local int m;
	local array<byte> Loadings[2];
	
	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (MagAmmo < default.MagAmmo && Ammo[0].AmmoAmount > 0)
		Loadings[0] = 1;
	if (Grenades < 6 && Ammo[1].AmmoAmount > 0)
		Loadings[1] = 1;
	if (Loadings[0] == 0 && Loadings[1] == 0)
		return;

	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;
	
	if (i == 1)
		m = 0;
	else m = 1;
	
	if (Loadings[i] == 1)
	{
		ClientStartReload(i);
		CommonStartReload(i);
	}
	
	else if (Loadings[m] == 1)
	{
		ClientStartReload(m);
		CommonStartReload(m);
	}
	
	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('ReloadGun');
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1)
			CommonStartReload(1);
		else
			CommonStartReload(0);
	}
}

// Prepare to reload, set reload state, start anims. Called on client and server
simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	if (i == 1)
	{
		ReloadState = RS_PreClipOut;
		PlayReloadAlt();
	}
	else
	{
		ReloadState = RS_StartShovel;
		PlayReload();
	}

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(default.SightingTime);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].ReloadingGun(i);

	if (bCockAfterReload)
		bNeedCock=true;
	if (bCockOnEmpty && MagAmmo < 1)
		bNeedCock=true;
	bNeedReload=false;
}

simulated function PlayReloadAlt()
{
	SafePlayAnim(ReloadAltAnim, 1, , 0, "RELOAD");
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None && !IsGrenadeLoaded()&& AmmoAmount(1) > 0 && BotShouldReloadGrenade() && !IsReloadingGrenade())
		LoadGrenadeLoop();
}

// Load in a grenade
simulated function LoadGrenadeLoop()
{
	if (Ammo[1].AmmoAmount < 1 && Grenades > 6)
		return;
	if ((ReloadState == RS_None || ReloadState == RS_StartShovel)&& Ammo[1].AmmoAmount >= 1)
	{
		PlayAnim(ReloadAltAnim, 1.0, , 0);
		ReloadState = RS_StartShovel;
	}
}

function bool BotShouldReloadGrenade ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated function bool IsReloadingGrenade()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == ReloadAltAnim)
 		return true;
	return false;
}

simulated function UpdateBones()
{
	local int i;

	if (VisGrenades<0)
	VisGrenades=0;
	for(i=5;i>=VisGrenades;i--)
		SetBoneScale(i, 0.0, Shells[i].ShellName);
	if (VisGrenades>5)
		VisGrenades=6;
	for(i=0;i<VisGrenades;i++)
		SetBoneScale(i, 1.0, Shells[i].ShellName);
		
	if (bSilenced)
		SetBoneScale (6, 1.0, SilencerBone);
	else
		SetBoneScale (6, 0.0, SilencerBone);
}

//=================================
// Weapon Special: Supp, Light, Laser
//=================================

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	TemporaryScopeDown(0.5);
	
	if (bHasSuppressor)
	{
		if (Level.NetMode == NM_Client)
			ServerSwitchSilencer(!bSilenced);
		SwitchSilencer(!bSilenced);
	}
	if (bHasLAM)
	{
		GearStatus++;
		if (GearStatus > 4)
			GearStatus = 1;

		if (bool(GearStatus & 1))  //Flashlight
		{
			bLightsOn = !bLightsOn;
			ServerFlashLight(bLightsOn);
			if (bLightsOn)
			{
				PlaySound(TorchOnSound,,0.7,,32);
				if (FlashLightEmitter == None)
					FlashLightEmitter = Spawn(class'MRS138TorchEffect',self,,location);
				class'BallisticEmitter'.static.ScaleEmitter(FlashLightEmitter, DrawScale);
				StartProjector();
			}
			else
			{
				PlaySound(TorchOffSound,,0.7,,32);
				if (FlashLightEmitter != None)
					FlashLightEmitter.Destroy();
				KillProjector();
			}
		}
		else //Laser
		{
			ServerSwitchLaser(!bLaserOn);
			PlayIdle();
		}
	}
}

//=================================
// Suppressor
//=================================

function ServerSwitchSilencer(bool bNewValue)
{
	SwitchSilencer(bNewValue);
}

simulated function SwitchSilencer(bool bNewValue)
{
	if (bNewValue == bSilenced)
		return;
	if (Role == ROLE_Authority)
	{
		bServerReloading=True;
		Mk781Attachment(ThirdPersonActor).SetSilenced(bNewValue);
	}
	ReloadState = RS_GearSwitch;
	
	bSilenced = bNewValue;
	BFireMode[0].bAISilent = bSilenced;
	
	Mk781PrimaryFire(FireMode[0]).SwitchSilencerMode(bNewValue);
	Mk781SecondaryFire(FireMode[1]).SwitchSilencerMode(bNewValue);
	
	if (bNewValue)
	{
		PlayAnim(SilencerOnAnim);
		ParamsClasses[GameStyleIndex].static.OverrideFireParams(self,3);
	}
	else
	{
		PlayAnim(SilencerOffAnim);
		SightZoomFactor = default.SightZoomFactor;
		ParamsClasses[GameStyleIndex].static.OverrideFireParams(self,0);
	}
}

simulated function ApplySuppressorAim()
{
	AimComponent.AimSpread.Min *= 1.25;
	AimComponent.AimSpread.Max *= 1.25;
}

simulated function Notify_SilencerOn()	{	PlaySound(SilencerOnSound,,0.5);	}
simulated function Notify_SilencerOff()	{	PlaySound(SilencerOffSound,,0.5);	}

simulated function Notify_SilencerShow(){	UpdateBones();	}
simulated function Notify_SilencerHide(){	UpdateBones();	}

//overidden to ensure suppressor override stays in place
simulated function CommonSwitchWeaponMode(byte NewMode)
{
	local int LastMode;

	if (Instigator == None)
		return;

	LastMode = CurrentWeaponMode;
	CurrentWeaponMode = NewMode;

    ParamsClasses[GameStyleIndex].static.SetFireParams(self);
	
	//Suppressor override
	if (bSilenced)
		ParamsClasses[GameStyleIndex].static.OverrideFireParams(self,3);
	else
		ParamsClasses[GameStyleIndex].static.OverrideFireParams(self,0);

	BFireMode[0].SwitchWeaponMode(CurrentWeaponMode);
	BFireMode[1].SwitchWeaponMode(CurrentWeaponMode);

	if (WeaponModes[LastMode].RecoilParamsIndex != WeaponModes[CurrentWeaponMode].RecoilParamsIndex)
	{
		ParamsClasses[GameStyleIndex].static.SetRecoilParams(self);
	}

	if (WeaponModes[LastMode].AimParamsIndex != WeaponModes[CurrentWeaponMode].AimParamsIndex)
	{
		ParamsClasses[GameStyleIndex].static.SetAimParams(self);
	}

	CheckBurstMode();

	if (ModeHandling == MR_Last && Instigator.IsLocallyControlled())
    {
        default.LastWeaponMode = CurrentWeaponMode;
    }
}

//=================================
// Flashlight
//=================================
function ServerFlashLight (bool bNew)
{
	bLightsOn = bNew;
	Mk781Attachment(ThirdPersonActor).bLightsOn = bLightsOn;
}

simulated function StartProjector()
{
	if (FlashLightProj == None)
		FlashLightProj = Spawn(class'MRS138TorchProjector',self,,location);
	AttachToBone(FlashLightProj, 'Laser');
	FlashLightProj.SetRelativeLocation(TorchOffset);
}
simulated function KillProjector()
{
	if (FlashLightProj != None)
		FlashLightProj.Destroy();
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (!bLightsOn || ClientState != WS_ReadyToFire)
		return;
	if (!Instigator.IsFirstPerson())
		KillProjector();
	else if (FlashLightProj == None)
		StartProjector();
}


simulated event RenderOverlays( Canvas Canvas )
{
	local Vector TazLoc;
	local Rotator TazRot;
	super.RenderOverlays(Canvas);
	if (!IsInState('Lowered'))
		DrawLaserSight(Canvas);
	if (bLightsOn)
	{
		TazLoc = GetBoneCoords('Laser').Origin;
		TazRot = GetBoneRotation('Laser');
		if (FlashLightEmitter != None)
		{
			FlashLightEmitter.SetLocation(TazLoc);
			FlashLightEmitter.SetRotation(TazRot);
			Canvas.DrawActor(FlashLightEmitter, false, false, DisplayFOV);
		}
	}
}

//=================================
// Laser
//=================================

simulated function OnLaserSwitched()
{
	if (bLaserOn)
		ApplyLaserAim();
	else
		AimComponent.Recalculate();
}

simulated function ApplyLaserAim()
{
	AimComponent.AimAdjustTime *= 0.75;
	AimComponent.AimSpread.Max *= 0.75;
	AimComponent.AimSpread.Min *= 0.75;
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	
	if (ThirdPersonActor!=None)
		Mk781Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

	OnLaserSwitched();

    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	OnLaserSwitched();

	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,0.7,,32);
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,0.7,,32);
	}

	PlayIdle();
}

simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'MD24LaserDot',,,Loc);
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}

// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator AimDir;
	local Actor Other;

	if ((ClientState == WS_Hidden) || (!bLaserOn) || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('Laser').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(HitLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = class'BUtil'.static.ConvertFOVs(Instigator.Location + Instigator.EyePosition(), Instigator.GetViewRotation(), End, Instigator.Controller.FovAngle, DisplayFOV, 400);

	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && 
	   ((FireMode[0].IsFiring() && Level.TimeSeconds - FireMode[0].NextFireTime > -0.05) || (!FireMode[0].IsFiring() && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)))
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('Laser');
		Laser.SetRotation(AimDir);
	}
	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}


//=================================
// Destroy Cleanup
//=================================
simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			Mk781Attachment(ThirdPersonActor).bLaserOn = false;
		KillProjector();
		if (FlashLightEmitter != None)
			FlashLightEmitter.Destroy();

		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	default.bLaserOn = false;
	if (Laser != None)
		Laser.Destroy();
	if (LaserDot != None)
		LaserDot.Destroy();
	if (FlashLightEmitter != None)
		FlashLightEmitter.Destroy();
	KillProjector();

	Super.Destroyed();
}
// Bone stuff

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (bSilenced)
	{
		Mk781Attachment(ThirdPersonActor).bSilenced=True;
		ParamsClasses[GameStyleIndex].static.OverrideFireParams(self,3);
	}

	VisGrenades=Grenades;
	ShellIndex = FMin(Grenades-1, 5);
	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && AIController(Instigator.Controller) != None)
	{
		if (bHasLAM)
		{
			ServerSwitchLaser(FRand() > 0.5);
			ServerFlashlight(FRand() > 0.5);
		}
		if (bHasSuppressor)
			bSilenced = (FRand() > 0.5);
	}

	if ( ThirdPersonActor != None )
		Mk781Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

	UpdateBones();
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		bPreventReload=False;
	}

	// Modified stuff from Engine.Weapon
	if ((ClientState == WS_ReadyToFire || (ClientState == WS_None && Instigator.Weapon == self)) && ReloadState == RS_None)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim)) // rocket hack
			SafePlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        else if (FireMode[1]!=None && anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
            SafePlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        else if (MeleeState < MS_Held)
			bPreventReload=false;
		if (Channel == 0)
			PlayIdle();
    }
	// End stuff from Engine.Weapon

	// Start Shovel ended, move on to Shovel loop
	if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		if (MagAmmo == 0)
			PlayShovelLoopEmpty();
		else
			PlayShovelLoop();
		return;
	}
	// Shovel loop ended, start it again
	if (ReloadState == RS_PostShellIn)
	{
		if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1)
		{
			PlayShovelEnd();
			ReloadState = RS_EndShovel;
			return;
		}
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// End of reloading, either cock the gun or go to idle
	if (ReloadState == RS_PostClipIn || ReloadState == RS_EndShovel)
	{
		if (bNeedCock && MagAmmo > 0)
			CommonCockGun();
		else
		{
			bNeedCock=false;
			ReloadState = RS_None;
			ReloadFinished();
			PlayIdle();
			AimComponent.ReAim(0.05);
		}
		return;
	}
	//Cock anim ended, goto idle
	if (ReloadState == RS_Cocking)
	{
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
		AimComponent.ReAim(0.05);
	}
	
	if (ReloadState == RS_GearSwitch)
	{
		if (Role == ROLE_Authority)
			bServerReloading=false;
		ReloadState = RS_None;
		PlayIdle();
	}
}

simulated function PlayShovelLoopEmpty()
{
	SafePlayAnim(ReloadAnimEmpty, ReloadAnimRate, 0.0, , "RELOAD");
}

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount <=0 && MagAmmo <= 0)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;
	
	if (!bHasAltShells)
		return 0;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 400)
		return 0;
	if (Dist < FireMode[1].MaxRange() && FRand() > 0.3)
		return 1;
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(B.Velocity) < 0.5))
		return 1;

	return Rand(2);
}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, BallisticInstantFire(BFireMode[0]).DecayRange.Min, BallisticInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 7;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = -1 * (B.Skill / 6);
	Result *= (1 - (Dist/4000));
    return FClamp(Result, -1.0, -0.3);
}
// End AI Stuff =====

simulated function Notify_BrassOut()
{
}

function ServerSwitchWeaponMode (byte NewMode)
{
	if (CurrentWeaponMode > 0 && FireMode[0].IsFiring())
		return;
	if (FireMode[0].NextFireTime - level.TimeSeconds < -0.1)
		super.ServerSwitchWeaponMode (NewMode);
}

defaultproperties
{
	SilencerBone="Silencer"
	SilencerOnAnim="SilencerOn"
	SilencerOffAnim="SilencerOff"
	SilencerOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
	LaserOnSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	LaserOffSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	TorchOffset=(X=-50.000000)
	TorchOnSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
	TorchOffSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
	SGPrepAnim="LoadSpecial2"
	ReloadAltAnim="ReloadSpecialFull"
	ReloadAnimEmpty="ReloadEmpty"
	GrenLoadSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
	Grenades=6
	StartingGrenades=3
	Shells(0)=(ShellName="HShell1")
	Shells(1)=(ShellName="HShell2")
	Shells(2)=(ShellName="HShell3")
	Shells(3)=(ShellName="HShell4")
	Shells(4)=(ShellName="HShell5")
	Shells(5)=(ShellName="HShell6")
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_SKC_Tex.M1014.BigIcon_M1014'
	BigIconCoords=(Y1=25,Y2=210)
	
	bWT_Shotgun=True
	bWT_Machinegun=True
	ManualLines(0)="Automatic shotgun fire. Lower overall damage per shot than other shotguns, but good fire rate and tight spread. Spread tightens further with the suppressor employed."
	ManualLines(1)="Loads an electroshock shell.|Without the suppressor employed, will subsequently generate an electric shot with high power and excellent range.|With the suppressor employed, will generate an arcing bolt with fast travel time and strong impact damage. Deals lesser damage in a radius around the point of impact."
	ManualLines(2)="The Weapon Function key attaches the suppressor, which removes the flash, reduces recoil, quietens the fire sound of the primary and changes the functionality of the weapon. Due to the suppressor's length, the weapon will offset while jumping if it is attached.||Effective at medium range."
	SpecialInfo(0)=(Info="300.0;25.0;0.5;60.0;0.6;1.0;0.0")
    BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Pullout',Volume=0.220000)
    PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Putaway',Volume=0.260000)
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Pump',Volume=2.300000,Radius=32.000000)
	CockSelectSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.RS04-SlideLock',Volume=2.300000,Radius=32.000000)
	ReloadAnim="ReloadLoop"
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.Mk781.Mk781-ShellPlus',Volume=2.300000,Radius=32.000000)
	ClipInFrame=0.325000
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M353OutA',pic2=Texture'BW_Core_WeaponTex.Crosshairs.M763InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=255,R=255,A=192),Color2=(B=170,G=0,R=0,A=255),StartSize1=66,StartSize2=90)
	bCanSkipReload=True
	bShovelLoad=True
	StartShovelAnim="ReloadStart"
	EndShovelAnim="ReloadEnd"
	WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Semi-Automatic",ModeID="WM_SemiAuto",Value=1.000000)
	WeaponModes(2)=(ModeName="X-007 Loaded",bUnavailable=True)
	CurrentWeaponMode=1
	bNoCrosshairInScope=True
	GunLength=48.000000
	ParamsClasses(0)=Class'MK781WeaponParamsComp'
	ParamsClasses(1)=Class'MK781WeaponParamsClassic'
	ParamsClasses(2)=Class'MK781WeaponParamsRealistic'
    ParamsClasses(3)=Class'MK781WeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.MK781PrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.MK781SecondaryFire'
	PutDownTime=0.500000
	CockingBringUpTime=0.600000
	AIRating=0.800000
	CurrentRating=0.800000
	Description="The Avenger Mk 781 is the special ops version of the M763. It boasts a modernized firing and recoil suppression system and has been praised for its field effectiveness. A good weapon in a pinch, the M781 has been known to save many soldiers' lives. ||This particular model is the MK781 Mod 0, which uses a new lightweight polymer frame and is designed specifically for tactical wetwork. Tube length and barrel length are shortened to cut weight, leaving the Mark 781 with a shell capacity of 6. As part of its wetwork upgrades, this Mark 781 has gained the ability to affix a special suppressor designed for flechette sabot ammunition and slugs. Operators are advised not to load high-powered rounds or buckshot into the suppressor due to potential suppressor damage and failure."
	Priority=245
	HudColor=(B=168,G=111,R=83)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=7
	PickupClass=Class'BWBP_SKC_Pro.MK781Pickup'

	PlayerViewOffset=(X=15.00,Y=9.00,Z=-11.50)
	SightOffset=(X=4.20,Y=0.01,Z=6.97)
	SightAnimScale=0.75
	SightBobScale=0.35

	AttachmentClass=Class'BWBP_SKC_Pro.MK781Attachment'
	IconMaterial=Texture'BWBP_SKC_Tex.M1014.SmallIcon_M1014'
	IconCoords=(X2=127,Y2=35)
	ItemName="MK781 Combat Shotgun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=25
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.MK781_FPm'
	DrawScale=0.30000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Shader'BWBP_SKC_Tex.M1014.M1014-Shine'
	Skins(2)=Shader'BWBP_SKC_Tex.M1014.M1014-MiscShine'
}
