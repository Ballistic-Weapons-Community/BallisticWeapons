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
class BallisticReplicationInfo extends LinkedReplicationInfo config(BallisticProV55);

var() string		ModString;

enum EGameStyle
{
	Arena,		// BallisticPro
	Legacy,		// BallisticV25
	Realism,	// Kab
	Tactical	// PvE
};

//=============================================================================
// CONFIG VARIABLES
//=============================================================================
var() globalconfig EGameStyle	GameStyle;				
var() globalconfig float		AccuracyScale;			// Used for scaling general weapon accuracy.
var() globalconfig float		RecoilScale;			// Used for scaling general weapon recoil.
var() globalconfig bool		    bNoJumpOffset;			// Prevents weapons shifting and being offset when jumping or sprinting
var() globalconfig bool		    bNoLongGun;				// Disable 'long gun' features
var() globalconfig bool		    bNoReloading;			// Disables reloading and weapons use boring old style ammo handling...
var() globalconfig float      	ReloadSpeedScale;   	// Buff reload speeds
var() globalconfig bool         bAlternativePickups;	// Press Use to Pickup Weapon
var() globalconfig float		PlayerADSMoveSpeedFactor;
var() globalconfig float		PlayerCrouchSpeedFactor;
// LDG TEST ONLY
var() globalconfig bool         bUseFixedModifiers;                      // Testing - use fixed modifiers for various aspects - Arena only!
var() globalconfig float        SightingTimeScale;
var() globalconfig int          ChaosSpeedThresholdOverride;

//=============================================================================
// PAWN
//=============================================================================
var() config bool		bBrightPlayers;		    // Players have ambient glow to glow in the dark like the standard pawns.
var() config bool		bNoDodging;			    // Disables dodging.
var() config bool		bNoDoubleJump;	        // Disables double jump.
var() config bool 		bUseRunningAnims;       // Pawns will use running anims for walking.
var() config bool		bUniversalMineLights;   // All BX-5 mines are lit.

//=============================================================================
// PLAYER
//=============================================================================
var() config bool		bCustomStats;			// Enables Custom Health, Shield & Adren Stats.
var() config int 		playerHealth;           // health the player starts with
var() config int 		playerHealthCap;        // maximum health a player can have
var() config int 		playerSuperHealthCap;   // maximum superhealth a player can have
var() config int 		iAdrenaline;            // maximum adrenaline a player starts with
var() config int 		iAdrenalineCap;         // maximum adrenaline a player can have
var() config int 		iArmor;                 // armor the player starts with
var() config int 		iArmorCap;              // maximum armor the player can have

//=============================================================================
// MOVEMENT OVERRIDE
//=============================================================================
var() config bool           bOverrideMovement; // valid for classic and realism, comp and tactical will always ignore
var() config float          PlayerStrafeScale;
var() config float          PlayerBackpedalScale;
var() config float          PlayerGroundSpeed;
var() config float          PlayerAirSpeed;
var() config float          PlayerAccelRate;
var() config float          PlayerJumpZ;
var() config float          PlayerDodgeZ;

// NOT REPLICATED

var() globalconfig float		DamageScale, DamageModHead, DamageModLimb; 	// Configurable damage modifiers
//=============================================================================
// KILL REWARD (why is this here? it doesn't need to be replicated)
//=============================================================================
var() config int 		killrewardArmor;  // armor points for a kill
var() config int 		killrewardArmorCap;  // Limiter, the additional armor points will not exceel this value
var() config int 		killRewardHealthpoints; // the amount of healthpoints a player gets for a kill
var() config int 		killRewardHealthcap;  // Limiter, The additional healthpoints wont exceel this value
var() config int 		ADRKill;  // adrenaline for normal kill
var() config int		ADRMajorKill;   // adrenaline for major kill
var() config int 		ADRMinorBonus;   // adrenaline for minor bonus
var() config int 		ADRKillTeamMate;   // adrenaline for killing a teammate
var() config int 		ADRMinorError;    // adrenaline for a minor error
// ----------------------------------------------------------------------------
var struct RepInfo_BCore
{
	var EGameStyle 	GameStyle;
	var float		AccuracyScale;
	var float		RecoilScale;
	var float       ReloadSpeedScale;
	var bool		bNoJumpOffset;
	var bool		bNoLongGun;
	var bool		bNoReloading;
	var bool        bAlternativePickups;
    var bool        bUseFixedModifiers;
    var float       SightingTimeScale;
    var float       ChaosSpeedThresholdOverride;
} BCoreRep;

var struct RepInfo_BW
{
	var bool		bBrightPlayers;
	var bool		bNoDodging;
	var bool		bNoDoubleJump;
	var bool		bUseRunningAnims;
	var bool		bUniversalMineLights;
	
	//Player
	var bool		bCustomStats;
	var int 		playerHealth;  // health the player starts with
    var int 		playerHealthCap; // maximum health a player can have
    var int 		playerSuperHealthCap; // maximum superhealth a player can have
    var int 		iAdrenaline;  // maximum adrenaline a player starts with
    var int 		iAdrenalineCap;  // maximum adrenaline a player can have
    var int 		iArmor;  // armor the player starts with
    var int 		iArmorCap;  // maximum armor the player can have
    //var float 	dieSoundAmplifier;  // amplifies the die sound
    //var float 	dieSoundRangeAmplifier; // amplifies the range
    //var float 	hitSoundAmplifier;  // amplifies the hit sound
    //var float 	hitSoundRangeAmplifier;  // amplifies the range
    //var float 	jumpDamageAmplifier;  // amplifies the jump damage
	
	//Kill Rewards
	var int killrewardArmor;  // armor points for a kill
    var int killrewardArmorCap;  // Limiter, the additional armor points will not exceel this value
    var int killRewardHealthpoints; // the amount of healthpoints a player gets for a kill
    var int killRewardHealthcap;  // Limiter, The additional healthpoints wont exceel this value
    //var float MaxFallSpeed;  // beyond this speed, players will take damage when landing on a surface
    var int ADRKill;  // adrenaline for normal kill
    var int ADRMajorKill;   // adrenaline for major kill
    var int ADRMinorBonus;   // adrenaline for minor bonus
    var int ADRKillTeamMate;   // adrenaline for killing a teammate
    var int ADRMinorError;    // adrenaline for a minor error

}BWRep;

var struct RepInfo_BW_Move
{
    var bool           bOverrideMovement;
    var float		   PlayerADSMoveSpeedFactor;
    var float		   PlayerCrouchSpeedFactor;
    var float          PlayerStrafeScale;
    var float          PlayerBackpedalScale;
    var float          PlayerGroundSpeed;
    var float          PlayerAirSpeed;
    var float          PlayerAccelRate;
    var float          PlayerJumpZ;
    var float          PlayerDodgeZ;
} BWRepMove;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		BCoreRep, BWRep, BWRepMove;
}

// Set all defaults to match server vars here
simulated function InitClientVars()
{
	GameStyle 			= BCoreRep.GameStyle;
	AccuracyScale		= BCoreRep.AccuracyScale;
	RecoilScale			= BCoreRep.RecoilScale;
	ReloadSpeedScale 	= BCoreRep.ReloadSpeedScale;
	bNoJumpOffset		= BCoreRep.bNoJumpOffset;
	bNoLongGun			= BCoreRep.bNoLongGun;
	bNoReloading		= BCoreRep.bNoReloading;
	bAlternativePickups = BCoreRep.bAlternativePickups;
    bUseFixedModifiers  = BCoreRep.bUseFixedModifiers;
    SightingTimeScale   = BCoreRep.SightingTimeScale;
    ChaosSpeedThresholdOverride = BCoreRep.ChaosSpeedThresholdOverride;

	bBrightPlayers		= BWRep.bBrightPlayers;
	bNoDodging			= BWRep.bNoDodging;
	bNoDoubleJump	    = BWRep.bNoDoubleJump;

	bUniversalMineLights = BWRep.bUniversalMineLights;
	bUseRunningAnims = BWRep.bUseRunningAnims;

    bOverrideMovement = BWRepMove.bOverrideMovement;
    PlayerADSMoveSpeedFactor = BWRepMove.PlayerADSMoveSpeedFactor;
	PlayerCrouchSpeedFactor = BWRepMove.PlayerCrouchSpeedFactor;
    PlayerStrafeScale = BWRepMove.PlayerStrafeScale;
	PlayerBackpedalScale = BWRepMove.PlayerBackpedalScale;
	PlayerGroundSpeed = BWRepMove.PlayerGroundSpeed;
	PlayerAirSpeed = BWRepMove.PlayerAirSpeed;
	PlayerAccelRate = BWRepMove.PlayerAccelRate;
    PlayerJumpZ = BWRepMove.PlayerJumpZ;
    PlayerDodgeZ = BWRepMove.PlayerDodgeZ;

    class.default.GameStyle 			= GameStyle;

    // settings here can be guarded later
	class.default.AccuracyScale			        = AccuracyScale;
	class.default.RecoilScale			        = RecoilScale;
	class.default.ReloadSpeedScale 		        = ReloadSpeedScale;
	class.default.bNoJumpOffset			        = bNoJumpOffset;
	class.default.bNoLongGun			        = bNoLongGun;
	class.default.bNoReloading			        = bNoReloading;
    class.default.bNoDodging		            = bNoDodging;
	class.default.bNoDoubleJump	                = bNoDoubleJump;

	class.default.bAlternativePickups 	        = bAlternativePickups;
    class.default.SightingTimeScale             = SightingTimeScale;
    class.default.ReloadSpeedScale              = ReloadSpeedScale;
    class.default.ChaosSpeedThresholdOverride   = ChaosSpeedThresholdOverride;

	class.default.bBrightPlayers	            = bBrightPlayers;
	class.default.bUniversalMineLights          = bUniversalMineLights;
	class.default.bUseRunningAnims              = bUseRunningAnims;

    class.default.bOverrideMovement             = bOverrideMovement;
    class.default.PlayerADSMoveSpeedFactor      = PlayerADSMoveSpeedFactor;
	class.default.PlayerCrouchSpeedFactor       = PlayerCrouchSpeedFactor;
    class.default.PlayerStrafeScale             = PlayerStrafeScale;
	class.default.PlayerBackpedalScale          = PlayerBackpedalScale;
	class.default.PlayerGroundSpeed             = PlayerGroundSpeed;
	class.default.PlayerAirSpeed                = PlayerAirSpeed;
	class.default.PlayerAccelRate               = PlayerAccelRate;
    class.default.PlayerJumpZ                   = PlayerJumpZ;
	class.default.PlayerDodgeZ                  = PlayerDodgeZ;

	// Player
    if (bCustomStats)
	{
		playerHealth = BWRep.playerHealth;
		playerHealthCap = BWRep.playerHealthCap;
		playerSuperHealthCap = BWRep.playerSuperHealthCap;
		iAdrenaline = BWRep.iAdrenaline;
		iAdrenalineCap = BWRep.iAdrenalineCap;
		iArmor = BWRep.iArmor;
		iArmorCap = BWRep.iArmorCap;
	}
		
	killrewardArmor = BWRep.killrewardArmor;
    killrewardArmorCap = BWRep.killrewardArmorCap;
    killRewardHealthpoints = BWRep.killRewardHealthpoints;
    killRewardHealthcap = BWRep.killRewardHealthcap;
    ADRKill = BWRep.ADRKill;  // adrenaline for normal kill
    ADRMajorKill = BWRep.ADRMajorKill;   // adrenaline for major kill
    ADRMinorBonus = BWRep.ADRMinorBonus;   // adrenaline for minor bonus
    ADRKillTeamMate = BWRep.ADRKillTeamMate;   // adrenaline for killing a teammate
    ADRMinorError = BWRep.ADRMinorError;    // adrenaline for a minor error

	class.default.killrewardArmor = killrewardArmor;
    class.default.killrewardArmorCap = killrewardArmorCap;
    class.default.killRewardHealthpoints = killRewardHealthpoints;
    class.default.killRewardHealthcap = killRewardHealthcap;
    class.default.ADRKill = ADRKill;  // adrenaline for normal kill
    class.default.ADRMajorKill = ADRMajorKill;   // adrenaline for major kill
    class.default.ADRMinorBonus = ADRMinorBonus;   // adrenaline for minor bonus
    class.default.ADRKillTeamMate = ADRKillTeamMate;   // adrenaline for killing a teammate
    class.default.ADRMinorError = ADRMinorError;    // adrenaline for a minor error

	Log("InitClientVars: "$ModString);

	Log("AccuracyScale: "$AccuracyScale);
	Log("RecoilScale: "$RecoilScale);
	Log("No Jump Offset: "$bNoJumpOffset);
	Log("bNoLongGun: "$bNoLongGun);
	Log("bNoReloading: "$bNoReloading);
	Log("bBrightPlayers: "$bBrightPlayers);
	Log("bNoDodging: "$bNoDodging);
	Log("bNoDoubleJump: "$bNoDoubleJump);
}

function ServerInitialize()
{
	BCoreRep.GameStyle				= GameStyle;
	BCoreRep.AccuracyScale			= AccuracyScale;
	BCoreRep.RecoilScale			= RecoilScale;
	BCoreRep.ReloadSpeedScale 		= ReloadSpeedScale;
	BCoreRep.bNoJumpOffset			= bNoJumpOffset;
	BCoreRep.bNoLongGun				= bNoLongGun;
	BCoreRep.bNoReloading			= bNoReloading;
	BCoreRep.bAlternativePickups 	= bAlternativePickups;
    BCoreRep.bUseFixedModifiers     = bUseFixedModifiers;
    BCoreRep.SightingTimeScale      = SightingTimeScale;
    BCoreRep.ChaosSpeedThresholdOverride = ChaosSpeedThresholdOverride;

    BWRep.bBrightPlayers	= bBrightPlayers;
	BWRep.bNoDodging		= bNoDodging;
	BWRep.bNoDoubleJump	= bNoDoubleJump;
	BWRep.bUniversalMineLights = bUniversalMineLights;
	BWRep.bUseRunningAnims = bUseRunningAnims;

    BWRepMove.bOverrideMovement = bOverrideMovement;
    BWRepMove.PlayerADSMoveSpeedFactor = PlayerADSMoveSpeedFactor;
    BWRepMove.PlayerCrouchSpeedFactor = PlayerCrouchSpeedFactor;
    BWRepMove.PlayerStrafeScale = PlayerStrafeScale;
	BWRepMove.PlayerBackpedalScale = PlayerBackpedalScale;
	BWRepMove.PlayerGroundSpeed = PlayerGroundSpeed;
	BWRepMove.PlayerAirSpeed = PlayerAirSpeed;
	BWRepMove.PlayerAccelRate = PlayerAccelRate;
    BWRepMove.PlayerJumpZ = PlayerJumpZ;
    BWRepMove.PlayerDodgeZ = PlayerDodgeZ;

	// Player
    if (bCustomStats)
	{
		BWRep.playerHealth = playerHealth;
		BWRep.playerHealthCap = playerHealthCap;
		BWRep.playerSuperHealthCap = playerSuperHealthCap;
		BWRep.iAdrenaline = iAdrenaline;
		BWRep.iAdrenalineCap = iAdrenalineCap;
		BWRep.iArmor = iArmor;
		BWRep.iArmorCap = iArmorCap;
	}
	
    //BWRep.dieSoundAmplifier = dieSoundAmplifier;
    //BWRep.dieSoundRangeAmplifier = dieSoundRangeAmplifier;
    //BWRep.hitSoundAmplifier = hitSoundAmplifier;
    //BWRep.hitSoundRangeAmplifier = hitSoundRangeAmplifier;
    //BWRep.jumpDamageAmplifier = jumpDamageAmplifier;
	
	//Kill Rewards
	BWRep.killrewardArmor = killrewardArmor;
    BWRep.killrewardArmorCap = killrewardArmorCap;
    BWRep.killRewardHealthpoints = killRewardHealthpoints;
    BWRep.killRewardHealthcap = killRewardHealthcap;
    BWRep.ADRKill = ADRKill;
    BWRep.ADRMajorKill = ADRMajorKill;
    BWRep.ADRMinorBonus = ADRMinorBonus;
    BWRep.ADRKillTeamMate = ADRKillTeamMate;
    BWRep.ADRMinorError = ADRMinorError;

	Log("ServerInitialize: "$ModString);
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

simulated event PostNetBeginPlay()
{
	if (Role < ROLE_Authority)
		InitClientVars();
}

static final function bool IsArena()
{
    return default.GameStyle == EGameStyle.Arena;
}

static final function bool IsClassic()
{
    return default.GameStyle == EGameStyle.Legacy;
}

static final function bool IsRealism()
{
    return default.GameStyle == EGameStyle.Realism;
}

static final function bool IsTactical()
{
    return default.GameStyle == EGameStyle.Tactical;
}

static final function bool IsClassicOrRealism()
{
    return IsClassic() || IsRealism();
}

static final function bool IsArenaOrTactical()
{
    return IsArena() || IsTactical();
}

static final function bool UseFixedModifiers()
{
    return default.GameStyle == EGameStyle.Arena && default.bUseFixedModifiers;
}

static final function float GetADSMoveSpeedMultiplier()
{
    if (IsArenaOrTactical())
        return 1.0f;

    return default.PlayerADSMoveSpeedFactor;
}

static function BallisticReplicationInfo GetOrCreateInstance(actor A)
{
	local BallisticReplicationInfo BRI;

	BRI = GetInstance(A);

	if (BRI == None)
	{
		BRI = A.Spawn(class'BallisticReplicationInfo');
		BRI.ServerInitialize();
	}

	return BRI;
}

defaultproperties
{
    bOnlyDirtyReplication=False
    bUseFixedModifiers=False

    ModString="Ballistic Weapons Pro"

    AccuracyScale=1.000000
    RecoilScale=1.000000
    ReloadSpeedScale=1.000000
    bAlternativePickups=False

    DamageScale=1.0f
    DamageModHead=1.5f
    DamageModLimb=0.7f
    SightingTimeScale=1.0f
    PlayerADSMoveSpeedFactor=0.9
    PlayerCrouchSpeedFactor=0.45

	 // Movement rate
    bOverrideMovement=False
    PlayerStrafeScale=1
    PlayerBackpedalScale=1
    PlayerGroundSpeed=260.000000
    PlayerAirSpeed=260.000000
    PlayerAccelRate=2048.000000
    PlayerJumpZ=256
    PlayerDodgeZ=170

    //Player
    //PlayerSpeedScale=1.000000
    bCustomStats=False
    PlayerHealth=100
    PlayerHealthCap=100
    PlayerSuperHealthCap=150
    iAdrenaline=0
    iAdrenalineCap=100
    iArmor=100
    iArmorCap=100
    //dieSoundAmplifier=6.500000
    //dieSoundRangeAmplifier=1.000000
    //hitSoundAmplifier=8.000000
    //hitSoundRangeAmplifier=1.500000
    //JumpDamageAmplifier=80.000000
    //MaxFallSpeed=800.000000
    
    //Kill Rewards
    KillrewardArmor=10
    KillRewardHealthpoints=20
    ADRKill=10
    ADRMajorKill=15
    ADRMinorBonus=5
    ADRKillTeamMate=-10
    ADRMinorError=-5
}
