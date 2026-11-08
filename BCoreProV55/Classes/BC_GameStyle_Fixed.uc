//=============================================================================
// BC_GameStyle_Fixed
//
// A game style with non-configurable properties.
//
// by Azarael
//=============================================================================
class BC_GameStyle_Fixed extends BC_GameStyle
    abstract;

//=============================================================================
// WEAPON RULES
//=============================================================================
var() float		SwayScale;			    	// Scales weapon sway
var() float		RecoilScale;			    // Scales weapon recoil pattern (results in tighter pattern and lower apparent recoil)
var() float 		RecoilShotScale;			// Scales weapon recoil per shot (results in slower progress along the pattern)
var() float 		ReloadScale;				// Scales reload speed
var() float		DamageScale;				// Scales anti-player damage
var() float		VehicleDamageScale;			// Scales anti-vehicle damage
// The Weapons tab's advanced rules. A scale of 1 leaves a weapon as it is made
var() float		MagazineScale;			// Scales magazine capacity
var() float		AimSpeedScale;			// Scales how fast sights are raised and lowered
var() float		FireRateScale;			// Scales how fast guns fire
var() float		ShotgunSpreadScale;		// Scales the pellet spread of shotguns
var() float		HeadshotScale;			// Scales the damage bonus of a head hit. 0 = none
var() float		BlastRadiusScale;		// Scales the damage radius of explosives
var() float		PenetrationScale;		// Scales how much wall and how many players a shot goes through
var() bool		bWeaponsAffectMovement;	// A weapon slows or speeds up its holder and changes the height of jumps
var() bool		bAimingSlowsMovement;	// Aiming down sights slows its holder
var() bool		bLimbDamageReduction;	// A limb hit does less damage than a body hit
var() bool		bDamageFalloff;			// Bullets lose damage over distance
var() int		MaxInventoryCapacity;		// Maximum carrying capacity

//=============================================================================
// WEAPONS
//=============================================================================	
var() bool		    bWeaponJumpOffsetting;		// Allows weapons to offset when sprinting or jumping
var() bool		    bLongWeaponOffsetting;		// Causes weapons to offset when close to wall
var() bool		    bNoReloading;			    // Disables reloading and weapons use boring old style ammo handling...
var() bool          bAlternativePickups;	    // Press Use to Pickup Weapon

//=============================================================================
// PAWN
//=============================================================================
var() bool			bUniversalMineLights;   // All BX-5 mines are lit.

//=============================================================================
// HEALTH
//=============================================================================
var() bool			bHealthRegeneration;	// whether health regenerates
var() int			StartingHealth;           // health the player starts with
var() int			PlayerHealthMax;        // maximum health a player can have
var() int			PlayerSuperHealthMax;   // maximum superhealth a player can have

//=============================================================================
// SHIELDS
//=============================================================================
var() bool			bShieldRegeneration;	// whether shields regenerate
var() int			StartingShield;           // armor the player starts with
var() int			PlayerShieldMax;        // maximum armor the player can have

//=============================================================================
// MOVEMENT
//=============================================================================
var() bool			bPlayerDeceleration;		// Decel mechanics when stopping
var() bool			bAllowDodging;			    // Disables dodging.
var() bool			bAllowDoubleJump;	        // Disables double jump.
var() bool			bAllowCrouchSliding;		// Allows crouch sliding, which is a sprinting mechanic that allows players to slide while crouching.
var() bool			bSlideJump;		// Jumping out of a slide keeps its speed and full jump height. A slide from any landing keeps the speed landed with, plus a third of the push
var() bool			bLandIntoSlide;		// Landing with crouch held turns the fall into slide speed: along a downhill slope, and a little on flat ground after a long drop
var() bool			bSlideSteering;		// The movement keys bend a slide's path a little, and the back key brakes it
var() bool			bSlideToSprint;		// Letting go of crouch in a slide with the sprint key held goes straight into a sprint
//var() bool			bWallRun;		// Jumping at a wall from a sprint runs along it for a moment on stamina. Jump again to kick off it
var() float			PlayerStrafeScale;
var() float			PlayerBackpedalScale;
var() float			PlayerGroundSpeed;
var() float			PlayerAirSpeed;
var() float			PlayerAccelRate;
var() float			PlayerJumpZ;
var() float			PlayerDodgeSpeedFactor;
var() float			PlayerDodgeZ;

//=============================================================================
// SPRINT
//=============================================================================
var() bool			bEnableSprint;
var() int			StaminaChargeRate;
var() int			StaminaDrainRate;
var() float			StaminaRechargeDelay;
var() float			SprintSpeedFactor;
var() float			JumpDrain;
var() bool			bFireEndsSprint;		// Fire pressed in a sprint ends it, and the gun comes back to shoot. Off: it fires from where the sprint holds it
var() bool			bSightsEndSprint;		// The sight key ends a sprint and the sights come up. Off: no sights until the sprint is over
var() bool			bFirstPersonCrosshairAim;	// Players may have the crosshair follow the gun's aim in first person

//=============================================================================
// KILL REWARD
//=============================================================================
var() int			HealthKillReward; // the amount of healthpoints a player gets for a kill
var() int			KillRewardHealthMax;  // Limiter, The additional healthpoints wont exceed this value
var() int			ShieldKillReward;  // armor points for a kill
var() int			KillRewardShieldMax;  // Limiter, the additional armor points will not exceed this value

static protected function FillReplicationInfo(BallisticReplicationInfo rep)
{	
	// Weapon rules
	rep.AccuracyScale			= default.SwayScale;
	rep.RecoilScale				= default.RecoilScale;
	rep.RecoilShotScale			= default.RecoilShotScale;
	rep.ReloadScale				= default.ReloadScale;
	rep.DamageScale				= default.DamageScale;
	rep.VehicleDamageScale		= default.VehicleDamageScale;
	rep.MagazineScale			= default.MagazineScale;
	rep.AimSpeedScale			= default.AimSpeedScale;
	rep.FireRateScale			= default.FireRateScale;
	rep.ShotgunSpreadScale		= default.ShotgunSpreadScale;
	rep.HeadshotScale			= default.HeadshotScale;
	rep.BlastRadiusScale		= default.BlastRadiusScale;
	rep.PenetrationScale		= default.PenetrationScale;
	rep.bWeaponsAffectMovement	= default.bWeaponsAffectMovement;
	rep.bAimingSlowsMovement	= default.bAimingSlowsMovement;
	rep.bLimbDamageReduction	= default.bLimbDamageReduction;
	rep.bDamageFalloff			= default.bDamageFalloff;
	rep.MaxInventoryCapacity	= default.MaxInventoryCapacity;

	rep.bWeaponJumpOffsetting		= default.bWeaponJumpOffsetting;
	rep.bLongWeaponOffsetting		= default.bLongWeaponOffsetting;
	rep.bNoReloading				= default.bNoReloading;
	rep.bAlternativePickups 		= default.bAlternativePickups;

    rep.bBrightPlayers				= default.bBrightPlayers;
	rep.bUniversalMineLights 		= default.bUniversalMineLights;

	rep.bHealthRegeneration			= default.bHealthRegeneration;
	rep.StartingHealth 				= default.StartingHealth;
	rep.PlayerHealthMax 			= default.PlayerHealthMax;
	rep.PlayerSuperHealthMax 		= default.playerSuperHealthMax;

	rep.bShieldRegeneration			= default.bShieldRegeneration;
	rep.StartingShield 				= default.StartingShield;
	rep.PlayerShieldMax 			= default.PlayerShieldMax;

	rep.bPlayerDeceleration			= default.bPlayerDeceleration;
	rep.bAllowDodging				= default.bAllowDodging;
	rep.bAllowDoubleJump			= default.bAllowDoubleJump;
	rep.bAllowCrouchSliding			= default.bAllowCrouchSliding;
	rep.bSlideJump = default.bSlideJump;
	rep.bLandIntoSlide = default.bLandIntoSlide;
	rep.bSlideSteering = default.bSlideSteering;
	rep.bSlideToSprint = default.bSlideToSprint;
	//rep.bWallRun = default.bWallRun;
    rep.PlayerStrafeScale 			= default.PlayerStrafeScale;
	rep.PlayerBackpedalScale 		= default.PlayerBackpedalScale;
	rep.PlayerGroundSpeed 			= default.PlayerGroundSpeed;
	rep.PlayerAirSpeed 				= default.PlayerAirSpeed;
	rep.PlayerAccelRate 			= default.PlayerAccelRate;
    rep.PlayerJumpZ 				= default.PlayerJumpZ;
	rep.PlayerDodgeSpeedFactor		= default.PlayerDodgeSpeedFactor;
    rep.PlayerDodgeZ 				= default.PlayerDodgeZ;

	rep.bEnableSprint				= default.bEnableSprint;
	rep.StaminaChargeRate			= default.StaminaChargeRate;
	rep.StaminaDrainRate 			= default.StaminaDrainRate;
	rep.StaminaRechargeDelay 		= default.StaminaRechargeDelay;
	rep.SprintSpeedFactor 			= default.SprintSpeedFactor;
	rep.JumpDrain					= default.JumpDrain;
	rep.bFireEndsSprint				= default.bFireEndsSprint;
	rep.bSightsEndSprint			= default.bSightsEndSprint;
	rep.bFirstPersonCrosshairAim	= default.bFirstPersonCrosshairAim;

	rep.HealthKillReward			= default.HealthKillReward;
	rep.KillRewardHealthMax			= default.KillRewardHealthMax;
	rep.ShieldKillReward			= default.ShieldKillReward;
	rep.KillRewardShieldMax			= default.KillRewardShieldMax;
}

defaultproperties
{
	SwayScale=1.0f
	RecoilScale=1.0f
	RecoilShotScale=1.0f
	ReloadScale=1.0f
	DamageScale=1.0f
	VehicleDamageScale=1.0f
	MagazineScale=1.0f
	AimSpeedScale=1.0f
	FireRateScale=1.0f
	ShotgunSpreadScale=1.0f
	HeadshotScale=1.0f
	BlastRadiusScale=1.0f
	PenetrationScale=1.0f
	bWeaponsAffectMovement=True
	bAimingSlowsMovement=True
	bLimbDamageReduction=True
	bDamageFalloff=True
	MaxInventoryCapacity=0

	bWeaponJumpOffsetting=True
	bLongWeaponOffsetting=False
	bFireEndsSprint=True
	bFirstPersonCrosshairAim=True
	bSightsEndSprint=True
}