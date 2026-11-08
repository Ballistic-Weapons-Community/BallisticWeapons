//=============================================================================
// BC_GameStyle_Config
//
// A game style with configurable properties.
//
// by Azarael
//=============================================================================
class BC_GameStyle_Config extends BC_GameStyle
    abstract
    config(BallisticProV55);

//=============================================================================
// WEAPON RULES
//=============================================================================
var() config float		SwayScale;			    	// Scales weapon sway
var() config float		RecoilScale;			    // Scales weapon recoil pattern (results in tighter pattern and lower apparent recoil)
var() config float 		RecoilShotScale;			// Scales weapon recoil per shot (results in slower progress along the pattern)
var() config float 		ReloadScale;				// Scales reload speed
var() config float		DamageScale;				// Scales anti-player damage
var() config float		VehicleDamageScale;			// Scales anti-vehicle damage
// The Weapons tab's advanced rules. A scale of 1 leaves a weapon as it is made
var() config float		MagazineScale;			// Scales magazine capacity
var() config float		AimSpeedScale;			// Scales how fast sights are raised and lowered
var() config float		FireRateScale;			// Scales how fast guns fire
var() config float		ShotgunSpreadScale;		// Scales the pellet spread of shotguns
var() config float		HeadshotScale;			// Scales the damage bonus of a head hit. 0 = none
var() config float		BlastRadiusScale;		// Scales the damage radius of explosives
var() config float		PenetrationScale;		// Scales how much wall and how many players a shot goes through
var() config bool		bWeaponsAffectMovement;	// A weapon slows or speeds up its holder and changes the height of jumps
var() config bool		bAimingSlowsMovement;	// Aiming down sights slows its holder
var() config bool		bLimbDamageReduction;	// A limb hit does less damage than a body hit
var() config bool		bDamageFalloff;			// Bullets lose damage over distance
var() config int		MaxInventoryCapacity;		// Maximum carrying capacity

//=============================================================================
// WEAPONS
//=============================================================================	
var() config bool		    bWeaponJumpOffsetting;		// Allows weapons to offset when sprinting or jumping
var() config bool		    bLongWeaponOffsetting;		// Causes weapons to offset when close to wall
var() config bool		    bNoReloading;			    // Disables reloading and weapons use boring old style ammo handling...
var() config bool           bAlternativePickups;	    // Press Use to Pickup Weapon

//=============================================================================
// PAWN
//=============================================================================
var() config bool			bUniversalMineLights;   // All BX-5 mines are lit.

//=============================================================================
// HEALTH
//=============================================================================
var() config bool			bHealthRegeneration;	// whether health regenerates
var() config int			StartingHealth;           // health the player starts with
var() config int			PlayerHealthMax;        // maximum health a player can have
var() config int			PlayerSuperHealthMax;   // maximum superhealth a player can have

//=============================================================================
// SHIELDS
//=============================================================================
var() config bool			bShieldRegeneration;	// whether shields regenerate
var() config int			StartingShield;           // armor the player starts with
var() config int			PlayerShieldMax;        // maximum armor the player can have

//=============================================================================
// MOVEMENT
//=============================================================================
var() config bool			bPlayerDeceleration;		// Decel mechanics when stopping
var() config bool			bAllowDodging;			    // Disables dodging.
var() config bool			bAllowDoubleJump;	        // Disables double jump.
var() config bool			bAllowCrouchSliding;		// Allows crouch sliding, which is a sprinting mechanic that allows players to slide while crouching.
var() config bool			bSlideJump;		// Jumping out of a slide keeps its speed and full jump height. A slide from any landing keeps the speed landed with, plus a third of the push
var() config bool			bLandIntoSlide;		// Landing with crouch held turns the fall into slide speed: along a downhill slope, and a little on flat ground after a long drop
var() config bool			bSlideSteering;		// The movement keys bend a slide's path a little, and the back key brakes it
var() config bool			bSlideToSprint;		// Letting go of crouch in a slide with the sprint key held goes straight into a sprint
//var() config bool			bWallRun;		// Jumping at a wall from a sprint runs along it for a moment on stamina. Jump again to kick off it
var() config float			PlayerStrafeScale;
var() config float			PlayerBackpedalScale;
var() config float			PlayerGroundSpeed;
var() config float			PlayerAirSpeed;
var() config float			PlayerAccelRate;
var() config float			PlayerJumpZ;
var() config float			PlayerDodgeSpeedFactor;
var() config float			PlayerDodgeZ;

//=============================================================================
// SPRINT
//=============================================================================
var() config bool			bEnableSprint;
var() config int			StaminaChargeRate;
var() config int			StaminaDrainRate;
var() config float			StaminaRechargeDelay; // Delay before stamina starts to recharge
var() config float			SprintSpeedFactor;
var() config float			JumpDrain;
var() config bool			bFireEndsSprint;		// Fire pressed in a sprint ends it, and the gun comes back to shoot. Off: it fires from where the sprint holds it
var() config bool			bSightsEndSprint;		// The sight key ends a sprint and the sights come up. Off: no sights until the sprint is over
var() config bool			bFirstPersonCrosshairAim;	// Players may have the crosshair follow the gun's aim in first person

//=============================================================================
// KILL REWARD
//=============================================================================
var() config int			HealthKillReward; // the amount of healthpoints a player gets for a kill
var() config int			KillRewardHealthMax;  // Limiter, The additional healthpoints wont exceel this value
var() config int			ShieldKillReward;  // armor points for a kill
var() config int			KillRewardShieldMax;  // Limiter, the additional armor points will not exceel this value

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
	rep.StaminaRechargeDelay		= default.StaminaRechargeDelay;
	rep.SprintSpeedFactor 			= default.SprintSpeedFactor;
	rep.JumpDrain 					= default.JumpDrain;
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
	bLongWeaponOffsetting=True
	bFireEndsSprint=False
	bFirstPersonCrosshairAim=True
	bSightsEndSprint=False
}