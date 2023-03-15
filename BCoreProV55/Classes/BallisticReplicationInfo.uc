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
var float					DamageScale;				// Scales general weapon damage
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
var int						PlayerHealth;           	// health the player starts with
var int						PlayerHealthMax;        	// maximum health a player can have
var int						PlayerSuperHealthMax;   	// maximum superhealth a player can have
var int						PlayerShield;           	// armor the player starts with
var int						PlayerShieldMax;        	// maximum armor the player can have

//=============================================================================
// MOVEMENT OVERRIDE
//=============================================================================
var bool					bPlayerDeceleration;		// Decel mechanics when stopping
var bool					bAllowDodging;				// Enables dodging.
var bool					bAllowDoubleJump;			// Enables double jump.
var float					PlayerWalkSpeedFactor;
var float					PlayerCrouchSpeedFactor;
var float					PlayerStrafeScale;
var float					PlayerBackpedalScale;
var float					PlayerGroundSpeed;
var float					PlayerAirSpeed;
var float					PlayerAccelRate;
var float					PlayerJumpZ;
var float					PlayerDodgeZ;
//=============================================================================
// HEALTH/ARMOR - NO REP
//=============================================================================
var bool					bHealthRegeneration;
var bool					bShieldRegeneration;
//=============================================================================
// STYLE - NO REP
//=============================================================================
var bool					bKillstreaks;
//=============================================================================
// KILL REWARD - NO REP
//=============================================================================
var int						HealthKillReward; // the amount of healthpoints a player gets for a kill
var int						KillRewardHealthMax;  // Limiter, The additional healthpoints wont exceel this value
var int						ShieldKillReward;  // armor points for a kill
var int						KillRewardShieldMax;  // Limiter, the additional armor points will not exceel this value

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		GameStyle,
		AccuracyScale, RecoilScale, bWeaponJumpOffsetting, bLongWeaponOffsetting, bNoReloading, MaxInventoryCapacity,
		bAlternativePickups, bUniversalMineLights,
		bBrightPlayers, PlayerHealth, PlayerHealthMax, PlayerSuperHealthMax, PlayerShield, PlayerShieldMax,
		bPlayerDeceleration, bAllowDodging, bAllowDoubleJump, PlayerWalkSpeedFactor, PlayerCrouchSpeedFactor, 
		PlayerStrafeScale, PlayerBackpedalScale, PlayerGroundSpeed, PlayerAirSpeed, PlayerAccelRate,
		PlayerJumpZ, PlayerDodgeZ;
		
}

// Set all defaults to match server vars here
simulated function PostNetBeginPlay()
{
	if (Role == ROLE_Authority)
		return;

	BindDefaults();
}

simulated final function BindDefaults()
{
	class.default.GameStyle 					= GameStyle;

	class.default.AccuracyScale			        = AccuracyScale;
	class.default.RecoilScale			        = RecoilScale;
	class.default.DamageScale					= DamageScale;
	class.default.bWeaponJumpOffsetting			= bWeaponJumpOffsetting;
	class.default.bLongWeaponOffsetting			= bLongWeaponOffsetting;
	class.default.bNoReloading					= bNoReloading;
	class.default.bAlternativePickups 	        = bAlternativePickups;
	class.default.bUniversalMineLights          = bUniversalMineLights;

	class.default.bBrightPlayers	            = bBrightPlayers;
    class.default.PlayerHealth      			= PlayerHealth;
	class.default.PlayerHealthMax      			= PlayerHealthMax;
	class.default.PlayerSuperHealthMax      	= PlayerSuperHealthMax;
	class.default.PlayerShield      			= PlayerShield;
	class.default.PlayerShieldMax      			= PlayerShieldMax;

	class.default.bPlayerDeceleration			= bPlayerDeceleration;
    class.default.bAllowDodging		            = bAllowDodging;
	class.default.bAllowDoubleJump				= bAllowDoubleJump;
    class.default.PlayerWalkSpeedFactor      	= PlayerWalkSpeedFactor;
	class.default.PlayerCrouchSpeedFactor       = PlayerCrouchSpeedFactor;
    class.default.PlayerStrafeScale             = PlayerStrafeScale;
	class.default.PlayerBackpedalScale          = PlayerBackpedalScale;
	class.default.PlayerGroundSpeed             = PlayerGroundSpeed;
	class.default.PlayerAirSpeed                = PlayerAirSpeed;
	class.default.PlayerAccelRate               = PlayerAccelRate;
    class.default.PlayerJumpZ                   = PlayerJumpZ;
	class.default.PlayerDodgeZ                  = PlayerDodgeZ;

	class.default.HealthKillReward				= HealthKillReward;
	class.default.KillRewardHealthMax			= KillRewardHealthMax;
	class.default.ShieldKillReward				= ShieldKillReward;
	class.default.KillRewardShieldMax			= KillRewardShieldMax;

		
	Log("BallisticReplicationInfo: PostNetBeginPlay");

	Log("Accuracy Scale: "$AccuracyScale);
	Log("Recoil Scale: "$RecoilScale);
	Log("Sprint/Jump Weapon Offsetting: "$bWeaponJumpOffsetting);
	Log("Long Weapon Offsetting: "$bLongWeaponOffsetting);
	Log("Reloading: "$ !bNoReloading);
	Log("Bright Players: "$bBrightPlayers);
	Log("Dodging: "$bAllowDodging);
	Log("Double Jumping: "$bAllowDoubleJump);
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

	bWeaponJumpOffsetting=True
	bLongWeaponOffsetting=False
	bNoReloading=False

	bAlternativePickups=False
	bUniversalMineLights=True

	bBrightPlayers=True
    PlayerHealth=100
	PlayerHealthMax=100
	PlayerSuperHealthMax=200
	PlayerShield=100
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
