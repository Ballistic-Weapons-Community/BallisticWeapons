//=============================================================================
// Trench gun.
//
// Reworked by Azarael "Big Rael" Azarael
//=============================================================================
class TrenchGun extends BallisticProShotgun;

var byte                OldWeaponMode;
var actor               ReloadSteam;
var actor               ReloadSteam2;

var float               LastModeChangeTime;

var() Material          MatGreenShell;
var() Material          MatBlackShell;
var() name		        ShellTipBone1;		    // Super Slug 1.
var() name		        ShellTipBone2;		    // Super Slug 2
var() name		        ShellTipBone3;		    // Spare Super Slug 1.
var() name		        ShellTipBone4;		    // Spare Super Slug 2

var() name				LastShellBone;		    // Name of the right shell.
var   bool				bLastShell;			    // Checks if only one shell is left
var   bool				bNowEmpty;			    // Checks if it should play modified animation.

var() float				SingleReloadAnimRate;   // Animation rate for single reload.

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

var	TrenchGunFireControl	FireControl;

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

simulated function PostNetBeginPlay()
{
	local TrenchGunFireControl FC;

	super.PostNetBeginPlay();
	if (Role == ROLE_Authority && FireControl == None)
	{
		foreach DynamicActors (class'TrenchGunFireControl', FC)
		{
			FireControl = FC;
			return;
		}
		FireControl = Spawn(class'TrenchGunFireControl', None);
	}
}

function TrenchGunFireControl GetFireControl()
{
	return FireControl;
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
	if (ReloadState != RS_None || !HasAmmo() || FireMode[1].bIsFiring)
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
		PlayAnim('ReloadSingle', SingleReloadAnimRate, , 0.25);
	else					// Both shells fired
		PlayAnim('Reload', ReloadAnimRate, , 0.25);
}

// Returns true if gun will need reloading after a certain amount of ammo is consumed. Subclass for special stuff
simulated function bool MayNeedReload(byte Mode, float Load)
{
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
	if (anim == BFireMode[0].AimedFireAnim || anim == TrenchgunPrimaryFire(FireMode[0]).AimedFireEmptyAnim || anim == TrenchgunSecondaryFire(FireMode[1]).AimedFireAnim)
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
	local TrenchGunPreconstructor FSP;
	
	local Rotator SlopeInputYaw, SlopeRotation;

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
	/*if (AltDeployable.AmmoReq > Ammo[0].AmmoAmount)
	{
		Instigator.ClientMessage("Not enough charge to warp in"@WeaponModes[0].ModeName$".");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}*/
		
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
	
	// Use HitNormal value to attempt to reorient actor.
	SlopeInputYaw.Yaw = Instigator.Rotation.Yaw;
	SlopeRotation = GetSlopeRotator(SlopeInputYaw, HitNorm);
	
	Start = HitLoc + HitNorm; // offset from the floor by 1 unit, it's already normalized
	
	if (!SpaceToDeploy(HitLoc, HitNorm, SlopeRotation, AltDeployable.dClass.default.CollisionHeight, AltDeployable.dClass.default.CollisionRadius))
	{
		Instigator.ClientMessage("Insufficient space for construction.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
	
	SlopeRotation.Yaw = Instigator.Rotation.Yaw;
		
	FSP = Spawn(class'TrenchGunPreconstructor', Instigator, , Start + HitNorm * AltDeployable.dClass.default.CollisionRadius, SlopeRotation);
	
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

	if (class'BallisticReplicationInfo'.static.IsClassicOrRealism())
	{
		CurrentWeaponMode = 3;
		TrenchGunPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
	}
	
	if (Dist > 1024)
	{
		if (CurrentWeaponMode != 1)
		{
			CurrentWeaponMode = 1;
			TrenchGunPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		}
	}
	
	else if (CurrentWeaponMode != 0)
	{
		CurrentWeaponMode = 0;
		TrenchGunPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
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
		return FMin(1, FireMode[0].HoldTime / TrenchGunPrimaryFire(FireMode[0]).ChargeTime);
	return FMin(1, TrenchGunPrimaryFire(FireMode[0]).DecayCharge / TrenchGunPrimaryFire(FireMode[0]).ChargeTime);
}

defaultproperties
{
	MatGreenShell=Texture'BWBP_OP_Tex.TechWrench.ExplodoShell'
	MatBlackShell=Texture'BWBP_OP_Tex.TechWrench.ShockShell'
	ShellTipBone1="ShellLSuper"
	ShellTipBone2="ShellRSuper"
	ShellTipBone3="SpareShellLSuper"
	ShellTipBone4="SpareShellRSuper"
	LastShellBone="ShellR"
	FireAnimCutThreshold=3.000000
	AltDeployable=(dClass=Class'BWBP_OP_Pro.TrenchGunEnergyBarrier',WarpInTime=0.500000,SpawnOffset=52,CheckSlope=False,CooldownDelay=2.00) 
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_OP_Tex.TechGun.BigIcon_TechGun'
	BigIconCoords=(Y1=35,Y2=225)
	
	bWT_Shotgun=True
	bWT_Energy=True
	ManualLines(0)="Fire either a single barrel or both barrels of the loaded ammo type. Charge fire before releasing to fire both barrel simultaneously, tap to fire a single barrel. Electro Shot is capable of displacing targets' aim, with the effectiveness of this being increased by firing both barrels at once. Cryo Shot will temporarily slow targets hit by it, firing both rounds at once also increases the duration of this effect."
	ManualLines(1)="Prepares a bludgeoning attack, which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. As a blunt attack, has lower base damage compared to bayonets but inflicts a short-duration blinding effect when striking. This attack inflicts more damage from behind."
	ManualLines(2)="Effective at close ranges, firing both barrels at once increases the duration of the slow down for ice rounds and displacement from electric rounds."
	SpecialInfo(0)=(Info="160.0;10.0;0.3;40.0;0.0;1.0;0.0")
	MeleeFireClass=Class'BWBP_OP_Pro.TrenchGunMeleeFire'
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Putaway')
	CockAnimRate=0.700000
	SingleReloadAnimRate=1.000000
	ReloadAnimRate=1.250000
	ClipInFrame=0.800000
	bNonCocking=True
    bNoCrosshairInScope=True
	WeaponModes(0)=(ModeName="Ammo: Explosive",Value=1.000000)
	WeaponModes(1)=(ModeName="Ammo: Electro",Value=1.000000)
	WeaponModes(2)=(ModeName="Ammo: Cryogenic",Value=1.000000,bUnavailable=True)
	WeaponModes(3)=(ModeName="Ammo: FRAG-12",Value=1.000000,bUnavailable=True)
	WeaponModes(4)=(ModeName="Ammo: Dragon",Value=1.000000,bUnavailable=True)
	CurrentWeaponMode=0
	SightPivot=(Pitch=256)
	SightOffset=(X=50.000000,Y=11.500000,Z=43.500000)
    SightDisplayFov=25
	GunLength=60.000000
	LongGunPivot=(Pitch=6000,Yaw=-9000,Roll=2048)
	LongGunOffset=(X=-30.000000,Y=11.000000,Z=-20.000000)
	ParamsClasses(0)=Class'TrenchGunWeaponParams'
	ParamsClasses(1)=Class'TrenchGunWeaponParamsClassic'
	ParamsClasses(2)=Class'TrenchGunWeaponParamsRealistic'
    ParamsClasses(3)=Class'TrenchGunWeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_OP_Pro.TrenchGunPrimaryFire'
	FireModeClass(1)=Class'BWBP_OP_Pro.TrenchGunSecondaryFire'
	SelectAnimRate=2.000000
	PutDownAnimRate=2.000000
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc1',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=0,R=0,A=147),Color2=(B=255,G=255,R=255,A=255),StartSize1=96,StartSize2=72)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	AIRating=0.800000
	CurrentRating=0.800000
	Description="BR-112 Trenchgun || Manufacturer: N/A, field modified || Deep in the mud filled trenches of Indorix Paraxii and only days away from a full force Cryon and Skrith invasion, the Carcosan Greasers were desperate for a way to weather the impending invasion. Supply errors left them with little more than a surplus of specialized shotgun ammo that was not able to reliably feed into their standard issue shotguns. Ever resourceful, the Carcosan Greasers were able to improvise, and between scavanging as many civilian shotguns as they can and fabricating the rest with their on site nano-forges, they were able to outfit their company with reliable, light weight breach loaded shotguns well adapted to run whatever ammo type they could throw in them. They proceeded to hold the invasion off long enough for the area to be evacuated, holding off weapons fire with their iconic NFUD wrenches being used in tandem with their specialized shotguns, wreaking havoc to the systems of the Cryon with their electroshot and freezing the Skrith where they stood."
	Priority=38
	HudColor=(B=35,G=100,R=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=7
	PickupClass=Class'BWBP_OP_Pro.TrenchGunPickup'
	PlayerViewOffset=(X=-50.000000,Y=20.000000,Z=-30.000000)
	AttachmentClass=Class'BWBP_OP_Pro.TrenchGunAttachment'
	IconMaterial=Texture'BWBP_OP_Tex.TechGun.Icon_TechGun'
	IconCoords=(X2=127,Y2=30)
	ItemName="BR-112 Trenchgun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=25
	LightSaturation=150
	LightBrightness=180.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BWBP_OP_Anim.Fpm_Trenchgun'
	DrawScale=1.250000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Shader'BWBP_OP_Tex.TechWrench.TechWrenchShiny'
	Skins(2)=Texture'BWBP_OP_Tex.TechWrench.CryoShell'
	Skins(3)=Texture'BWBP_OP_Tex.TechWrench.CryoShell'
	Skins(4)=Shader'BWBP_OP_Tex.TechWrench.WrenchShiny'
	bShowChargingBar=True
}