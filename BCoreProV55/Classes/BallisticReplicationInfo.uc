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
var float					RecoilScale;				// Used for scaling weapon recoil patterns.
var float					RecoilShotScale;			// Used for scaling weapon recoil per shot.
var float					ReloadScale;				// Scales reload speeds
var float					DamageScale;				// Scales anti-player weapon damage
var float					VehicleDamageScale;			// Scales anti-vehicle weapon damage
var float					MagazineScale;				// Scales magazine capacity
var float					AimSpeedScale;				// Scales how fast sights are raised and lowered
var float					WeaponWeightScale;			// Scales how much a weapon slows (or speeds up) its holder. 0 = not at all
var float					AimMoveScale;				// Scales the extra slowdown while aiming down sights. 0 = none
var float					HeadshotScale;				// Scales the damage bonus of a head hit. 0 = none
var float					LimbScale;					// Scales the damage penalty of a limb hit. 0 = none
var float					DamageRangeScale;			// Scales the ranges over which damage falls off
var float					BlastRadiusScale;			// Scales the damage radius of explosives
var float					PenetrationScale;			// Scales how much wall and how many players a shot goes through
var float					RecoilRecoveryScale;		// Scales how fast recoil settles
var float					SpreadScale;				// Scales the spread of shots
var bool		    		bWeaponJumpOffsetting;		// Allows weapons to offset when sprinting or jumping
var bool		    		bLongWeaponOffsetting;		// Causes weapons to offset when close to wall
var bool		    		bNoReloading;				// Disables reloading and weapons use boring old style ammo handling...
var bool		    		bNoRandomCamo;			    // Disables camo and layout randomizer

//=============================================================================
// INVENTORY
//=============================================================================
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
var float					PlayerDodgeSpeedFactor;
var float					PlayerDodgeZ;
//=============================================================================
// SPRINT
//=============================================================================
var() config bool			bEnableSprint;
var() config int			StaminaChargeRate;
var() config int			StaminaDrainRate;
var() config float			StaminaRechargeDelay;
var() config float			SprintSpeedFactor;
var() config float			JumpDrain;
var bool					bFireEndsSprint;			// Fire pressed in a sprint ends it, and the gun comes back to shoot
var bool					bSightsEndSprint;			// The sight key ends a sprint and the sights come up

//=============================================================================
// CROUCH SLIDING
//=============================================================================
var() config bool					bAllowCrouchSliding;		// Allows crouch sliding, pretty self explainatory 

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
	var float					RecoilScale;				// Used for scaling weapon recoil patterns.
	var float					RecoilShotScale;			// Used for scaling weapon recoil per shot.
	var float					ReloadScale;				// Scales reload speeds.
	var float					DamageScale;				// Scales anti-player weapon damage
	var float					VehicleDamageScale;			// Scales anti-vehicle weapon damage
	var bool		    		bWeaponJumpOffsetting;		// Allows weapons to offset when sprinting or jumping
	var bool		    		bLongWeaponOffsetting;		// Causes weapons to offset when close to wall
	var bool		    		bNoReloading;				// Disables reloading and weapons use boring old style ammo handling...
	var bool		    		bNoRandomCamo;				// Disables camo and layout randomizer
	var int						MaxInventoryCapacity;		// Maximum inventory size player can hold
	var bool         			bAlternativePickups;		// Press Use to Pickup Weapon
	var bool					bUniversalMineLights;   	// All BX5 mines are lit.
} GRep;

// The Weapons tab's further scales
var struct WeaponRep
{
	var float					MagazineScale;
	var float					AimSpeedScale;
	var float					WeaponWeightScale;
	var float					AimMoveScale;
	var float					HeadshotScale;
	var float					LimbScale;
	var float					DamageRangeScale;
	var float					BlastRadiusScale;
	var float					PenetrationScale;
	var float					RecoilRecoveryScale;
	var float					SpreadScale;
} WRep;

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
	var() config bool			bAllowCrouchSliding;		// Allows crouch sliding, which is a sprinting mechanic that allows players to slide while crouching.
	var float					PlayerWalkSpeedFactor;
	var float					PlayerCrouchSpeedFactor;
	var float					PlayerAnimationGroundSpeed;
	var float					PlayerStrafeScale;
	var float					PlayerBackpedalScale;
	var float					PlayerGroundSpeed;
	var float					PlayerAirSpeed;
	var float					PlayerAccelRate;
	var float					PlayerJumpZ;
	var float					PlayerDodgeSpeedFactor;
	var float					PlayerDodgeZ;
} MRep;

var struct SprintRep
{
	var() config bool			bEnableSprint;
	var() config int			StaminaChargeRate;
	var() config int			StaminaDrainRate;
	var() config float 			StaminaRechargeDelay;
	var() config float			SprintSpeedFactor;
	var() config float			JumpDrain;
	var bool					bFireEndsSprint;
	var bool					bSightsEndSprint;
} SRep;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		GRep, PRep, MRep, SRep, WRep;
}

//=============================================================================
// The Weapons tab's further scales, as the weapon code applies them
//=============================================================================
// Rounds in a magazine. A weapon that has one keeps at least one round
static final function int ScaleMagAmmo(int Rounds)
{
	if (Rounds <= 0 || default.MagazineScale == 1.0)
		return Rounds;
	return Max(1, Round(Rounds * default.MagazineScale));
}

// A factor on its holder's speed (0.9 = a tenth slower): the scale is on how far it is from 1
static final function float ScaleSpeedFactor(float Factor, float Scale)
{
	return FMax(0.1, 1.0 - (1.0 - Factor) * Scale);
}

// Damage multipliers of head and limb hits: the scales are on the bonus and on the penalty
static final function float ScaleHeadMult(float Mult)
{
	return FMax(0.0, 1.0 + (Mult - 1.0) * default.HeadshotScale);
}

// A limb hit always does something: not under a tenth, unless the weapon itself says less
static final function float ScaleLimbMult(float Mult)
{
	return FMax(FMin(Mult, 0.1), 1.0 - (1.0 - Mult) * default.LimbScale);
}

// A time that a speed scale shortens
static final function float ScaleTime(float Time, float SpeedScale)
{
	return Time / FMax(SpeedScale, 0.1);
}

final function BindToReplication()
{
	Log("BallisticReplicationInfo: BindToReplication");

	GRep.GameStyle 						= GameStyle;

	GRep.AccuracyScale			        = AccuracyScale;
	GRep.RecoilScale			        = RecoilScale;
	GRep.RecoilShotScale			    = RecoilShotScale;
	GRep.ReloadScale			        = ReloadScale;
	GRep.DamageScale					= DamageScale;
	GRep.VehicleDamageScale				= VehicleDamageScale;

	WRep.MagazineScale				= MagazineScale;
	WRep.AimSpeedScale				= AimSpeedScale;
	WRep.WeaponWeightScale			= WeaponWeightScale;
	WRep.AimMoveScale				= AimMoveScale;
	WRep.HeadshotScale				= HeadshotScale;
	WRep.LimbScale					= LimbScale;
	WRep.DamageRangeScale			= DamageRangeScale;
	WRep.BlastRadiusScale			= BlastRadiusScale;
	WRep.PenetrationScale			= PenetrationScale;
	WRep.RecoilRecoveryScale			= RecoilRecoveryScale;
	WRep.SpreadScale					= SpreadScale;
	
	GRep.bWeaponJumpOffsetting			= bWeaponJumpOffsetting;
	GRep.bLongWeaponOffsetting			= bLongWeaponOffsetting;
	GRep.bNoReloading					= bNoReloading;
	GRep.bNoRandomCamo					= bNoRandomCamo;

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
	MRep.bAllowCrouchSliding			= bAllowCrouchSliding;
    MRep.PlayerWalkSpeedFactor      	= PlayerWalkSpeedFactor;
	MRep.PlayerCrouchSpeedFactor      	= PlayerCrouchSpeedFactor;
	MRep.PlayerAnimationGroundSpeed		= PlayerAnimationGroundSpeed;
    MRep.PlayerStrafeScale             	= PlayerStrafeScale;
	MRep.PlayerBackpedalScale          	= PlayerBackpedalScale;
	MRep.PlayerGroundSpeed            	= PlayerGroundSpeed;
	MRep.PlayerAirSpeed                	= PlayerAirSpeed;
	MRep.PlayerAccelRate               	= PlayerAccelRate;
    MRep.PlayerJumpZ                   	= PlayerJumpZ;
	MRep.PlayerDodgeSpeedFactor         = PlayerDodgeSpeedFactor;
	MRep.PlayerDodgeZ                  	= PlayerDodgeZ;

	SRep.bEnableSprint					= bEnableSprint;
	SRep.StaminaChargeRate				= StaminaChargeRate;
	SRep.StaminaDrainRate				= StaminaDrainRate;
	SRep.StaminaRechargeDelay			= StaminaRechargeDelay;
    SRep.SprintSpeedFactor				= SprintSpeedFactor;
	SRep.JumpDrain						= JumpDrain;
	SRep.bFireEndsSprint				= bFireEndsSprint;
	SRep.bSightsEndSprint				= bSightsEndSprint;

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
	RecoilShotScale			        = GRep.RecoilShotScale;
	ReloadScale			        	= GRep.ReloadScale;
	DamageScale						= GRep.DamageScale;
	VehicleDamageScale				= GRep.VehicleDamageScale;

	MagazineScale					= WRep.MagazineScale;
	AimSpeedScale					= WRep.AimSpeedScale;
	WeaponWeightScale				= WRep.WeaponWeightScale;
	AimMoveScale					= WRep.AimMoveScale;
	HeadshotScale					= WRep.HeadshotScale;
	LimbScale						= WRep.LimbScale;
	DamageRangeScale				= WRep.DamageRangeScale;
	BlastRadiusScale				= WRep.BlastRadiusScale;
	PenetrationScale				= WRep.PenetrationScale;
	RecoilRecoveryScale				= WRep.RecoilRecoveryScale;
	SpreadScale						= WRep.SpreadScale;
	
	bWeaponJumpOffsetting			= GRep.bWeaponJumpOffsetting;
	bLongWeaponOffsetting			= GRep.bLongWeaponOffsetting;
	bNoReloading					= GRep.bNoReloading;
	bNoRandomCamo					= GRep.bNoRandomCamo;

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
	bAllowCrouchSliding				= MRep.bAllowCrouchSliding;
    PlayerWalkSpeedFactor      		= MRep.PlayerWalkSpeedFactor;
	PlayerCrouchSpeedFactor       	= MRep.PlayerCrouchSpeedFactor;
	PlayerAnimationGroundSpeed		= MRep.PlayerAnimationGroundSpeed;
    PlayerStrafeScale             	= MRep.PlayerStrafeScale;
	PlayerBackpedalScale          	= MRep.PlayerBackpedalScale;
	PlayerGroundSpeed             	= MRep.PlayerGroundSpeed;
	PlayerAirSpeed                	= MRep.PlayerAirSpeed;
	PlayerAccelRate               	= MRep.PlayerAccelRate;
    PlayerJumpZ                   	= MRep.PlayerJumpZ;
	PlayerDodgeSpeedFactor        	= MRep.PlayerDodgeSpeedFactor;
	PlayerDodgeZ                  	= MRep.PlayerDodgeZ;

	bEnableSprint					= SRep.bEnableSprint;
	StaminaChargeRate				= SRep.StaminaChargeRate;
	StaminaDrainRate				= SRep.StaminaDrainRate;
	StaminaRechargeDelay			= SRep.StaminaRechargeDelay;
    SprintSpeedFactor				= SRep.SprintSpeedFactor;
	JumpDrain					= SRep.JumpDrain;
	bFireEndsSprint					= SRep.bFireEndsSprint;
	bSightsEndSprint				= SRep.bSightsEndSprint;
}

simulated final function BindDefaults()
{
	// Bodies stay ragdolls for as long as they lie there, and only a ragdoll takes hits. The stock limit of four
	// is soon used up. This runs on every machine: a server's own game and an offline one need it as clients do
	Level.MaxRagdolls 							= 100;

	class.default.GameStyle 					= GameStyle;

	class.default.AccuracyScale			        = AccuracyScale;
	class.default.RecoilScale			        = RecoilScale;
	class.default.RecoilShotScale			    = RecoilShotScale;
	class.default.ReloadScale			    	= ReloadScale;
	class.default.DamageScale					= DamageScale;
	class.default.VehicleDamageScale			= VehicleDamageScale;

	class.default.MagazineScale				= MagazineScale;
	class.default.AimSpeedScale				= AimSpeedScale;
	class.default.WeaponWeightScale			= WeaponWeightScale;
	class.default.AimMoveScale				= AimMoveScale;
	class.default.HeadshotScale				= HeadshotScale;
	class.default.LimbScale					= LimbScale;
	class.default.DamageRangeScale			= DamageRangeScale;
	class.default.BlastRadiusScale			= BlastRadiusScale;
	class.default.PenetrationScale			= PenetrationScale;
	class.default.RecoilRecoveryScale			= RecoilRecoveryScale;
	class.default.SpreadScale					= SpreadScale;
	
	class.default.bWeaponJumpOffsetting			= bWeaponJumpOffsetting;
	class.default.bLongWeaponOffsetting			= bLongWeaponOffsetting;
	class.default.bNoReloading					= bNoReloading;
	class.default.bNoRandomCamo					= bNoRandomCamo;
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
	class.default.bAllowCrouchSliding			= bAllowCrouchSliding;
    class.default.PlayerWalkSpeedFactor      	= PlayerWalkSpeedFactor;
	class.default.PlayerCrouchSpeedFactor       = PlayerCrouchSpeedFactor;
	class.default.PlayerAnimationGroundSpeed	= PlayerAnimationGroundSpeed;
    class.default.PlayerStrafeScale             = PlayerStrafeScale;
	class.default.PlayerBackpedalScale          = PlayerBackpedalScale;
	class.default.PlayerGroundSpeed             = PlayerGroundSpeed;
	class.default.PlayerAirSpeed                = PlayerAirSpeed;
	class.default.PlayerAccelRate               = PlayerAccelRate;
    class.default.PlayerJumpZ                   = PlayerJumpZ;
	class.default.PlayerDodgeSpeedFactor        = PlayerDodgeSpeedFactor;
	class.default.PlayerDodgeZ                  = PlayerDodgeZ;

	class.default.bEnableSprint					= bEnableSprint;
	class.default.StaminaChargeRate				= StaminaChargeRate;
	class.default.StaminaDrainRate				= StaminaDrainRate;
	class.default.StaminaRechargeDelay			= StaminaRechargeDelay;
    class.default.SprintSpeedFactor				= SprintSpeedFactor;
	class.default.JumpDrain				= JumpDrain;
	class.default.bFireEndsSprint				= bFireEndsSprint;
	class.default.bSightsEndSprint				= bSightsEndSprint;

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
	Log("Recoil Shot Scale: "$RecoilShotScale);
	Log("Reload Scale: "$ReloadScale);
	Log("Magazine "$MagazineScale$", aim speed "$AimSpeedScale$", weapon weight "$WeaponWeightScale$", aim move "$AimMoveScale$", headshot "$HeadshotScale$", limb "$LimbScale);
	Log("Damage range "$DamageRangeScale$", blast radius "$BlastRadiusScale$", penetration "$PenetrationScale$", recoil recovery "$RecoilRecoveryScale$", spread "$SpreadScale);
	Log("Sprint/Jump Weapon Offsetting: "$bWeaponJumpOffsetting);
	Log("Long Weapon Offsetting: "$bLongWeaponOffsetting);
	Log("Reloading: "$ !bNoReloading);
	Log("Camo Randomizer: "$ !bNoRandomCamo);
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
	RecoilShotScale=1
	ReloadScale=1
	DamageScale=1
	VehicleDamageScale=1
	MagazineScale=1
	AimSpeedScale=1
	WeaponWeightScale=1
	AimMoveScale=1
	HeadshotScale=1
	LimbScale=1
	DamageRangeScale=1
	BlastRadiusScale=1
	PenetrationScale=1
	RecoilRecoveryScale=1
	SpreadScale=1

	bWeaponJumpOffsetting=True
	bLongWeaponOffsetting=False
	bFireEndsSprint=False
	bSightsEndSprint=False
	bNoReloading=False
	bNoRandomCamo=True

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
	PlayerAnimationGroundSpeed=440
	PlayerGroundSpeed=440 //260
	PlayerAirSpeed=440 //260
	PlayerAccelRate=2048
    PlayerJumpZ=340
	PlayerDodgeSpeedFactor=1.5
	PlayerDodgeZ=210
}
