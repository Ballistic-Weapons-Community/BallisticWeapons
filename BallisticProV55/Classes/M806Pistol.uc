//=============================================================================
// M806Pistol.
//
// Semi Automatic pistol with decent damage, 12 round clip, good accracy when
// used carefully, but mainly, its the default weapon.
// Secondary fixes to unpredictable aiming by providing a laser sight so that
// the user knows where to expect the bullets.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M806Pistol extends BallisticHandgun;

//Laser
var() bool			bHasLaser;
var()   bool		bLaserOn;
var()   bool		bStriking;
var()   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var()   Emitter		LaserDot;

//Shotgun
var() bool			bHasShotgun;
var() Name 			ReloadAltAnim;
var() int 			AltAmmo;
var() BUtil.FullSound DrumInSound, DrumOutSound;


replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn, AltAmmo;
}


simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	bHasLaser=true;
	bHasShotgun=false;
	
	if (InStr(WeaponParams.LayoutTags, "scope") != -1)
	{
		bHasLaser=false;
	}
	
	if (InStr(WeaponParams.LayoutTags, "shotgun") != -1)
	{
		bHasShotgun=true;
		bHasLaser=false;
		FireMode[1].AmmoClass=class'Ammo_16GaugeleMat';
		SightFXClass=None;
	}
	else
	{
		AltAmmo=0;
	}
}

// ===============================================
// Shotgun Code 
// ===============================================


//==================================================================
// NewDrawWeaponInfo
//
// Draws icons for number of darts in mag
//==================================================================
simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local int i,Count;
	local float AmmoDimensions;

	local float	ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;

	DrawCrosshairs(C);

	ScaleFactor = C.ClipX / 1600;
	AmmoDimensions = C.ClipY * 0.06;
	
	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = class'HUD'.Default.WhiteColor;
	Count = Min(6,AltAmmo);
	
    for( i=0; i < Count; i++ )
    {
		C.SetPos(C.ClipX - (0.5*i+1) * AmmoDimensions, C.ClipY * (1 - (0.12 * class'HUD'.default.HUDScale)));
		C.DrawTile( Texture'BW_Core_WeaponTex.Icons.Hud_SGIcon',AmmoDimensions, AmmoDimensions, 0, 0, 128, 128);
	}
	
	if (bSkipDrawWeaponInfo)
		return;

	// Draw the spare ammo amount
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	if (!bNoMag)
	{
		Temp = GetHUDAmmoText(0);
		if (Temp == "0")
			C.DrawColor = class'hud'.default.RedColor;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
		C.DrawColor = class'hud'.default.WhiteColor;
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		Temp = GetHUDAmmoText(1);
		if (Temp == "0")
			C.DrawColor = class'hud'.default.RedColor;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
		C.DrawColor = class'hud'.default.WhiteColor;
	}

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
		C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 130 * ScaleFactor * class'HUD'.default.HudScale - YL2 - YL;
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

//===========================================================================
// ServerStartReload
//
// Generic code for weapons which have multiple magazines.
//===========================================================================
function ServerStartReload (optional byte i)
{
	local int m;
	local array<byte> Loadings[2];
	
	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (MagAmmo < WeaponParams.MagAmmo && Ammo[0].AmmoAmount > 0)
		Loadings[0] = 1;
	if (bHasShotgun && AltAmmo < 6 && Ammo[1].AmmoAmount > 0)
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

//==================================================================
// ClientStartReload
//
// Dispatch reload based on desired mag
//==================================================================
simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1 && bHasShotgun)
			CommonStartReload(1);
		else
			CommonStartReload(0);
	}
}

//==================================================================
// CommonStartReload
//
// Handle multiple magazines
//==================================================================
simulated function CommonStartReload (optional byte i)
{
	local int m;

	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;

    switch(i)
    {
		case 0:
			ReloadState = RS_StartShovel;
			PlayReload();
			break;
		case 1:
			ReloadState = RS_PreClipOut;
			PlayReloadAlt();
			break;
    }

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(Default.SightingTime);

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

simulated function Notify_ReloadAltOut()	
{	
	PlayOwnedSound(DrumOutSound.Sound,DrumOutSound.Slot,DrumOutSound.Volume,DrumOutSound.bNoOverride,DrumOutSound.Radius,DrumOutSound.Pitch,DrumOutSound.bAtten);
	ReloadState = RS_PreClipIn;
}

simulated function Notify_ReloadAltIn()          
{   
	local int AmmoNeeded;
	
	PlayOwnedSound(DrumInSound.Sound,DrumInSound.Slot,DrumInSound.Volume,DrumInSound.bNoOverride,DrumInSound.Radius,DrumInSound.Pitch,DrumInSound.bAtten);    
	ReloadState = RS_PostClipIn; 
	
	if (Level.NetMode != NM_Client)
	{
		AmmoNeeded = default.AltAmmo - AltAmmo;
		if (AmmoNeeded > Ammo[1].AmmoAmount)
			AltAmmo +=Ammo[1].AmmoAmount;
		else
			AltAmmo = default.AltAmmo;   
		Ammo[1].UseAmmo (AmmoNeeded, True);
	}
}

// ===============================================
// Dual Code
// ===============================================
simulated function bool SlaveCanUseMode(int Mode)
{
	if(M806Pistol(OtherGun) != None)
		return (Mode == 0 || (Mode == 1 && Level.TimeSeconds >= FireMode[Mode].NextFireTime));

	return Mode == 0;
}

simulated function bool MasterCanSendMode(int Mode)
{
	if(M806Pistol(OtherGun) != None)
		return Mode < 2;

	return Mode == 0;
}

simulated function bool CanAlternate(int Mode)
{
	if (M806Pistol(OtherGun) == None && Mode != 0)
		return false;
	else if(M806Pistol(OtherGun) != None)
		return true;

	return super.CanAlternate(Mode);
}

// ================================================
// Laser Code
// ================================================
simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated function OnLaserSwitched()
{
	if (bLaserOn)
		ApplyLaserAim();
	else
		AimComponent.Recalculate();
}

simulated function OnAimParamsChanged()
{
	Super.OnAimParamsChanged();

	if (bLaserOn)
		ApplyLaserAim();
}

simulated function ApplyLaserAim()
{
	AimComponent.AimAdjustTime *= 0.65;
	AimComponent.AimSpread.Min *= 0.65;
	AimComponent.AimSpread.Max *= 0.65;
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != default.bLaserOn)
	{
		OnLaserSwitched();

		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

function ServerWeaponSpecial(optional byte i)
{
	if (bServerReloading || !bHasLaser)
		return;
	ServerSwitchLaser(!bLaserOn);
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	if (!bHasLaser)
		return;
	bLaserOn = bNewLaserOn;

	if (ThirdPersonActor!=None)
		M806Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

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

	if (!IsinState('DualAction') && !IsinState('PendingDualAction'))
		PlayIdle();
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && AIController(Instigator.Controller) != None && bHasLaser)
		ServerSwitchLaser(FRand() > 0.5);

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
		if (AltAmmo < 1)
			ReloadAltAnim = 'ReloadAltOpen';
		else
			ReloadAltAnim = 'ReloadAlt2Open';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
		if (AltAmmo < 1)
			ReloadAltAnim = 'ReloadAlt';
		else
			ReloadAltAnim = 'ReloadAlt2';
	}

	if ( ThirdPersonActor != None )
		M806Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'M806LaserDot',,,Loc);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			M806Attachment(ThirdPersonActor).bLaserOn = false;
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
	Super.Destroyed();
}

simulated function vector ConvertFOVs (vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Instigator.Location + Instigator.EyePosition();
	ViewRot = Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
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
	Loc = GetBoneCoords('tip2').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (!bStriking && ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(HitLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (!bStriking && ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip2');
		Laser.SetRotation(AimDir);
	}
	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	super.RenderOverlays(Canvas);
	if (!IsInState('Lowered'))
		DrawLaserSight(Canvas);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);
	
	if(Anim != 'MeleePrep')
		bStriking = false;
	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim || Anim == DualReloadAnim || Anim == DualReloadEmptyAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
			ReloadAltAnim = 'ReloadAltOpen';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
			ReloadAltAnim = 'ReloadAlt';
		}
	}
	Super.AnimEnd(Channel);
}

// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist, Result;

	if (!bHasShotgun)
		return 0;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AltAmmo < 1)
		return 0;
	if (MagAmmo < 1)
		return 1;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	if (Dist > 1700)
		return 0;

	Result = FRand()*0.5;

	Result += 1 - Dist / 1700;

	if (Result > 0.5)
		return 1;
	return 0;
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}
// End AI Stuff =====

defaultproperties
{
	AltAmmo=6
	ReloadAltAnim="ReloadAlt"
	DrumInSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOn',Volume=0.500000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.500000,bAtten=True)
	DrumOutSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOff',Volume=0.500000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.500000,bAtten=True)
	
	LaserOnSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	LaserOffSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.500000
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_M806'
	SightFXClass=Class'BallisticProV55.M806SightLEDs'
	
	bWT_Bullet=True
	bShouldDualInLoadout=True
	SpecialInfo(0)=(Info="0.0;8.0;-999.0;25.0;0.0;0.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Pullout',Volume=0.155000)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway',Volume=0.155000)
	CockSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806-Cock')
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806-ClipHit')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806-ClipIn')
	ClipInFrame=0.650000
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
           //Aligned
	bAdjustHands=true
	RootAdjust=(Yaw=-375,Pitch=3500)
	WristAdjust=(Yaw=-3500,Pitch=-000)

	ParamsClasses(0)=Class'M806WeaponParamsComp'
	ParamsClasses(1)=Class'M806WeaponParamsClassic'
	ParamsClasses(2)=Class'M806WeaponParamsRealistic'
    ParamsClasses(3)=Class'M806WeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.M806PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.M806SecondaryFire'
	MeleeFireClass=Class'BallisticProV55.M806MeleeFire'
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=192),StartSize1=61,StartSize2=101)
    NDCrosshairInfo=(SpreadRatios=(X1=0.750000,Y1=0.750000,X2=0.300000,Y2=0.300000))
	
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.600000
	CurrentRating=0.600000
	Description="M806 High Velocity Pistol||Manufacturer: Enravion Combat Solutions|Primary: Powerful single shot|Secondary: Toggle Laser Sight||The M806 is one of the few sidearms capable of making a full-grown Skrith whimper. Although long used by law enforcment organizations, military forces and ordinary civillians, it gained recognition when an elite commando unit was forced to use it on a difficult mission to disable a heavily armoured, Cryon infantry Division. Poor logistics planning left them with a wealth of ammo for the sidearm and little else, but the pistol was so effective in the mission it quickly grew in favour amongst the UTC Infantry Corps. The M806 is capable of massive damage when targetted at the right area and is a generally reliable, backup weapon. Use of a laser sight turns it into a real weapon by allowing the soldier to accurately direct its powerful bullets."
	Priority=19
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=8
	PickupClass=Class'BallisticProV55.M806Pickup'
	PlayerViewOffset=(X=0.00,Y=6.00,Z=-20.00)
	SightOffset=(X=-13.000000,Y=-4.2,Z=37.50000)
	SightPivot=(Pitch=-110,Roll=-675)   
	SightBobScale=2f
	AttachmentClass=Class'BallisticProV55.M806Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_M806'
	IconCoords=(X2=127,Y2=31)
	ItemName="M806A2 Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.M806_FPm'
	DrawScale=0.300000
}
