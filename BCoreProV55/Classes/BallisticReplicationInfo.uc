//=============================================================================
// BallisticReplicationInfo.
//
// Special global replication actor for transmitting server-side globals to all
// clients.
// This is spawned at the beginning of the match by mutator, then it is
// replicated to all clients. Client then copies the values of all the varibles
// to its defaults. After that, all actors client side can see what the server
// has set by reading the defaults of this class.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticReplicationInfo extends ReplicationInfo 
	DependsOn(BC_GameStyle)
    config(BallisticProV55);

//=============================================================================
// STYLE
//=============================================================================
var BC_GameStyle.EGameStyle	GameStyle;				

//=============================================================================
// WEAPONS
//=============================================================================
var float					AccuracyScale;				// Used for scaling general weapon accuracy.
var float					RecoilScale;				// Used for scaling general weapon recoil.
var float					DamageScale;				// Scales anti-player weapon damage
var float					VehicleDamageScale;			// Scales anti-vehicle weapon damage
var bool		    		bWeaponJumpOffsetting;		// Allows weapons to offset when sprinting or jumping
var bool		    		bLongWeaponOffsetting;		// Causes weapons to offset when close to wall
var bool		    		bNoReloading;				// Disables reloading and weapons use boring old style ammo handling...
var int						MaxInventoryCapacity;		// Maximum inventory size player can hold

//=============================================================================
// GAMEPLAY
//=============================================================================
var bool         			bAlternativePickups;		// Press Use to Pickup Weapon
var bool					bUniversalMineLights;   	// All BX5 mines are lit.

//=============================================================================
// PAWN
//=============================================================================
var bool					bBrightPlayers;		    	// Players have ambient glow to glow in the dark like the standard pawns.
var int						StartingHealth;           	// health the player starts with
var int						PlayerHealthMax;        	// maximum health a player can have
var int						PlayerSuperHealthMax;   	// maximum superhealth a player can have
var int						StartingShield;           	// armor the player starts with
var int						PlayerShieldMax;        	// maximum armor the player can have

//=============================================================================
// MOVEMENT OVERRIDE
//=============================================================================
var bool					bPlayerDeceleration;		// Decel mechanics when stopping
var bool					bAllowDodging;				// Enables dodging.
var bool					bAllowDoubleJump;			// Enables double jump.
var float					PlayerWalkSpeedFactor;
var float					PlayerCrouchSpeedFactor;
var float					PlayerAnimationGroundSpeed;
var float					PlayerStrafeScale;
var float					PlayerBackpedalScale;
var float					PlayerGroundSpeed;
var float					PlayerAirSpeed;
var float					PlayerAccelRate;
var float					PlayerJumpZ;
var float					PlayerDodgeZ;
//=============================================================================
// SPRINT
//=============================================================================
var() config bool			bEnableSprint;
var() config int			StaminaChargeRate;
var() config int			StaminaDrainRate;
var() config float			SprintSpeedFactor;
var() config float			JumpDrainFactor;

//=============================================================================
// HEALTH/ARMOR - NO REP
//=============================================================================
var bool					bHealthRegeneration;
var bool					bShieldRegeneration;
var int						HealthKillReward; // the amount of healthpoints a player gets for a kill
var int						KillRewardHealthMax;  // Limiter, The additional healthpoints wont exceel this value
var int						ShieldKillReward;  // armor points for a kill
var int						KillRewardShieldMax;  // Limiter, the additional armor points will not exceel this value
//=============================================================================
// STYLE - NO REP
//=============================================================================
var bool					bKillstreaks;

//=============================================================================
// REPLICATION STRUCTURES
// to avoid the default comparison skipping the rep
//=============================================================================

//=============================================================================
// STYLE
//=============================================================================
var struct GeneralRep
{
	var BC_GameStyle.EGameStyle	GameStyle;				
	var float					AccuracyScale;				// Used for scaling general weapon accuracy.
	var float					RecoilScale;				// Used for scaling general weapon recoil.
	var float					DamageScale;				// Scales anti-player weapon damage
	var float					VehicleDamageScale;			// Scales anti-vehicle weapon damage
	var bool		    		bWeaponJumpOffsetting;		// Allows weapons to offset when sprinting or jumping
	var bool		    		bLongWeaponOffsetting;		// Causes weapons to offset when close to wall
	var bool		    		bNoReloading;				// Disables reloading and weapons use boring old style ammo handling...
	var int						MaxInventoryCapacity;		// Maximum inventory size player can hold
	var bool         			bAlternativePickups;		// Press Use to Pickup Weapon
	var bool					bUniversalMineLights;   	// All BX5 mines are lit.
} GRep;

var struct PawnRep
{
	var bool					bBrightPlayers;		    	// Players have ambient glow to glow in the dark like the standard pawns.
	var int						StartingHealth;           	// health the player starts with
	var int						PlayerHealthMax;        	// maximum health a player can have
	var int						PlayerSuperHealthMax;   	// maximum superhealth a player can have
	var int						StartingShield;           	// armor the player starts with
	var int						PlayerShieldMax;        	// maximum armor the player can have
} PRep;

var struct MoveRep
{
	var bool					bPlayerDeceleration;		// Decel mechanics when stopping
	var bool					bAllowDodging;				// Enables dodging.
	var bool					bAllowDoubleJump;			// Enables double jump.
	var float					PlayerWalkSpeedFactor;
	var float					PlayerCrouchSpeedFactor;
	var float					PlayerAnimationGroundSpeed;
	var float					PlayerStrafeScale;
	var float					PlayerBackpedalScale;
	var float					PlayerGroundSpeed;
	var float					PlayerAirSpeed;
	var float					PlayerAccelRate;
	var float					PlayerJumpZ;
	var float					PlayerDodgeZ;
} MRep;

var struct SprintRep
{
	var() config bool			bEnableSprint;
	var() config int			StaminaChargeRate;
	var() config int			StaminaDrainRate;
	var() config float			SprintSpeedFactor;
	var() config float			JumpDrainFactor;
} SRep;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		GRep, PRep, MRep, SRep;
}

final function BindToReplication()
{
	Log("BallisticReplicationInfo: BindToReplication");

	GRep.GameStyle 						= GameStyle;

	GRep.AccuracyScale			        = AccuracyScale;
	GRep.RecoilScale			        = RecoilScale;
	GRep.DamageScale					= DamageScale;
	GRep.VehicleDamageScale				= VehicleDamageScale;
	
	GRep.bWeaponJumpOffsetting			= bWeaponJumpOffsetting;
	GRep.bLongWeaponOffsetting			= bLongWeaponOffsetting;
	GRep.bNoReloading					= bNoReloading;
	GRep.MaxInventoryCapacity			= MaxInventoryCapacity;
	GRep.bAlternativePickups 	        = bAlternativePickups;
	GRep.bUniversalMineLights          	= bUniversalMineLights;

	PRep.bBrightPlayers	            	= bBrightPlayers;
    PRep.StartingHealth      			= StartingHealth;
	PRep.PlayerHealthMax      			= PlayerHealthMax;
	PRep.PlayerSuperHealthMax      		= PlayerSuperHealthMax;
	PRep.StartingShield      			= StartingShield;
	PRep.PlayerShieldMax      			= PlayerShieldMax;

	MRep.bPlayerDeceleration			= bPlayerDeceleration;
    MRep.bAllowDodging		            = bAllowDodging;
	MRep.bAllowDoubleJump				= bAllowDoubleJump;
    MRep.PlayerWalkSpeedFactor      	= PlayerWalkSpeedFactor;
	MRep.PlayerCrouchSpeedFactor      	= PlayerCrouchSpeedFactor;
	MRep.PlayerAnimationGroundSpeed		= PlayerAnimationGroundSpeed;
    MRep.PlayerStrafeScale             	= PlayerStrafeScale;
	MRep.PlayerBackpedalScale          	= PlayerBackpedalScale;
	MRep.PlayerGroundSpeed            	= PlayerGroundSpeed;
	MRep.PlayerAirSpeed                	= PlayerAirSpeed;
	MRep.PlayerAccelRate               	= PlayerAccelRate;
    MRep.PlayerJumpZ                   	= PlayerJumpZ;
	MRep.PlayerDodgeZ                  	= PlayerDodgeZ;

	SRep.bEnableSprint					= true;
	SRep.StaminaChargeRate				= StaminaChargeRate;
	SRep.StaminaDrainRate				= StaminaDrainRate;
    SRep.SprintSpeedFactor				= SprintSpeedFactor;
	SRep.JumpDrainFactor				= JumpDrainFactor;
}

// Set all defaults to match server vars here
simulated function PostNetBeginPlay()
{
	if (Role == ROLE_Authority)
		return;

	BindFromReplication();

	BindDefaults();
}

simulated final function BindFromReplication()
{
	Log("BallisticReplicationInfo: BindFromReplication");

	GameStyle 						= GRep.GameStyle;

	AccuracyScale			    	= GRep.AccuracyScale;
	RecoilScale			        	= GRep.RecoilScale;
	DamageScale						= GRep.DamageScale;
	VehicleDamageScale				= GRep.VehicleDamageScale;
	
	bWeaponJumpOffsetting			= GRep.bWeaponJumpOffsetting;
	bLongWeaponOffsetting			= GRep.bLongWeaponOffsetting;
	bNoReloading					= GRep.bNoReloading;
	MaxInventoryCapacity			= GRep.MaxInventoryCapacity;
	bAlternativePickups 	        = GRep.bAlternativePickups;
	bUniversalMineLights          	= GRep.bUniversalMineLights;

	bBrightPlayers	            	= PRep.bBrightPlayers;
    StartingHealth      			= PRep.StartingHealth;
	PlayerHealthMax      			= PRep.PlayerHealthMax;
	PlayerSuperHealthMax      		= PRep.PlayerSuperHealthMax;
	StartingShield      			= PRep.StartingShield;
	PlayerShieldMax      			= PRep.PlayerShieldMax;

	bPlayerDeceleration				= MRep.bPlayerDeceleration;
    bAllowDodging		            = MRep.bAllowDodging;
	bAllowDoubleJump				= MRep.bAllowDoubleJump;
    PlayerWalkSpeedFactor      		= MRep.PlayerWalkSpeedFactor;
	PlayerCrouchSpeedFactor       	= MRep.PlayerCrouchSpeedFactor;
	PlayerAnimationGroundSpeed		= MRep.PlayerAnimationGroundSpeed;
    PlayerStrafeScale             	= MRep.PlayerStrafeScale;
	PlayerBackpedalScale          	= MRep.PlayerBackpedalScale;
	PlayerGroundSpeed             	= MRep.PlayerGroundSpeed;
	PlayerAirSpeed                	= MRep.PlayerAirSpeed;
	PlayerAccelRate               	= MRep.PlayerAccelRate;
    PlayerJumpZ                   	= MRep.PlayerJumpZ;
	PlayerDodgeZ                  	= MRep.PlayerDodgeZ;

	bEnableSprint					= true;
	StaminaChargeRate				= SRep.StaminaChargeRate;
	StaminaDrainRate				= SRep.StaminaDrainRate;
    SprintSpeedFactor				= SRep.SprintSpeedFactor;
	JumpDrainFactor					= SRep.JumpDrainFactor;
}

simulated final function BindDefaults()
{
	class.default.GameStyle 					= GameStyle;

	class.default.AccuracyScale			        = AccuracyScale;
	class.default.RecoilScale			        = RecoilScale;
	class.default.DamageScale					= DamageScale;
	class.default.VehicleDamageScale			= VehicleDamageScale;
	
	class.default.bWeaponJumpOffsetting			= bWeaponJumpOffsetting;
	class.default.bLongWeaponOffsetting			= bLongWeaponOffsetting;
	class.default.bNoReloading					= bNoReloading;
	class.default.MaxInventoryCapacity			= MaxInventoryCapacity;
	class.default.bAlternativePickups 	        = bAlternativePickups;
	class.default.bUniversalMineLights          = bUniversalMineLights;

	class.default.bBrightPlayers	            = bBrightPlayers;
    class.default.StartingHealth      			= StartingHealth;
	class.default.PlayerHealthMax      			= PlayerHealthMax;
	class.default.PlayerSuperHealthMax      	= PlayerSuperHealthMax;
	class.default.StartingShield      			= StartingShield;
	class.default.PlayerShieldMax      			= PlayerShieldMax;

	class.default.bPlayerDeceleration			= bPlayerDeceleration;
    class.default.bAllowDodging		            = bAllowDodging;
	class.default.bAllowDoubleJump				= bAllowDoubleJump;
    class.default.PlayerWalkSpeedFactor      	= PlayerWalkSpeedFactor;
	class.default.PlayerCrouchSpeedFactor       = PlayerCrouchSpeedFactor;
	class.default.PlayerAnimationGroundSpeed	= PlayerAnimationGroundSpeed;
    class.default.PlayerStrafeScale             = PlayerStrafeScale;
	class.default.PlayerBackpedalScale          = PlayerBackpedalScale;
	class.default.PlayerGroundSpeed             = PlayerGroundSpeed;
	class.default.PlayerAirSpeed                = PlayerAirSpeed;
	class.default.PlayerAccelRate               = PlayerAccelRate;
    class.default.PlayerJumpZ                   = PlayerJumpZ;
	class.default.PlayerDodgeZ                  = PlayerDodgeZ;

	class.default.bEnableSprint					= true;
	class.default.StaminaChargeRate				= StaminaChargeRate;
	class.default.StaminaDrainRate				= StaminaDrainRate;
    class.default.SprintSpeedFactor				= SprintSpeedFactor;
	class.default.JumpDrainFactor				= JumpDrainFactor;

	class.default.bHealthRegeneration			= bHealthRegeneration;
	class.default.bShieldRegeneration			= bShieldRegeneration;
	class.default.HealthKillReward				= HealthKillReward;
	class.default.KillRewardHealthMax			= KillRewardHealthMax;
	class.default.ShieldKillReward				= ShieldKillReward;
	class.default.KillRewardShieldMax			= KillRewardShieldMax;

	class.default.bKillstreaks					= bKillstreaks;

	Log("BallisticReplicationInfo: BindDefaults");

	Log("Accuracy Scale: "$AccuracyScale);
	Log("Recoil Scale: "$RecoilScale);
	Log("Sprint/Jump Weapon Offsetting: "$bWeaponJumpOffsetting);
	Log("Long Weapon Offsetting: "$bLongWeaponOffsetting);
	Log("Reloading: "$ !bNoReloading);
	Log("Bright Players: "$bBrightPlayers);
	Log("Dodging: "$bAllowDodging);
	Log("Double Jumping: "$bAllowDoubleJump);

	if (Role == ROLE_Authority)
		BindToReplication();
}

static function BallisticReplicationInfo GetInstance(actor A)
{
	local BallisticReplicationInfo BRI;

	foreach A.DynamicActors(class'BallisticReplicationInfo', BRI)
	{
		if (A != None)
			return BRI;
	}
	return None;
}

static final function bool IsArena()
{
    return default.GameStyle == GS_Pro;
}

static final function bool IsClassic()
{
    return default.GameStyle == GS_Classic;
}

static final function bool IsRealism()
{
    return default.GameStyle == GS_Realism;
}

static final function bool IsTactical()
{
    return default.GameStyle == GS_Tactical;
}

static final function bool IsClassicOrRealism()
{
    return IsClassic() || IsRealism();
}

static final function bool IsArenaOrTactical()
{
    return IsArena() || IsTactical();
}

defaultproperties
{
    RemoteRole=ROLE_SimulatedProxy
	bAlwaysRelevant=True

	// defaults used from pro, config styles will override them directly
	AccuracyScale=1
	RecoilScale=1
	DamageScale=1
	VehicleDamageScale=1

	bWeaponJumpOffsetting=True
	bLongWeaponOffsetting=False
	bNoReloading=False

	bAlternativePickups=False
	bUniversalMineLights=True

	bBrightPlayers=True
    StartingHealth=100
	PlayerHealthMax=100
	PlayerSuperHealthMax=200
	StartingShield=100
	PlayerShieldMax=200

    bAllowDodging=True
	bAllowDoubleJump=True
    PlayerWalkSpeedFactor=0.9
	PlayerCrouchSpeedFactor=0.45
    PlayerStrafeScale=1
	PlayerBackpedalScale=1
	PlayerGroundSpeed=260
	PlayerAirSpeed=260
	PlayerAccelRate=2048
    PlayerJumpZ=294
	PlayerDodgeZ=210
}
