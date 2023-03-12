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
class Wrenchgun extends BallisticProShotgun;

var actor ReloadSteam;
var actor ReloadSteam2;

var() name				LastShellBone;		// Name of the right shell.
var   bool				bLastShell;			// Checks if only one shell is left
var   bool				bNowEmpty;			// Checks if it should play modified animation.

struct DeployableInfo
{
	var class<Actor> 	dClass;
	var float				WarpInTime;
	var vector				SpawnOffset;
	var float					CooldownDelay;
	var bool				CheckSlope; // should block unless placed on flat enough area
	var string				dDescription; 	//A simple explanation of what this mode does.
};

var DeployableInfo Deployables;

const DeployRange = 512;

var float	CooldownTime;

exec simulated function WeaponSpecial(optional byte i)
{
	if (bPreventReload || bServerReloading)
		return;
	ServerWeaponSpecial(i);
	ReloadState = RS_GearSwitch;
	PlayAnim('WrenchPoint');
}

function ServerWeaponSpecial(optional byte i)
{
	if (bPreventReload || bServerReloading)
		return;
	bServerReloading=True;
	ReloadState = RS_GearSwitch;
	PlayAnim('WrenchPoint');
}


function Notify_BarrierDeploy()
{
	local Actor HitActor;
	local Vector Start, End, HitNorm, HitLoc, DeployableZOffset;
	local WrenchGunPreconstructor WP;
	
	Start = Instigator.Location + Instigator.EyePosition();
	End = Start + vector(Instigator.GetViewRotation()) * DeployRange;
	
	HitActor = Trace(HitLoc, HitNorm, End, Start, true);
	
	if (HitActor == None)
		HitActor = Trace(HitLoc, HitNorm, End - vect(0,0,256), End, true);
		
	if (WrenchDeployable(HitActor) != None && WrenchDeployable(HitActor).OwningController == Instigator.Controller)
	{
		WrenchDeployable(HitActor).bWarpOut=True;
		WrenchDeployable(HitActor).GoToState('Destroying');
		return;
	}
		
	//Safety for mode switch during attack
	if (CooldownTime > level.TimeSeconds)
	{
		Instigator.ClientMessage("Barrier is still recharging.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
	
	if (HitActor == None || !HitActor.bWorldGeometry)
	{
		Instigator.ClientMessage("Must target an unoccupied surface.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
	
	if (HitLoc == vect(0,0,0))
	{
		Instigator.ClientMessage("Out of range.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
	
	if (Deployables.CheckSlope && HitNorm dot vect(0,0,1) < 0.1)
	{
		Instigator.ClientMessage("Surface is too steep for construction.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
	
	Start = HitLoc + vect(0,0,1);
	DeployableZOffset.Z = Deployables.dClass.default.CollisionHeight * 0.5;
	
	if (!FastTrace(Start + DeployableZOffset, Start + DeployableZOffset + Deployables.dClass.default.CollisionRadius * vect(1,0,0)) ||
	!FastTrace(Start + DeployableZOffset, Start + DeployableZOffset + Deployables.dClass.default.CollisionRadius * vect(-1,0,0)) ||
	!FastTrace(Start + DeployableZOffset, Start + DeployableZOffset + Deployables.dClass.default.CollisionRadius * vect(0,-1,0)) ||
	!FastTrace(Start + DeployableZOffset, Start + DeployableZOffset + Deployables.dClass.default.CollisionRadius * vect(0,1,0)))
	{
		Instigator.ClientMessage("Insufficient space for construction.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
		
	WP = Spawn(class'WrenchGunPreconstructor', Instigator, ,Start + vect(0,0,1) * Deployables.dClass.default.CollisionRadius, Instigator.Rotation);
	if (Deployables.SpawnOffset == vect(0,0,0))
		WP.GroundPoint = Start - vect(0,0,1);
	else WP.GroundPoint = Start + Deployables.SpawnOffset;
	WP.Instigator = Instigator;
	WP.Master = self;
	WP.Initialize(Deployables.dClass,Deployables.WarpInTime);
	CooldownTime = level.TimeSeconds + Deployables.CooldownDelay;
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
	if (anim == BFireMode[0].AimedFireAnim || anim == WrenchgunPrimaryFire(FireMode[0]).AimedFireEmptyAnim)
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

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 700)
		return 1;
	else if (Dist < 300)
		return 0;
	return Rand(2);
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	// Enemy too far away
	if (Dist > 750)
		Result = 0.1;
	else if (Dist < 300)
		Result += 0.06 * B.Skill;
	else if (Dist > 500)
		Result -= (Dist-700) / 1400;
	// If the enemy has a knife, this gun is handy
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result += 0.1 * B.Skill;
	// Sniper bad, very bad
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bSniping && Dist > 500)
		Result -= 0.4;

	return Result;
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
     LastShellBone="ShellR"
     Deployables=(dClass=Class'BWBP_APC_Pro.WrenchgunEnergyBarrier',WarpInTime=0.500000,CooldownDelay=2.000000,dDescription="A five-second barrier of infinite durability.")
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_CC_Tex.Wrenchgun.BigIcon_Wrenchgun'
     BigIconCoords=(Y1=35,Y2=225)
     bWT_Shotgun=True
     ManualLines(0)="Primary fires two shots with high power and moderate spread. Enemies hit by the shot bleed, dealing damage over time. Bleed duration is proportional to the number of pellets which struck the target.|Alternate fires two wrenches at the enemy. Don't plan on it really being useful but imagine if you do get the kill! Recoil is moderate with both modes."
     ManualLines(1)="Prepares a bludgeoning attack, which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. As a blunt attack, has lower base damage compared to bayonets but inflicts a short-duration blinding effect when striking. This attack inflicts more damage from behind."
     ManualLines(2)="Special deploys a five-second barrier of infinite durability."
     SpecialInfo(0)=(Info="160.0;10.0;0.3;40.0;0.0;1.0;0.0")
     MeleeFireClass=Class'BWBP_APC_Pro.WrenchgunMeleeFire'
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Putaway')
     CockAnimRate=0.700000
     ReloadAnimRate=1.100000
     ClipInFrame=0.800000
     bNonCocking=True
     WeaponModes(0)=(ModeName="Wrench. There is only Wrench.",Value=2.000000)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     SightPivot=(Pitch=256)
     SightOffset=(X=-40.000000,Y=12.000000,Z=43.000000)
     SightingTime=0.250000
     GunLength=60.000000
     LongGunPivot=(Pitch=6000,Yaw=-9000,Roll=2048)
     LongGunOffset=(X=-30.000000,Y=11.000000,Z=-20.000000)
     FireModeClass(0)=Class'BWBP_APC_Pro.WrenchgunPrimaryFire'
     FireModeClass(1)=Class'BWBP_APC_Pro.WrenchgunSecondaryFire'
     SelectAnimRate=2.000000
     PutDownAnimRate=2.000000
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc1',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(G=255,A=101),Color2=(G=0,R=0),StartSize1=92,StartSize2=82)
     NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
     NDCrosshairChaosFactor=0.600000
     AIRating=0.600000
     CurrentRating=0.600000
     Description="Deep in the mud filled trenches of Indorix Paraxii, the Carcosan Greasers, short on weapons and only days away from a full force Cryon advance, were desperate for a way to weather the impending invasion. A number of the soldiers were able to improvise a rather novel ammo, utilizing their surplus of pocket sized NFUD wrenches as a rather unconventional ammo type that proved to wreak absolute havoc on the mechanical elements of the Cryon soldiers, throwing a literal monkey wrench into their plan and rendering scores of them into immobile obstacles, effectively funneling the remaining grunts into narrow columns easily dispatched with some old fashioned trench guns. Furthermore, they further adapted their signature wrenches into makeshift bayonets, giving them easy access to their energy barriers without having to put down their main combat weapons."
     Priority=38
     HudColor=(B=35,G=100,R=200)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=7
     PickupClass=Class'BWBP_APC_Pro.WrenchgunPickup'
     PlayerViewOffset=(X=-10.000000,Y=20.000000,Z=-30.000000)
     AttachmentClass=Class'BWBP_APC_Pro.WrenchgunAttachment'
     IconMaterial=Texture'BWBP_SKC_Tex.CoachGun.SmallIcon_Coach'
     IconCoords=(X2=127,Y2=40)
     ItemName="Redwood Wrenchgun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=180.000000
     LightRadius=5.000000
	 ParamsClasses(0)=Class'WrenchgunWeaponParamsArena'
	 ParamsClasses(1)=Class'WrenchgunWeaponParamsClassic'
	 ParamsClasses(2)=Class'WrenchgunWeaponParamsRealistic'
     Mesh=SkeletalMesh'BWBP_CC_Anim.FPm_WrenchGun'
     DrawScale=1.250000
     Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
     Skins(1)=Texture'BWBP_SKC_Tex.CoachGun.DBL-Main'
     Skins(2)=Texture'BWBP_CC_Tex.Wrenchgun.WrenchShells'
     Skins(3)=Texture'BWBP_CC_Tex.Wrenchgun.WrenchShells'
     Skins(4)=Shader'BWBP_OP_Tex.Wrench.WrenchShader'
}
