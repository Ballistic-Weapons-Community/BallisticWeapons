//=============================================================================
// M290Shotgun.
//
// Big double barreled shotgun. Primary fires both barrels at once, secondary
// fires them seperately. Slower than M763 with less range and uses up ammo
// quicker, but has tons of damage at close range.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CoachGun extends BallisticProShotgun;

var byte OldWeaponMode;
var actor ReloadSteam;
var actor ReloadSteam2;

var float LastModeChangeTime;

var() Material          MatGreenShell;
var() Material          MatBlackShell;
var() name				ShellTipBone1;		// Super Slug 1.
var() name				ShellTipBone2;		// Super Slug 2
var() name				ShellTipBone3;		// Spare Super Slug 1.
var() name				ShellTipBone4;		// Spare Super Slug 2

var() name				LastShellBone;		// Name of the right shell.
var   bool				bLastShell;			// Checks if only one shell is left
var   bool				bNowEmpty;			// Checks if it should play modified animation.

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	
	if (CurrentWeaponMode == 1)
	{
		SetBoneScale (2, 1.0, ShellTipBone1);
		SetBoneScale (3, 1.0, ShellTipBone2);
		SetBoneScale (4, 1.0, ShellTipBone3);
		SetBoneScale (5, 1.0, ShellTipBone4);
		Skins[2]=MatBlackShell;
		Skins[3]=MatBlackShell;
	}
	else
	{
		SetBoneScale (2, 0.0, ShellTipBone1);
		SetBoneScale (3, 0.0, ShellTipBone2);
		SetBoneScale (4, 0.0, ShellTipBone3);
		SetBoneScale (5, 0.0, ShellTipBone4);
		Skins[2]=MatGreenShell;
		Skins[3]=MatGreenShell;
	}
}


// Cycle through the various weapon modes
function ServerSwitchWeaponMode (byte NewMode)
{
	if (ReloadState != RS_None || !HasAmmo())
		return;
	Super.ServerSwitchWeaponMode(NewMode);
	ServerStartReload(2);
}

//First this is run on the server
function ServerStartReload (optional byte i)
{
	local int m;

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (i != 2 && MagAmmo >= default.MagAmmo)
		return;

	if (Ammo[0].AmmoAmount < 1)
		return;

	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;
	CommonStartReload(i);	//Server animation
	ClientStartReload(i);	//Client animation
}

// Prepare to reload, set reload state, start anims. Called on client and server
simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	if (bShovelLoad)
		ReloadState = RS_StartShovel;
	else
		ReloadState = RS_PreClipOut;
	if (i == 2)
		PlayAnim('Reload', ReloadAnimRate, , 0.25);
	else
		PlayReload();

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

// Play different reload starting anims depending on the situation
simulated function PlayReload()
{
	if (MagAmmo == 1 && !bNowEmpty)		// One shell fired and both shells in
		PlayAnim('ReloadSingle', CockAnimRate, , 0.25);
	else					// Both shells fired
		PlayAnim('Reload', ReloadAnimRate, , 0.25);
}

// Returns true if gun will need reloading after a certain amount of ammo is consumed. Subclass for special stuff
simulated function bool MayNeedReload(byte Mode, float Load)
{
	if (!HasNonMagAmmo(0))
		return true;
	return bNeedReload;
}

simulated function bool CheckScope()
{
	if (level.TimeSeconds < NextCheckScopeTime)
		return true;

	NextCheckScopeTime = level.TimeSeconds + 0.25;
	
	//Coach should hold scope while reloading
	if ((Instigator.Controller.bRun == 0 && Instigator.Physics == PHYS_Walking) || (Instigator.Physics == PHYS_Falling && VSize(Instigator.Velocity) > Instigator.GroundSpeed * 1.5) || (SprintControl != None && SprintControl.bSprinting))
	{
		StopScopeView();
		return false;
	}
		
	return true;
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{

	if (anim == FireMode[0].FireAnim || (FireMode[1] != None && anim == FireMode[1].FireAnim) )
		bPreventReload=false;

	if (MeleeFireMode != None && anim == MeleeFireMode.FireAnim)
	{
		if (MeleeState == MS_StrikePending)
			MeleeState = MS_Pending;
		else MeleeState = MS_None;
		ReloadState = RS_None;
		if (Role == ROLE_Authority)
			bServerReloading=False;
		bPreventReload=false;
	}
	
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == CoachGunPrimaryFire(FireMode[0]).AimedFireEmptyAnim)
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
		if (Channel == 0 && (bNeedReload || ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))) && MeleeState < MS_Held)
			PlayIdle();
    }
	// End stuff from Engine.Weapon

	// Start Shovel ended, move on to Shovel loop
	if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// Shovel loop ended, start it again
	if (ReloadState == RS_PostShellIn)
	{
		if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1 )
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
		bNeedCock=false;
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

simulated function CommonSwitchWeaponMode (byte NewMode)
{
	Super.CommonSwitchWeaponMode(NewMode);
	
	if (NewMode == 1)
	{
		SetBoneScale (2, 0.0, ShellTipBone1);
		SetBoneScale (3, 0.0, ShellTipBone2);
		SetBoneScale (4, 1.0, ShellTipBone3);
		SetBoneScale (5, 1.0, ShellTipBone4);
		Skins[2]=MatGreenShell;
		Skins[3]=MatBlackShell;
	}
	else
	{
		SetBoneScale (2, 1.0, ShellTipBone1);
		SetBoneScale (3, 1.0, ShellTipBone2);
		SetBoneScale (4, 0.0, ShellTipBone3);
		SetBoneScale (5, 0.0, ShellTipBone4);
		Skins[2]=MatBlackShell;
		Skins[3]=MatGreenShell;
	}
}

simulated function Notify_CoachShellDown()
{
	local vector start;

	if (level.NetMode != NM_DedicatedServer)
	{
		Start = Instigator.Location + Instigator.EyePosition() + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), vect(5,10,-5));
		if (MagAmmo == 1)
		{
			Spawn(class'Brass_MRS138Shotgun', self,, Start, Instigator.GetViewRotation() + rot(8192,0,0));
		}
		else
		{
			Spawn(class'Brass_MRS138Shotgun', self,, Start, Instigator.GetViewRotation() + rot(8192,0,0));
			Spawn(class'Brass_MRS138Shotgun', self,, Start, Instigator.GetViewRotation() + rot(8192,0,0));
		}
	}
	if (CurrentWeaponMode == 1)
	{
		Skins[2]=MatBlackShell;
		Skins[3]=MatBlackShell;
		SetBoneScale (2, 1.0, ShellTipBone1);
		SetBoneScale (3, 1.0, ShellTipBone2);
		SetBoneScale (4, 1.0, ShellTipBone3);
		SetBoneScale (5, 1.0, ShellTipBone4);
	}
	else
	{
		Skins[2]=MatGreenShell;
		Skins[3]=MatGreenShell;
		SetBoneScale (2, 0.0, ShellTipBone1);
		SetBoneScale (3, 0.0, ShellTipBone2);
		SetBoneScale (4, 0.0, ShellTipBone3);
		SetBoneScale (5, 0.0, ShellTipBone4);
	}
	bLastShell = (Ammo[0].AmmoAmount == 1);
	if (bLastShell && MagAmmo != 1)
	{
		SetBoneScale(1, 0.0, LastShellBone);
		bNowEmpty=true;
	}
	else
		SetBoneScale(1, 1.0, LastShellBone);
}

simulated function Notify_CoachSteam()
{
	if (ReloadSteam != None)
		ReloadSteam.Destroy();

	if (ReloadSteam2 != None)
		ReloadSteam2.Destroy();

	if (MagAmmo == 1)
	{
		class'BUtil'.static.InitMuzzleFlash (ReloadSteam, class'CoachSteam', DrawScale, self, 'Ejector');
	}
	else if (MagAmmo == 0)
	{
		class'BUtil'.static.InitMuzzleFlash (ReloadSteam2, class'CoachSteam', DrawScale, self, 'Ejector');
		class'BUtil'.static.InitMuzzleFlash (ReloadSteam, class'CoachSteam', DrawScale, self, 'EjectorL');
	}

	if (bNowEmpty)
	{
		SetBoneScale(1, 0.0, LastShellBone);
		bNowEmpty=False;
	}

	if (ReloadSteam != None)
		ReloadSteam.SetRelativeRotation(rot(0,32768,0));
	if (ReloadSteam2 != None)
		ReloadSteam2.SetRelativeRotation(rot(0,32768,0));
}

simulated function Destroyed ()
{
	if (ReloadSteam != None)
		ReloadSteam.Destroy();
	if (ReloadSteam2 != None)
		ReloadSteam2.Destroy();

	super.Destroyed(); 
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;
		
	if (level.TimeSeconds - lastModeChangeTime < 1.4 - B.Skill*0.1)
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 1024)
	{
		if (CurrentWeaponMode != 1)
		{
			CurrentWeaponMode = 1;
			CoachGunPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		}
	}
	
	else if (CurrentWeaponMode != 0)
	{
		CurrentWeaponMode = 0;
		CoachGunPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
	}
	
	lastModeChangeTime = level.TimeSeconds;

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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.9, Dist, 1024, 6144); 
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

defaultproperties
{
     MatGreenShell=Texture'BallisticRecolors4TexPro.CoachGun.DBL-Misc'
     MatBlackShell=Texture'BallisticRecolors4TexPro.CoachGun.DBL-MiscBlack'
     ShellTipBone1="ShellLSuper"
     ShellTipBone2="ShellRSuper"
     ShellTipBone3="SpareShellLSuper"
     ShellTipBone4="SpareShellRSuper"
     LastShellBone="ShellR"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticRecolors4TexPro.CoachGun.BigIcon_Coach'
     BigIconCoords=(Y1=35,Y2=225)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Shotgun=True
     ManualLines(0)="Shot mode fires two shots with high power and moderate spread. Enemies hit by the shot bleed, dealing damage over time. Bleed duration is proportional to the number of pellets which struck the target.|Slug mode fires two slugs with long range and penetration. Recoil is moderate with both modes."
     ManualLines(1)="Prepares a bludgeoning attack, which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. As a blunt attack, has lower base damage compared to bayonets but inflicts a short-duration blinding effect when striking. This attack inflicts more damage from behind."
     ManualLines(2)="Effective at close to medium range depending on active mode."
     SpecialInfo(0)=(Info="160.0;10.0;0.3;40.0;0.0;1.0;0.0")
     MeleeFireClass=Class'BWBPRecolorsPro.CoachGunMeleeFire'
     BringUpSound=(Sound=Sound'BallisticSounds2.M290.M290Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M290.M290Putaway')
     CockAnimRate=0.700000
     ReloadAnimRate=1.100000
     ClipInFrame=0.800000
     bNonCocking=True
     WeaponModes(0)=(ModeName="Shot",Value=2.000000)
     WeaponModes(1)=(ModeName="Slug",Value=2.000000)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     SightPivot=(Pitch=256)
     SightOffset=(X=-40.000000,Y=12.000000,Z=40.000000)
     GunLength=60.000000
     LongGunPivot=(Pitch=6000,Yaw=-9000,Roll=2048)
	 LongGunOffset=(X=-30.000000,Y=11.000000,Z=-20.000000)
	 ParamsClass=Class'CoachWeaponParams'
     FireModeClass(0)=Class'BWBPRecolorsPro.CoachGunPrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectAnimRate=2.000000
     PutDownAnimRate=2.000000
     AIRating=0.800000
     CurrentRating=0.800000
     Description="This primitive artifact has managed to survive the passage of time. Behind it trails a brutal story of bloodshed and sacrifice. For every scar, a life taken; every gouge, a life saved."
     Priority=38
     HudColor=(B=35,G=100,R=200)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=7
     PickupClass=Class'BWBPRecolorsPro.CoachGunPickup'
     PlayerViewOffset=(X=-10.000000,Y=20.000000,Z=-30.000000)
     AttachmentClass=Class'BWBPRecolorsPro.CoachGunAttachment'
     IconMaterial=Texture'BallisticRecolors4TexPro.CoachGun.SmallIcon_Coach'
     IconCoords=(X2=127,Y2=40)
     ItemName="Redwood Coach Gun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=180.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.DoubleShotgun_FP'
     DrawScale=1.250000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticRecolors4TexPro.CoachGun.DBL-Main'
     Skins(2)=Texture'BallisticRecolors4TexPro.CoachGun.DBL-Misc'
     Skins(3)=Texture'BallisticRecolors4TexPro.CoachGun.DBL-Misc'
}
