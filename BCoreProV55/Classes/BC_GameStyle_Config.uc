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
// INVENTORY
//=============================================================================	
var() config int			MaxInventoryCapacity;

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
var() config bool			bBrightPlayers;		    // Players have ambient glow to glow in the dark like the standard pawns.
var() config bool			bUniversalMineLights;   // All BX-5 mines are lit.

//=============================================================================
// HEALTH
//=============================================================================
var() config bool			bHealthRegeneration;	// whether health regenerates
var() config int			PlayerHealth;           // health the player starts with
var() config int			PlayerHealthMax;        // maximum health a player can have
var() config int			PlayerSuperHealthMax;   // maximum superhealth a player can have

//=============================================================================
// SHIELDS
//=============================================================================
var() config bool			bShieldRegeneration;	// whether shields regenerate
var() config int			PlayerShield;           // armor the player starts with
var() config int			PlayerShieldMax;        // maximum armor the player can have

//=============================================================================
// MOVEMENT
//=============================================================================
var() config bool			bPlayerDeceleration;		// Decel mechanics when stopping
var() config bool			bAllowDodging;			    // Disables dodging.
var() config bool			bAllowDoubleJump;	        // Disables double jump.
var() config float			PlayerWalkSpeedFactor;
var() config float			PlayerCrouchSpeedFactor;
var() config float			PlayerStrafeScale;
var() config float			PlayerBackpedalScale;
var() config float			PlayerGroundSpeed;
var() config float			PlayerAirSpeed;
var() config float			PlayerAccelRate;
var() config float			PlayerJumpZ;
var() config float			PlayerDodgeZ;

//=============================================================================
// KILL REWARD
//=============================================================================
var() config int			HealthKillReward; // the amount of healthpoints a player gets for a kill
var() config int			KillRewardHealthMax;  // Limiter, The additional healthpoints wont exceel this value
var() config int			ShieldKillReward;  // armor points for a kill
var() config int			KillRewardShieldMax;  // Limiter, the additional armor points will not exceel this value

static protected function FillReplicationInfo(BallisticReplicationInfo rep)

{	rep.MaxInventoryCapacity		= default.MaxInventoryCapacity;

	rep.bWeaponJumpOffsetting		= default.bWeaponJumpOffsetting;
	rep.bLongWeaponOffsetting		= default.bLongWeaponOffsetting;
	rep.bNoReloading				= default.bNoReloading;

	rep.bAlternativePickups 		= default.bAlternativePickups;

    rep.bBrightPlayers				= default.bBrightPlayers;
	rep.bUniversalMineLights 		= default.bUniversalMineLights;

	rep.bHealthRegeneration			= default.bHealthRegeneration;
	rep.PlayerHealth 				= default.PlayerHealth;
	rep.PlayerHealthMax 			= default.PlayerHealthMax;
	rep.PlayerSuperHealthMax 		= default.playerSuperHealthMax;

	rep.bShieldRegeneration			= default.bShieldRegeneration;
	rep.PlayerShield 				= default.PlayerShield;
	rep.PlayerShieldMax 			= default.PlayerShieldMax;

	rep.bPlayerDeceleration			= default.bPlayerDeceleration;
	rep.bAllowDodging				= default.bAllowDodging;
	rep.bAllowDoubleJump			= default.bAllowDoubleJump;
    rep.PlayerWalkSpeedFactor 		= default.PlayerWalkSpeedFactor;
    rep.PlayerCrouchSpeedFactor 	= default.PlayerCrouchSpeedFactor;
    rep.PlayerStrafeScale 			= default.PlayerStrafeScale;
	rep.PlayerBackpedalScale 		= default.PlayerBackpedalScale;
	rep.PlayerGroundSpeed 			= default.PlayerGroundSpeed;
	rep.PlayerAirSpeed 				= default.PlayerAirSpeed;
	rep.PlayerAccelRate 			= default.PlayerAccelRate;
    rep.PlayerJumpZ 				= default.PlayerJumpZ;
    rep.PlayerDodgeZ 				= default.PlayerDodgeZ;

	rep.HealthKillReward			= default.HealthKillReward;
	rep.KillRewardHealthMax			= default.KillRewardHealthMax;
	rep.ShieldKillReward			= default.ShieldKillReward;
	rep.KillRewardShieldMax			= default.KillRewardShieldMax;
}

defaultproperties
{
	// defaults here are used from classic
	Index=GS_Classic
	StyleName="Classic"
	bRunInADS=False

	// General
	MaxInventoryCapacity=12
    bAlternativePickups=False
	bUniversalMineLights=False

	// Pawn
	bBrightPlayers=False
    PlayerHealth=100
    PlayerHealthMax=100
    PlayerSuperHealthMax=200
    PlayerShield=0
	PlayerShieldMax=200

	// Movement
	bPlayerDeceleration=False
	bAllowDodging=True
	bAllowDoubleJump=True
	// this value is a fallback which is overridden by weapon ADS move factor,
	// and should be the highest possible ADS movement multiplier for your style
    PlayerWalkSpeedFactor=0.5
	PlayerCrouchSpeedFactor=0.35
    PlayerStrafeScale=1
    PlayerBackpedalScale=1
    PlayerGroundSpeed=360.000000
    PlayerAirSpeed=360.000000
    PlayerAccelRate=2048.000000
    PlayerJumpZ=256
    PlayerDodgeZ=170

    HealthKillReward=0
	KillRewardHealthMax=0
	ShieldKillReward=0
	KillRewardShieldMax=0
}