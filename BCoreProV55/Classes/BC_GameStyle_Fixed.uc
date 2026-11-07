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
var() bool			bWallRun;		// Jumping at a wall from a sprint runs along it for a moment on stamina. Jump again to kick off it
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
	rep.bWallRun = default.bWallRun;
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
	bWeaponJumpOffsetting=True
	bLongWeaponOffsetting=False
	bFireEndsSprint=True
	bFirstPersonCrosshairAim=True
	bSightsEndSprint=True
}