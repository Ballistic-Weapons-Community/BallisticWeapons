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
// Extension for Ballistic package variables. Ballistic uses this class instead
// of the BCore base class for its server-side vars.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticReplicationInfo extends BCReplicationInfo config(BallisticProV55);

// Server Variables -----------------------------------------------------------

// Pawn
var() Config bool		bBrightPlayers;		// Players have ambient glow to glow in the dark like the standard pawns.
var() Config bool		bNoDodging;			// Disables dodging.
var() Config bool		bLimitDoubleJumps;	// Limits double jumps so you can only do a few before having to wait for them to recharge.
var() Config float		WalkingPercentage;   // Let players configure the walking movespeed percentage.
var() Config float		CrouchingPercentage; // Let players configure the crouching movespeed percentage.
var() Config bool 		bUseRunningAnims; // Pawns will use running anims for walking.
var() Config bool		bUniversalMineLights; // All BX-5 mines are lit.

//Player
var() config int 		playerHealth;  // health the player starts with
var() config int 		playerHealthCap; // maximum health a player can have
var() config int 		playerSuperHealthCap; // maximum superhealth a player can have
var() config int 		iAdrenaline;  // maximum adrenaline a player starts with
var() config int 		iAdrenalineCap;  // maximum adrenaline a player can have
var() config int 		iArmor;  // armor the player starts with
var() config int 		iArmorCap;  // maximum armor the player can have
//var() config float 		dieSoundAmplifier;  // amplifies the die sound
//var() config float 		dieSoundRangeAmplifier; // amplifies the range
//var() config float 		hitSoundAmplifier;  // amplifies the hit sound
//var() config float 		hitSoundRangeAmplifier;  // amplifies the range
//var() config float 		jumpDamageAmplifier;  // amplifies the jump damage
//var() config float 		MaxFallSpeed; // beyond this speed, players will take damage when landing on a surface

// Kill Rewards
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
var struct RepInfo_BW
{
	var bool		bBrightPlayers;
	var bool		bNoDodging;
	var bool		bLimitDoubleJumps;
	var float		WalkingPercentage;
	var float		CrouchingPercentage;
	var bool		bUseRunningAnims;
	var bool		bUniversalMineLights;
	
	//Player
	var int playerHealth;  // health the player starts with
    var int playerHealthCap; // maximum health a player can have
    var int playerSuperHealthCap; // maximum superhealth a player can have
    var int iAdrenaline;  // maximum adrenaline a player starts with
    var int iAdrenalineCap;  // maximum adrenaline a player can have
    var int iArmor;  // armor the player starts with
    var int iArmorCap;  // maximum armor the player can have
    //var float dieSoundAmplifier;  // amplifies the die sound
    //var float dieSoundRangeAmplifier; // amplifies the range
    //var float hitSoundAmplifier;  // amplifies the hit sound
    //var float hitSoundRangeAmplifier;  // amplifies the range
    //var float jumpDamageAmplifier;  // amplifies the jump damage
	
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

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		BWRep;
}

//Set all defaults to match server vars here
simulated function InitClientVars()
{
	local BallisticPawn P;
	local int i;

	bBrightPlayers		= BWRep.bBrightPlayers;
	bNoDodging			= BWRep.bNoDodging;
	bLimitDoubleJumps	= BWRep.bLimitDoubleJumps;
	WalkingPercentage	= BWRep.WalkingPercentage;
	CrouchingPercentage = BWRep.CrouchingPercentage;
	bUniversalMineLights = BWRep.bUniversalMineLights;
	bUseRunningAnims = BWRep.bUseRunningAnims;

	class.default.bBrightPlayers	= bBrightPlayers;
	class.default.bNoDodging		= bNoDodging;
	class.default.bLimitDoubleJumps	= bLimitDoubleJumps;
	class.default.WalkingPercentage	= WalkingPercentage;
	class.default.CrouchingPercentage = CrouchingPercentage;
	class.default.bUniversalMineLights = bUniversalMineLights;
	class.default.bUseRunningAnims = bUseRunningAnims;
	
	//Kill Rewards
	class.default.killrewardArmor = killrewardArmor;
    class.default.killrewardArmorCap = killrewardArmorCap;
    class.default.killRewardHealthpoints = killRewardHealthpoints;
    class.default.killRewardHealthcap = killRewardHealthcap;
    class.default.ADRKill = ADRKill;  // adrenaline for normal kill
    class.default.ADRMajorKill = ADRMajorKill;   // adrenaline for major kill
    class.default.ADRMinorBonus = ADRMinorBonus;   // adrenaline for minor bonus
    class.default.ADRKillTeamMate = ADRKillTeamMate;   // adrenaline for killing a teammate
    class.default.ADRMinorError = ADRMinorError;    // adrenaline for a minor error
	
	//Weapons
	class.default.ReloadSpeedScale = ReloadSpeedScale;
	
	// Player
    playerHealth = BWRep.playerHealth;
    playerHealthCap = BWRep.playerHealthCap;
    playerSuperHealthCap = BWRep.playerSuperHealthCap;
    iAdrenaline = BWRep.iAdrenaline;
    iAdrenalineCap = BWRep.iAdrenalineCap;
    iArmor = BWRep.iArmor;
    iArmorCap = BWRep.iArmorCap;
    //dieSoundAmplifier = BWRep.dieSoundAmplifier;
    //dieSoundRangeAmplifier = BWRep.dieSoundRangeAmplifier;
    //hitSoundAmplifier = BWRep.hitSoundAmplifier;
    //hitSoundRangeAmplifier = BWRep.hitSoundRangeAmplifier;
    //jumpDamageAmplifier = BWRep.jumpDamageAmplifier;
	
	//Kill Rewards
	killrewardArmor = BWRep.killrewardArmor;
    killrewardArmorCap = BWRep.killrewardArmorCap;
    killRewardHealthpoints = BWRep.killRewardHealthpoints;
    killRewardHealthcap = BWRep.killRewardHealthcap;
    ADRKill = BWRep.ADRKill;  // adrenaline for normal kill
    ADRMajorKill = BWRep.ADRMajorKill;   // adrenaline for major kill
    ADRMinorBonus = BWRep.ADRMinorBonus;   // adrenaline for minor bonus
    ADRKillTeamMate = BWRep.ADRKillTeamMate;   // adrenaline for killing a teammate
    ADRMinorError = BWRep.ADRMinorError;    // adrenaline for a minor error
	
	super.InitClientVars();

	Log("bBrightPlayers: "$bBrightPlayers);
	Log("bNoDodging: "$bNoDodging);
	Log("bLimitDoubleJumps: "$bLimitDoubleJumps);
	log("Walking percentage: "$WalkingPercentage * 100$"%");
	log("Crouching percentage:"$CrouchingPercentage*100$"%");

	if (Role < ROLE_Authority && bBrightPlayers)
	{
		foreach DynamicActors ( class'BallisticPawn', P )
		{
			P.bDramaticLighting = class'BallisticPawn'.default.bDramaticLighting;
			P.AmbientGlow = class'BallisticPawn'.default.AmbientGlow;
		}
	}
}

function ServerInitialize()
{
	BWRep.bBrightPlayers	= bBrightPlayers;
	BWRep.bNoDodging		= bNoDodging;
	BWRep.bLimitDoubleJumps	= bLimitDoubleJumps;
    BWRep.WalkingPercentage = WalkingPercentage;
    BWRep.CrouchingPercentage = CrouchingPercentage;
	BWRep.bUniversalMineLights = bUniversalMineLights;
	BWRep.bUseRunningAnims = bUseRunningAnims;

	// Player
    BWRep.playerHealth = playerHealth;
    BWRep.playerHealthCap = playerHealthCap;
    BWRep.playerSuperHealthCap = playerSuperHealthCap;
    BWRep.iAdrenaline = iAdrenaline;
    BWRep.iAdrenalineCap = iAdrenalineCap;
    BWRep.iArmor = iArmor;
    BWRep.iArmorCap = iArmorCap;
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

	super.ServerInitialize();
}

static function BCReplicationInfo GetBRep(actor A)
{
	local BallisticReplicationInfo BRI;

	foreach A.DynamicActors(class'BallisticReplicationInfo', BRI)
	{
		if (A != None)
			return BRI;
	}
	return None;
}

defaultproperties
{
     WalkingPercentage=0.900000
     CrouchingPercentage=0.450000
     ModString="Ballistic Weapons Pro"
	 
	 //Player
	 //PlayerSpeedScale=1.000000
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
