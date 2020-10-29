//=============================================================================
// LS-14 Laser Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
// Modified by Marc 'Sergeant Kelly' Moylan
// Scope code by Kaboodles
// Reloading code and handling change by Azarael, yaaaay!
//=============================================================================
class LS14Carbine extends BallisticWeapon;

var() Sound		GrenOpenSound;				//Sounds for rocket reloading
var() Sound		GrenLoadSound;				//
var() Sound		GrenCloseSound;				//

var   actor GLIndicator;
var() name		GrenadeLoadAnim;			//Anim for rocket reload
var() float		GrenadeLoadAnimRate;
var() name		SingleGrenadeLoadAnim;		//Anim for rocket reload loop
var() name		HatchOpenAnim;
var() float		HatchOpenAnimRate;
var() name		HatchCloseAnim;
var() float 	HatchCloseAnimRate;
var() Name		ShovelAnim;					//Anim to play after shovel loop ends
var() float		ShovelAnimRate;
var() int       Rockets;					//Rockets currently in the gun.
var() int       ConfigX;					//Rockets currently in the gun.
var() int      	ConfigY;					//Rockets currently in the gun.
var	bool		bHeatOnce;					//Used for playing a sound once.
var	bool		bBarrelsOnline;				//Used for alternating laser effect in attachment class.
var	bool		bIsReloadingGrenade;		//Are we loading grenades?
var	bool		bWantsToShoot;				//Are we interrupting reload?
var	bool		bOverloaded;				//You exploded it.
var float		lastModeChangeTime;

var() Material	StabBackTex;
var(Gfx) Color ChargeColor;
var(Gfx) vector RechargeOrigin;
var(Gfx) vector RechargeSize;


var actor HeatSteam;
var actor BarrelFlare;
var actor BarrelFlareSmall;
var actor VentCore;
var actor VentBarrel;
var actor CoverGlow;

struct RevInfo
{
	var() name	Shellname;
};
var() RevInfo	Shells[3];

replication
{
	// Things the server should send to the client.
	reliable if( bNetOwner && (Role==ROLE_Authority) )
		Rockets;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	LS14PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	//	Core Glow Effect
	if (CoverGlow != None)
		CoverGlow.Destroy();

    if (Instigator.IsLocallyControlled() && level.DetailMode >= DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    {
    	CoverGlow = None;
		class'BUtil'.static.InitMuzzleFlash (CoverGlow, class'LS14GlowFX', DrawScale, self, 'BarrelGlow');
	}
}


// Only skips for alternate reload
simulated function FirePressed(float F)
{
	if ((ReloadState == RS_Shovel) || (ReloadState == RS_PostShellIn))
	{
		ServerSkipReload();
		if (Level.NetMode == NM_Client)
			SkipReload();
	}
	if (!HasAmmo())
		OutOfAmmo();
	else if (bNeedReload && ClientState == WS_ReadyToFire)
	{
		// Removed and replaced by EmptyFire()
//		ServerStartReload();
	}
	else if (reloadState == RS_None && bNeedCock && MagAmmo > 0 && !IsFiring() && level.TimeSeconds > FireMode[0].NextfireTime)
	{
		CommonCockGun();
		if (Level.NetMode == NM_Client)
			ServerCockGun();
	}
}

//Skip reloading if fire is pressed in time
simulated function SkipReload()
{
	if (ReloadState == RS_Shovel || ReloadState == RS_PostShellIn)
	{//Leave shovel loop and go to EndShovel

		if (Rockets < 3)
			SetBoneScale(2, 0.0, Shells[2].ShellName);
		PlayShovelEnd();
		ReloadState = RS_EndShovel;
	}
	else if (ReloadState == RS_PreClipOut)
	{//skip reload if clip has not yet been pulled out
		ReloadState = RS_PostClipIn;
		SetAnimFrame(ClipInFrame);
	}
}


//Show little tiny rockets
simulated function DrawWeaponInfo(Canvas C)
{
	NewDrawWeaponInfo(C, 0.705*C.ClipY);
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local int i,Count;
	local float ScaleFactor2;

	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;

	Super.NewDrawWeaponInfo (C, YPos);
	
	DrawCrosshairs(C);
	
	if (bSkipDrawWeaponInfo)
		return;

	ScaleFactor = C.ClipX / 1600;
	// Draw the spare ammo amount
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	if (!bNoMag)
	{
		Temp = GetHUDAmmoText(0);
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		Temp = GetHUDAmmoText(1);
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
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

	ScaleFactor2 = 99 * C.ClipX/3200;
	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = class'HUD'.Default.WhiteColor;
	Count = Min(8,Rockets);
    	for( i=0; i<Count; i++ )
    	{
//		C.SetPos(C.ClipX - (0.5*i+1) * ScaleFactor2, YPos);
		C.SetPos(C.ClipX - (0.5*i+1) * ScaleFactor2, C.ClipY - 100 * ScaleFactor * class'HUD'.default.HudScale);
		C.DrawTile(Texture'BallisticRecolors3TexPro.LS14.LS14-RocketIcon', ScaleFactor2, ScaleFactor2, 0, 0, 128, 128);
	}
	if ( Rockets > 8 )
	{
		Count = Min(16,Rockets);
		for( i=8; i<Count; i++ )
		{
			C.SetPos(C.ClipX - (0.5*(i-8)+1) * ScaleFactor2, YPos - ScaleFactor2);
			C.DrawTile(Texture'BallisticRecolors3TexPro.LS14.LS14-RocketIcon', ScaleFactor2, ScaleFactor2, 174, 259, 46, 45);
		}
	}
}

simulated event RenderOverlays (Canvas Canvas)
{
	local float	ScaleFactor;

	if (!bScopeView)
	{
		WeaponRenderOverlays(Canvas);
		if (SightFX != None)
			RenderSightFX(Canvas);
		return;
	}
	else
	{
		SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
		SetRotation(Instigator.GetViewRotation());
	}
	ScaleFactor = Canvas.ClipX / 1600;

    if (ScopeViewTex != None) //Now resets gun variables
    {
		Canvas.ColorModulate.W = 1;
		if (CurrentWeaponMode == 1)
		{
	        Canvas.SetDrawColor(255,255,255,255);

        	Canvas.SetPos(Canvas.OrgX, Canvas.OrgY);
    		Canvas.DrawTile(Texture'BallisticRecolors3TexPro.LS14.LS14ScopeDbl', (Canvas.SizeX - Canvas.SizeY)/2, Canvas.SizeY, 0, 0, 1, 1024);

        	Canvas.SetPos((Canvas.SizeX - Canvas.SizeY)/2, Canvas.OrgY);
        	Canvas.DrawTile(Texture'BallisticRecolors3TexPro.LS14.LS14ScopeDbl', Canvas.SizeY, Canvas.SizeY, 0, 0, 1024, 1024);

        	Canvas.SetPos(Canvas.SizeX - (Canvas.SizeX - Canvas.SizeY)/2, Canvas.OrgY);
        	Canvas.DrawTile(Texture'BallisticRecolors3TexPro.LS14.LS14ScopeDbl', (Canvas.SizeX - Canvas.SizeY)/2, Canvas.SizeY, 0, 0, 1, 1024);
		}
		else if (CurrentWeaponMode == 2)
		{
			// We're in double mode
			Canvas.SetPos(Canvas.OrgX+ Canvas.OrgX/4, Canvas.OrgY + Canvas.OrgY/4);
			Canvas.SetDrawColor(255,255,255,255);
			Canvas.DrawTile(Texture'BallisticRecolors3TexPro.LS14.LS14ScopeDbl', 1024, 1024, 0, 0, 1024, 1024);
		}
		else
		{
	        Canvas.SetDrawColor(255,255,255,255);
		//Left Border
        	Canvas.SetPos(Canvas.OrgX, Canvas.OrgY);
    		Canvas.DrawTile(ScopeViewTex, (Canvas.SizeX - Canvas.SizeY)/2, Canvas.SizeY, 0, 0, 1, 1024);
		//Scope
        	Canvas.SetPos((Canvas.SizeX - Canvas.SizeY)/2, Canvas.OrgY);
        	Canvas.DrawTile(ScopeViewTex, Canvas.SizeY, Canvas.SizeY, 0, 0, 1024, 1024);
		//Right Border
        	Canvas.SetPos(Canvas.SizeX - (Canvas.SizeX - Canvas.SizeY)/2, Canvas.OrgY);
        	Canvas.DrawTile(ScopeViewTex, (Canvas.SizeX - Canvas.SizeY)/2, Canvas.SizeY, 0, 0, 1, 1024);
		}

		Canvas.Font = GetFontSizeIndex(Canvas, -2 + int(2 * class'HUD'.default.HudScale));

		if ((Canvas.ClipX/Canvas.ClipY) > 1.4)
		{
			Canvas.SetPos(Canvas.SizeX*0.549,Canvas.SizeY*0.689);
			Canvas.DrawText(Rockets, false);
		}
		else
		{
			Canvas.SetPos(Canvas.SizeX*0.56, Canvas.SizeY*0.7);
			Canvas.DrawText(Rockets $ "R", false);
		}

		if (BarrelFlare != None)	BarrelFlare.Destroy();
		if (BarrelFlareSmall != None)	BarrelFlareSmall.Destroy();
		bOverloaded=false;
	}
}

simulated event DrawElectro (Canvas C)
{
	// Draw Green Circle
	// Draw some panning lines
	C.SetPos(C.OrgX, C.OrgY);
	C.DrawTile(TexPanner'BallisticRecolors3TexPro.LS14.ElectroShock', C.SizeX, C.SizeY, 0, 0, 512, 512);
}

//===========================================================================
// ManageHeatInteraction
//
// Called from primary fire when hitting a target. Objects don't like having iterators used within them
// and may crash servers otherwise.
//===========================================================================
function int ManageHeatInteraction(Pawn P, int HeatPerShot)
{
	local LS14HeatManager HM;
	local int HeatBonus;
	
	foreach P.BasedActors(class'LS14HeatManager', HM)
		break;
	if (HM == None)
	{
		HM = Spawn(class'LS14HeatManager',P,,P.Location + vect(0,0,-30));
		HM.SetBase(P);
	}
	
	if (HM != None)
	{
		HeatBonus = HM.Heat;
		if (Vehicle(P) != None)
			HM.AddHeat(HeatPerShot/4);
		else HM.AddHeat(HeatPerShot);
	}
	
	return heatBonus;
}

simulated function UpdateGLIndicator()
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (LS14SecondaryFire(FireMode[1]).bLoaded)
	{
		if (GLIndicator == None)
			class'BUtil'.static.InitMuzzleFlash(GLIndicator, class'M50GLIndicator', DrawScale, self, 'tip');
	}
	else if (GLIndicator != None)
	{
		GLIndicator.Destroy();
		GLIndicator = None;
	}
}

// Notifys for greande loading sounds
simulated function LS14HatchOpen()	
{	
	PlaySound(GrenOpenSound, SLOT_Misc, 0.5, ,64);
}
simulated function LS14RocketsIn()		
{	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);	
	LS14SecondaryFire(FireMode[1]).bLoaded = true;	
	UpdateGLIndicator();    
	Rockets = 3;
	ReloadState = RS_PostClipIn;    	
}
simulated function LS14HatchClose()	
{	
	ReloadState = RS_EndShovel;
	PlaySound(GrenCloseSound, SLOT_Misc, 0.5, ,64); 
}

simulated function LS14RocketIn()		
{	
	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);	
	UpdateGLIndicator();    
	ReloadState = RS_PostShellIn;	
	if (Role == ROLE_Authority)
	{
		Rockets += 1;
		Ammo[1].UseAmmo (1, True);
	}
}

simulated function bool IsGrenadeLoaded()
{
	return LS14SecondaryFire(FireMode[1]).bLoaded;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (anim == SingleGrenadeLoadAnim)
	{
		IdleTweenTime=0.0;
		PlayIdle();
	}
	else
		IdleTweenTime=default.IdleTweenTime;

	if (ReloadState == RS_PostShellIn)
	{
		if (Rockets == 3 || Ammo[1].AmmoAmount == 0)
		{
			PlayShovelEnd();
			ReloadState = RS_EndShovel;
			return;
		}
		ReloadState = RS_Shovel;
		SetBoneScale(2, 1.0, Shells[2].ShellName);
		PlayShovelLoop();
		return;
	}
	Super.AnimEnd(Channel);
}

// Load in 3 grenades
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 3 || LS14SecondaryFire(FireMode[1]).bLoaded)
		return;

	if (ReloadState == RS_None)
	{
		PlayAnim(HatchOpenAnim, HatchOpenAnimRate, , 0);
		ReloadState = RS_PreClipOut;
	}
}

// Load in a grenade
simulated function LoadGrenadeLoop()
{
	if (Ammo[1].AmmoAmount < 1)
		return;
	if (ReloadState == RS_None)
	{
		PlayAnim(HatchOpenAnim, HatchOpenAnimRate, , 0);
		ReloadState = RS_StartShovel;
	}
}

simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	if (i == 1)
	{
		ReloadState = RS_StartShovel;
		PlayReloadAlt();
	}
	else
	{
		ReloadState = RS_PreClipOut;
		PlayReload();
	}

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(Default.SightingTime*Default.SightingTimeScale);
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
	SafePlayAnim(StartShovelAnim, StartShovelAnimRate, , 0, "RELOAD");
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
	if (Rockets < 3 && Ammo[1].AmmoAmount > 0)
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

simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode == 1)
		return FireCount < 1;
	return super.CheckWeaponMode(Mode);
}


simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (BarrelFlare != None)	BarrelFlare.Destroy();
		if (BarrelFlareSmall != None)	BarrelFlareSmall.Destroy();
	}
	bOverloaded=false;
	return false;
}
simulated function Destroyed()
{
	if (BarrelFlare != None)	BarrelFlare.Destroy();
	if (BarrelFlareSmall != None)	BarrelFlareSmall.Destroy();
	if (CoverGlow != None)
		CoverGlow.Destroy();
	super.Destroyed();
}

simulated function Notify_BrassOut()
{
}

function bool BotShouldReloadGrenade ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated event WeaponTick(float DT)
{
	local int i;
	super.WeaponTick(DT);

	if (LS14PrimaryFire(FireMode[0]).bSecondBarrel)
		bBarrelsOnline=true;
	if (AIController(Instigator.Controller) != None && !IsGrenadeLoaded()&& AmmoAmount(1) > 0 && BotShouldReloadGrenade() && !IsReloadingGrenade())
		LoadGrenade();

	if (Rockets<0)
		Rockets=0;
	for(i=2;i>(Rockets-1);i--)
	{
		if (ReloadState == RS_None)
		SetBoneScale(i, 0.0, Shells[i].ShellName);
	}
	for(i=0;i<Rockets;i++)
		SetBoneScale(i, 1.0, Shells[i].ShellName);
}

simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;
	if (AmmoAmount(1) < 1 || !IsGrenadeLoaded())
		return 0;
	else if (MagAmmo < 1)
		return 1;

	if (CurrentWeaponMode != 2)
		CurrentWeaponMode = 2;
	Dist = VSize(B.Enemy.Location - Instigator.Location);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	VDot = Normal(B.Enemy.Velocity) Dot Normal(Instigator.Location - B.Enemy.Location);

	Result = FRand()-0.3;
	// Too far for grenade
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	// Too close for grenade
	if (Dist < 500 &&  VDot > 0.3)
		result -= (500-Dist) / 1000;
	if (VSize(B.Enemy.Velocity) > 50)
	{
		// Straight lines
		if (Abs(VDot) > 0.8)
			Result += 0.1;
		// Enemy running away
		if (VDot < 0)
			Result -= 0.2;
		else
			Result += 0.2;
	}


	// Higher than enemy
//	if (Height < 0)
//		Result += 0.1;
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}

simulated function bool IsReloadingGrenade()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == SingleGrenadeLoadAnim)
 		return true;
	return false;
}

function bool CanAttack(Actor Other)
{
	if (!IsGrenadeLoaded())
	{
		if (IsReloadingGrenade())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadGrenade())
		{
			LoadGrenade();
			return false;
		}
	}
	return super.CanAttack(Other);
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 2048, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

function ServerSwitchWeaponMode(byte NewMode)
{
	super.ServerSwitchWeaponMode(NewMode);
	LS14Attachment(ThirdPersonActor).bDouble = bool(CurrentWeaponMode);
}

simulated function PlayShovelLoop()
{
	SetBoneScale(2, 1.0, Shells[2].ShellName);
	SafePlayAnim(ShovelAnim, ShovelAnimRate, 0.0, , "RELOAD");
}

defaultproperties
{
	ManualLines(0)="Single Fire mode fires one barrel at once for low damage, with good fire rate.||Double Fire fires both barrels, for moderate damage, with low fire rate.||Both modes heat up the target, causing subsequent shots to inflict greater damage. This effect on the target decays with time."
	ManualLines(1)="Launches miniature rockets. These rockets deal high damage and good radius damage. The rockets have a short period of low speed before igniting."
	ManualLines(2)="Effective at long range and against enemies using healing weapons and items."

	GrenOpenSound=Sound'BallisticSounds2.M50.M50GrenOpen'
	GrenLoadSound=Sound'BallisticSounds2.M50.M50GrenLoad'
	GrenCloseSound=Sound'BallisticSounds2.M50.M50GrenClose'
	GrenadeLoadAnim="RLLoad"
	GrenadeLoadAnimRate=1.500000
	SingleGrenadeLoadAnim="RLLoadLoop"
	HatchOpenAnim="RLLoadPrep"
	HatchOpenAnimRate=1.500000
	HatchCloseAnim="RLLoadEnd"
	HatchCloseAnimRate=1.500000
	ShovelAnim="RLLoadLoop"
	ShovelAnimRate=1.500000
	Rockets=3
	ChargeColor=(B=100,G=255,R=255,A=255)
	RechargeOrigin=(X=600.000000,Y=330.000000)
	RechargeSize=(X=10.000000,Y=-180.000000)
	Shells(0)=(ShellName="RocketThree")
	Shells(1)=(ShellName="RocketTwo")
	Shells(2)=(ShellName="RocketOne")
	TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BallisticRecolors3TexPro.LS14.BigIcon_LS14'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_Projectile=True
	bWT_Energy=True
	SpecialInfo(0)=(Info="240.0;15.0;1.1;90.0;1.0;0.0;0.3")
	BringUpSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-Select')
	PutDownSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-Deselect')
	CockSound=(Sound=Sound'BallisticSounds3.USSR.USSR-Cock')
	ReloadAnimRate=1.150000
	ClipHitSound=(Sound=Sound'BallisticSounds3.USSR.USSR-ClipHit')
	ClipOutSound=(Sound=Sound'BallisticSounds3.USSR.USSR-ClipOut')
	ClipInSound=(Sound=Sound'BallisticSounds3.USSR.USSR-ClipIn')
	ClipInFrame=0.650000
	StartShovelAnim="RLLoadPrep"
	StartShovelAnimRate=2.000000
	EndShovelAnim="RLLoadEnd"
	EndShovelAnimRate=2.000000
	WeaponModes(0)=(ModeName="Single Barrel",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000)
	WeaponModes(2)=(ModeName="Bot Firemode",bUnavailable=True)
	CurrentWeaponMode=0
	ZoomType=ZT_Logarithmic
	ScopeViewTex=Texture'BallisticRecolors3TexPro.LS14.LS14Scope'
	ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=20.000000
	bNoMeshInScope=True
	bNoCrosshairInScope=True
	SightPivot=(Pitch=600,Roll=-1024)
	SightOffset=(X=18.000000,Y=-8.500000,Z=22.000000)
	MinZoom=2.000000
	MaxZoom=4.000000
	ZoomStages=1
	GunLength=80.000000
	ParamsClass=Class'LS14WeaponParams'
	FireModeClass(0)=Class'BWBPRecolorsPro.LS14PrimaryFire'
	FireModeClass(1)=Class'BWBPRecolorsPro.LS14SecondaryFire'
	SelectAnimRate=1.500000
	PutDownAnimRate=2.000000
	PutDownTime=0.500000
	BringUpTime=0.400000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.800000
	CurrentRating=0.800000
	bSniping=True
	Description="LS-14 Laser Carbine||Manufacturer: UTC Defense Tech|Primary: Focused Photon Beam|Secondary: Mini Rockets"
	Priority=194
	HudColor=(B=255,G=150,R=100)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	GroupOffset=4
	PickupClass=Class'BWBPRecolorsPro.LS14Pickup'
	PlayerViewOffset=(X=-5.000000,Y=12.000000,Z=-15.000000)
	BobDamping=1.800000
	AttachmentClass=Class'BWBPRecolorsPro.LS14Attachment'
	IconMaterial=Texture'BallisticRecolors3TexPro.LS14.SmallIcon_LS14'
	IconCoords=(X2=127,Y2=31)
	ItemName="LS-14 Laser Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BallisticRecolors4AnimPro.LS14Carbine'
	DrawScale=0.300000
}
