//=============================================================================
// Coach gun.
//
// Reworked by Azarael "Big Rael" Azarael
//=============================================================================
class SawnOffShotgun extends BallisticProShotgun HideDropDown CacheExempt;

var byte                OldWeaponMode;
var actor               ReloadSteam;
var actor               ReloadSteam2;

var bool bLeftLoaded;
var bool bRightLoaded;

var float               LastModeChangeTime;

var() Material          MatGreenShell;
var() Material          MatBlackShell;
var() name				ShellTipBone1;		// Super Slug 1.
var() name				ShellTipBone2;		// Super Slug 2
var() name				ShellTipBone3;		// Spare Super Slug 1.
var() name				ShellTipBone4;		// Spare Super Slug 2

var() name				LastShellBone;		// Name of the right shell.
var   bool				bLastShell;			// Checks if only one shell is left
var   bool				bNowEmpty;			// Checks if it should play modified animation.

var() float				SingleReloadAnimRate;   // Animation rate for single reload.

simulated event PreBeginPlay()
{
	super.PreBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsArena())
	{
		FireModeClass[1]=Class'BWBP_SKC_Pro.SawnOffSecondaryFire';
	}
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsArena())
	{
		SawnOffPrimaryFire(FireMode[0]).bFireOnRelease = false;
	}
}

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	
	if (CurrentWeaponMode == 1)
	{
		SetBoneScale (2, 1.0, ShellTipBone1);
		SetBoneScale (3, 1.0, ShellTipBone2);
		SetBoneScale (4, 1.0, ShellTipBone3);
		SetBoneScale (5, 1.0, ShellTipBone4);
		Skins[3]=MatBlackShell;
	}
	else
	{
		SetBoneScale (2, 0.0, ShellTipBone1);
		SetBoneScale (3, 0.0, ShellTipBone2);
		SetBoneScale (4, 0.0, ShellTipBone3);
		SetBoneScale (5, 0.0, ShellTipBone4);
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

    AnimBlendParams(1, 0);

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
	{
		PlayAnim('ReloadSingle', SingleReloadAnimRate, , 0.25);
		bLeftLoaded=true;
	}
	else					// Both shells fired
	{
		PlayAnim('Reload', ReloadAnimRate, , 0.25);
		bLeftLoaded=true;
		bRightLoaded=true;
	}
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
	if 
    (
        anim == BFireMode[0].AimedFireAnim || 
        anim == SawnOffPrimaryFire(FireMode[0]).AimedFireEmptyAnim || 
        anim == SawnOffPrimaryFire(FireMode[0]).AimedFireSingleAnim
    )
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
		Skins[3]=MatBlackShell;
	}
	else
	{
		SetBoneScale (2, 1.0, ShellTipBone1);
		SetBoneScale (3, 1.0, ShellTipBone2);
		SetBoneScale (4, 0.0, ShellTipBone3);
		SetBoneScale (5, 0.0, ShellTipBone4);
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
			Spawn(class'Brass_Shotgun', self,, Start, Instigator.GetViewRotation() + rot(8192,0,0));
		}
		else
		{
			Spawn(class'Brass_Shotgun', self,, Start, Instigator.GetViewRotation() + rot(8192,0,0));
			Spawn(class'Brass_Shotgun', self,, Start, Instigator.GetViewRotation() + rot(8192,0,0));
		}
	}
	if (CurrentWeaponMode == 1)
	{
		Skins[3]=MatBlackShell;
		SetBoneScale (2, 1.0, ShellTipBone1);
		SetBoneScale (3, 1.0, ShellTipBone2);
		SetBoneScale (4, 1.0, ShellTipBone3);
		SetBoneScale (5, 1.0, ShellTipBone4);
	}
	else
	{
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
			SawnOffPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		}
	}
	
	else if (CurrentWeaponMode != 0)
	{
		CurrentWeaponMode = 0;
		SawnOffPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
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
simulated function float ChargeBar()
{
	if (FireMode[0].bIsFiring)
		return FMin(1, FireMode[0].HoldTime / SawnOffPrimaryFire(FireMode[0]).ChargeTime);
	return FMin(1, SawnOffPrimaryFire(FireMode[0]).DecayCharge / SawnOffPrimaryFire(FireMode[0]).ChargeTime);
}

defaultproperties
{
    bLeftLoaded=True
    bRightLoaded=True
     MatGreenShell=Texture'BWBP_SKC_Tex.CoachGun.DBL-Misc'
     MatBlackShell=Texture'BWBP_SKC_Tex.CoachGun.DBL-MiscBlack'
     ShellTipBone1="ShellLSuper"
     ShellTipBone2="ShellRSuper"
     ShellTipBone3="SpareShellLSuper"
     ShellTipBone4="SpareShellRSuper"
     LastShellBone="ShellR"
     FireAnimCutThreshold=1.100000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SKC_Tex.TechSawnOff.BigIcon_SawnOff'
     //BigIconCoords=(Y1=35,Y2=225)
     bWT_Shotgun=True
     ManualLines(0)="Shot mode fires two shots with high power and moderate spread. Enemies hit by the shot bleed, dealing damage over time. Bleed duration is proportional to the number of pellets which struck the target.|Slug mode fires two slugs with long range and penetration. Recoil is moderate with both modes."
     ManualLines(1)="Prepares a bludgeoning attack, which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. As a blunt attack, has lower base damage compared to bayonets but inflicts a short-duration blinding effect when striking. This attack inflicts more damage from behind."
     ManualLines(2)="Effective at close to medium range depending on active mode."
     SpecialInfo(0)=(Info="160.0;10.0;0.3;40.0;0.0;1.0;0.0")
     MeleeFireClass=Class'BWBP_SKC_Pro.SawnOffMeleeFire'
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Putaway')
     CockAnimRate=0.700000
     SingleReloadAnimRate=1.500000
     ReloadAnimRate=1.000000
     ClipInFrame=0.800000
     bNonCocking=True
     WeaponModes(0)=(ModeName="Shot",Value=1.000000)
     WeaponModes(1)=(ModeName="Slug",Value=1.000000)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     SightOffset=(X=-40.000000,Y=12.000000,Z=40.000000)
     GunLength=60.000000
     LongGunPivot=(Pitch=6000,Yaw=-9000,Roll=2048)
	 LongGunOffset=(X=-30.000000,Y=11.000000,Z=-20.000000)
	 ParamsClasses(0)=Class'SawnOffWeaponParams'
	 ParamsClasses(1)=Class'SawnOffWeaponParamsClassic'
	 ParamsClasses(2)=Class'SawnOffWeaponParamsRealistic'
     FireModeClass(0)=Class'BWBP_SKC_Pro.SawnOffPrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc1',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(G=255,A=101),Color2=(G=0,R=0),StartSize1=92,StartSize2=82)
     NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
     NDCrosshairChaosFactor=0.600000
     SelectAnimRate=2.000000
     PutDownAnimRate=2.000000
     AIRating=0.800000
     CurrentRating=0.800000
     Description="Redwood Sawn-Off Shotgun||Manufacturer: Redwood Firearms|Primary: Double Barrel Shot|Secondary: Single Barrel Shot||The layers of caked blood and dirt are the only indication of the passing of time on this ancient weapon, once used by the ring leader of a now long gone gang in the old west. Having cut off most of the barrel, the owner found it much easier to conceal and found he could carry a second one, inspiring fear and false loyalty in those around him. Though he's gone, his weapon remains as formidable as it was then, firing 12 gauge buckshot rounds, either in pairs or single shot. Without most of its barrel, the ease of use due to being much lighter is readily apparent, even in the hands of an amateur. Still packs one hell of a kick."
     Priority=38
     HudColor=(B=35,G=100,R=200)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
	 GroupOffset=16
     PickupClass=Class'BWBP_SKC_Pro.SawnOffPickup'
     PlayerViewOffset=(X=-10.000000,Y=20.000000,Z=-30.000000)
     AttachmentClass=Class'BWBP_SKC_Pro.SawnOffAttachment'
     IconMaterial=Texture'BWBP_SKC_Tex.TechSawnOff.SmallIcon_SawnOff'
     IconCoords=(X2=127,Y2=38)
     ItemName="Redwood Sawn Off"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=180.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_ScifiSawnOff'
     DrawScale=1.250000
     bShowChargingBar=True
	 Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BWBP_SKC_Tex.TechSawnOff.mat_doublebarrel_2D_View'
	 Skins(2)=Texture'BWBP_SKC_Tex.TechSawnOff.DoubleBarrel_Main2_Tex'
	 Skins(3)=Texture'BWBP_SKC_Tex.TechSawnOff.DoubleBarrel_Main1_Tex'
}
