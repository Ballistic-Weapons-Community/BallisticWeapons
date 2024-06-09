//=============================================================================
// Coach gun.
//
// Reworked by Azarael "Big Rael" Azarael
//=============================================================================
class CoachGun extends BallisticProShotgun;

var() Sound		CoachOpenSound;		//Sounds for coach reloading
var() Sound		CoachCloseSound;		//
var() Sound		ShieldFailSound;

var byte                OldWeaponMode;
var actor               ReloadSteam;
var actor               ReloadSteam2;

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
var()	bool			bQuickLoad;			// Loads rapidly during fire anim

var	bool bRightLoaded;
var bool bLeftLoaded;

var() float				SingleReloadAnimRate;   // Animation rate for single reload.

var()	bool			bHasShield;
struct DeployableInfo
{
	var class<Actor> 	    dClass;
	var float				WarpInTime;
	var int					SpawnOffset;
	var bool				CheckSlope;     // should block unless placed on flat enough area
	var float				CoolDownDelay;
};

var DeployableInfo      AltDeployable;
const                   DeployRange = 512;
var float	            CooldownTime;

var	CoachGunFireControl	FireControl;

exec function Offset(int index, int value)
{
	if (Level.NetMode != NM_Standalone)
		return;

	AltDeployable.SpawnOffset = value;
}

replication
{
	reliable if (Role==ROLE_Authority)
		FireControl;
}


simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	bQuickLoad=false;
	bHasShield=false;
	
	if (InStr(WeaponParams.LayoutTags, "quickload") != -1) //reloads during fire anim, doom style
	{
		bQuickLoad=true;
	}
	
	if (InStr(WeaponParams.LayoutTags, "shield") != -1) //it.. can make shields? with magic?
	{
		bHasShield=true;
	}
}

simulated function PostNetBeginPlay()
{
	local CoachGunFireControl FC;

	super.PostNetBeginPlay();
	if (Role == ROLE_Authority && FireControl == None)
	{
		foreach DynamicActors (class'CoachGunFireControl', FC)
		{
			FireControl = FC;
			return;
		}
		FireControl = Spawn(class'CoachGunFireControl', None);
	}
}

function CoachGunFireControl GetFireControl()
{
	return FireControl;
}


/*simulated event PreBeginPlay()
{
	super.PreBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsClassicOrRealism())
	{
		FireModeClass[1]=Class'BWBP_SKC_Pro.CoachGunSecondaryFire';
	}
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsClassicOrRealism())
	{
		CoachGunPrimaryFire(FireMode[0]).bFireOnRelease = false;
	}
}*/
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

// Returns true if gun will need reloading after a certain amount of ammo is consumed. Subclass for special stuff
simulated function bool MayNeedReload(byte Mode, float Load)
{
	if (bQuickLoad)
		return bNeedReload;
	if (!bNoMag && BFireMode[Mode]!= None && BFireMode[Mode].bUseWeaponMag && (/*MagAmmo < 1 || */MagAmmo - Load < 1))
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
	if 
    (
        anim == BFireMode[0].AimedFireAnim || 
        anim == CoachGunPrimaryFire(FireMode[0]).AimedFireEmptyAnim || 
        anim == CoachGunPrimaryFire(FireMode[0]).AimedFireSingleAnim
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
		//Skins[3]=MatBlackShell;
	}
	else
	{
		SetBoneScale (2, 1.0, ShellTipBone1);
		SetBoneScale (3, 1.0, ShellTipBone2);
		SetBoneScale (4, 0.0, ShellTipBone3);
		SetBoneScale (5, 0.0, ShellTipBone4);
		//Skins[3]=MatGreenShell;
	}
}

// Notify for mid shot reload animations
simulated function Notify_StartFireReload()
{
	//if (HasNonMagAmmo(0))
	//{
		//DebugMessage("EmptyFire reload");
	//	ReloadState = RS_PreClipOut;
	//}
}

simulated function Notify_CoachOpen()	{	PlaySound(CoachOpenSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_CoachClose()		{	PlaySound(CoachCloseSound, SLOT_Misc, 0.5, ,64);	}

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

//place a shield if you're trenched up
exec simulated function WeaponSpecial(optional byte i)
{
	if (bHasShield)
	{
		Notify_BarrierDeploy();
	}
}

//===========================================================================
// OrientToSlope
//
// Returns a rotator with the correct Pitch and Roll values to orient the 
// deployable to the detected HitNormal.
//===========================================================================
function Rotator GetSlopeRotator(Rotator deploy_rotation_yaw, vector hit_normal)
{
	local float pitch_degrees, roll_degrees;
	local Rotator result;
	
	//log("GetSlopeRotator: Input yaw rotator: "$deploy_rotation_yaw$" HitNormal: "$hit_normal);
	
	// get hitnormal orientation as global coordinate relative to direction of deployable
	hit_normal = hit_normal << deploy_rotation_yaw;
	
	//log("GetSlopeRotator: Rotated HitNormal: "$hit_normal);
	
	// x value determines pitch adjustment and is equal to the sine of the pitch angle
	// if x is positive, we need to pitch down (negative)
	pitch_degrees = Asin(hit_normal.X) * 180/pi;
	
	//log("GetSlopeRotator: Pitch degrees: "$pitch_degrees);
	
	result.Pitch = -(pitch_degrees * (65536 / 360));
	
	// y factor is the same for roll, but directionality is a problem (I think right is positive)
	roll_degrees = Asin(hit_normal.Y) * 180/pi;
	
	//log("GetSlopeRotator: Roll degrees: "$roll_degrees);

	result.Roll = (roll_degrees * (65536 / 360));
	
	//log("GetSlopeRotator: Result: "$result);
		
	return result;
}

//===========================================================================
// XAVEDIT
// Notify_BarrierDeploy
//
// Responsible for spawning the pre-warp effect for any given deployable.
// Traces out from the view to hit something, then does an extent trace to check for room.
// If OK, spawns the pre-warp at the required height.
//===========================================================================
function Notify_BarrierDeploy()
{
	local Actor HitActor;
	local Vector Start, End, HitNorm, HitLoc;
	local CoachGunPreconstructor FSP;
	
	local Rotator SlopeInputYaw, SlopeRotation;

	Start = Instigator.Location + Instigator.EyePosition();
	End = Start + vector(Instigator.GetViewRotation()) * DeployRange;
	
	HitActor = Trace(HitLoc, HitNorm, End, Start, true);
	
	if (HitActor == None)
		HitActor = Trace(HitLoc, HitNorm, End - vect(0,0,256), End, true);
		
	if (CoachDeployable(HitActor) != None && CoachDeployable(HitActor).OwningController == Instigator.Controller)
	{
		CoachDeployable(HitActor).bWarpOut=True;
		CoachDeployable(HitActor).GoToState('Destroying');
		return;
	}
	
	//Safety for mode switch during attack
	/*if (AltDeployable.AmmoReq > Ammo[0].AmmoAmount)
	{
		Instigator.ClientMessage("Not enough charge to warp in"@WeaponModes[0].ModeName$".");
		PlayerController(Instigator.Controller).ClientPlaySound(ShieldFailSound, ,1);
		return;
	}*/
		
	if (CooldownTime > level.TimeSeconds)
	{
		Instigator.ClientMessage("Barrier is still recharging.");
		PlayerController(Instigator.Controller).ClientPlaySound(ShieldFailSound, ,1);
		return;
	}		
		
	if (HitActor == None || !HitActor.bWorldGeometry)
	{
		Instigator.ClientMessage("Must target an unoccupied surface.");
		PlayerController(Instigator.Controller).ClientPlaySound(ShieldFailSound, ,1);
		return;
	}
	
	if (HitLoc == vect(0,0,0))
	{
		Instigator.ClientMessage("Out of range.");
		PlayerController(Instigator.Controller).ClientPlaySound(ShieldFailSound, ,1);
		return;
	}
	
	// Use HitNormal value to attempt to reorient actor.
	SlopeInputYaw.Yaw = Instigator.Rotation.Yaw;
	SlopeRotation = GetSlopeRotator(SlopeInputYaw, HitNorm);
	
	Start = HitLoc + HitNorm; // offset from the floor by 1 unit, it's already normalized
	
	if (!SpaceToDeploy(HitLoc, HitNorm, SlopeRotation, AltDeployable.dClass.default.CollisionHeight, AltDeployable.dClass.default.CollisionRadius))
	{
		Instigator.ClientMessage("Insufficient space for construction.");
		PlayerController(Instigator.Controller).ClientPlaySound(ShieldFailSound, ,1);
		return;
	}
	
	SlopeRotation.Yaw = Instigator.Rotation.Yaw;
		
	FSP = Spawn(class'CoachGunPreconstructor', Instigator, , Start + HitNorm * AltDeployable.dClass.default.CollisionRadius, SlopeRotation);
	
	FSP.GroundPoint = Start + (HitNorm * (AltDeployable.SpawnOffset + AltDeployable.dClass.default.CollisionRadius));

	FSP.Instigator = Instigator;
	FSP.Master = self;
	FSP.Initialize(AltDeployable.dClass,AltDeployable.WarpInTime);
	CooldownTime = level.TimeSeconds + AltDeployable.CooldownDelay;
}

//===========================================================================
// SpaceToDeploy
//
// Verifies that there is enough room to spawn the given deployable.
// Traces out from the center in the X and Y directions, 
// corresponding to the collision cylinder.
// 
// Imperfect - but functional enough for this game
//===========================================================================
function bool SpaceToDeploy(Vector hit_location, Vector hit_normal, Rotator slope_rotation, float collision_height, float collision_radius)
{
	local Vector center_point;
	
	// n.b: collision height property is actually half the collision height - do not halve the input value
	center_point = hit_location + hit_normal * collision_height;
	
	return (
	FastTrace(center_point, center_point + collision_radius * (vect(1,0,0) >> slope_rotation)) &&
	FastTrace(center_point, center_point + collision_radius * (vect(-1,0,0) >> slope_rotation)) &&
	FastTrace(center_point, center_point + collision_radius * (vect(0,-1,0) >> slope_rotation)) &&
	FastTrace(center_point, center_point + collision_radius * (vect(0,1,0) >> slope_rotation))
	);
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
simulated function float ChargeBar()
{
	if (FireMode[0].bIsFiring)
		return FMin(1, FireMode[0].HoldTime / CoachGunPrimaryFire(FireMode[0]).ChargeTime);
	return FMin(1, CoachGunPrimaryFire(FireMode[0]).DecayCharge / CoachGunPrimaryFire(FireMode[0]).ChargeTime);
}

defaultproperties
{
     MatGreenShell=Texture'BWBP_SKC_Tex.CoachGun.DBL-Misc'
     MatBlackShell=Texture'BWBP_SKC_Tex.CoachGun.DBL-MiscBlack'
     ShellTipBone1="ShellLSuper"
     ShellTipBone2="ShellRSuper"
     ShellTipBone3="SpareShellLSuper"
     ShellTipBone4="SpareShellRSuper"
     LastShellBone="ShellR"
     FireAnimCutThreshold=1.100000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SKC_Tex.CoachGun.BigIcon_Coach'
     BigIconCoords=(Y1=35,Y2=225)
	 ShieldFailSound=Sound'BWBP_OP_Sounds.Wrench.EnergyStationError'
     
     bWT_Shotgun=True
     ManualLines(0)="Shot mode fires two shots with high power and moderate spread. Enemies hit by the shot bleed, dealing damage over time. Bleed duration is proportional to the number of pellets which struck the target.|Slug mode fires two slugs with long range and penetration. Recoil is moderate with both modes."
     ManualLines(1)="Prepares a bludgeoning attack, which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. As a blunt attack, has lower base damage compared to bayonets but inflicts a short-duration blinding effect when striking. This attack inflicts more damage from behind."
     ManualLines(2)="Effective at close to medium range depending on active mode."
     SpecialInfo(0)=(Info="160.0;10.0;0.3;40.0;0.0;1.0;0.0")
     MeleeFireClass=Class'BWBP_SKC_Pro.CoachGunMeleeFire'
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Pullout',Volume=0.218000)
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Putaway',Volume=0.216000)
     ClipInFrame=0.800000
	 CoachOpenSound=Sound'BW_Core_WeaponSound.leMat.LM-Open'
	 CoachCloseSound=Sound'BW_Core_WeaponSound.leMat.LM-Close'
	 ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Redwood-ShellIn')
	 ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Redwood-ShellOut')
     bNonCocking=True
     WeaponModes(0)=(ModeName="Ammo: Shot",Value=1.000000)
     WeaponModes(1)=(ModeName="Ammo: Slug",Value=1.000000)
     WeaponModes(2)=(ModeName="Ammo: Electro",Value=1.000000,bUnavailable=True)
     WeaponModes(3)=(ModeName="Ammo: Flame",Value=1.000000,bUnavailable=True)
     WeaponModes(4)=(ModeName="Ammo: Explosive",Value=1.000000,bUnavailable=True)
     WeaponModes(5)=(ModeName="Ammo: FRAG",Value=1.000000,bUnavailable=True)
     CurrentWeaponMode=0
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc1',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(G=255,A=101),Color2=(G=0,R=0),StartSize1=92,StartSize2=82)
     NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
     NDCrosshairChaosFactor=0.600000
     GunLength=60.000000
     LongGunPivot=(Pitch=6000,Yaw=-9000,Roll=2048)
	 LongGunOffset=(X=-30.000000,Y=11.000000,Z=-20.000000)
	 ParamsClasses(0)=Class'CoachWeaponParamsComp'
	 ParamsClasses(1)=Class'CoachWeaponParamsClassic'
	 ParamsClasses(2)=Class'CoachWeaponParamsRealistic' 
     ParamsClasses(3)=Class'CoachWeaponParamsTactical'
     FireModeClass(0)=Class'BWBP_SKC_Pro.CoachGunPrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.CoachGunSecondaryFire'
     SelectAnimRate=2.000000
     PutDownAnimRate=2.000000
	 SingleReloadAnimRate=1.0
     AIRating=0.800000
     CurrentRating=0.800000
     Description="This primitive artifact has managed to survive the passage of time. Behind it trails a brutal story of bloodshed and sacrifice. For every scar, a life taken; every gouge, a life saved."
     Priority=38
     HudColor=(B=35,G=100,R=200)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=7
     PickupClass=Class'BWBP_SKC_Pro.CoachGunPickup'

     PlayerViewOffset=(X=4.00,Y=4.50,Z=-7.00)
	 SightOffset=(X=-2.500000,Y=0,Z=1.2)

     AttachmentClass=Class'BWBP_SKC_Pro.CoachGunAttachment'
     IconMaterial=Texture'BWBP_SKC_Tex.CoachGun.SmallIcon_Coach'
     IconCoords=(X2=127,Y2=40)
     ItemName="Redwood Coach Gun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=180.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_CoachGun'
     DrawScale=0.3

     bShowChargingBar=True
	 Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
     Skins(1)=Shader'BWBP_SKC_Tex.CoachGun.Coach-MainShine'
     Skins(2)=Texture'BWBP_SKC_Tex.CoachGun.DBL-SawnBits'
     Skins(3)=Texture'BWBP_SKC_Tex.CoachGun.Coach-Misc'
}
