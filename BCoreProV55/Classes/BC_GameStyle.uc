//=============================================================================
// BC_GameStyle
//
// Stores the parameters which are specific to a certain game style. Applies 
// these to the BallisticReplicationInfo, which thereafter serves as the 
// source of this information in the game.
//
// by Azarael
//=============================================================================
class BC_GameStyle extends Object
    abstract
	config(BallisticProV55);

enum EGameStyle
{
	GS_Pro,		// BallisticPro: fast arena-type gameplay
	GS_Classic,	// BallisticV25: classic gameplay
	GS_Realism,	// Kab
	GS_Tactical	// Slower, more tactical gameplay
};

var EGameStyle  		Index;
var string				StyleName;

//=============================================================================
// CONFIG VARIABLES
//=============================================================================	

// The weapon scales and the inventory capacity are declared in BC_GameStyle_Config (config) and
// BC_GameStyle_Fixed (not config): a fixed style's values can't be changed in BallisticProV55.ini
var() config int		InventoryModeIndex;			// Inventory mode used in this style - server only
var() config bool		bKillstreaks;				// Use killstreaks in this style - server only
var() config bool		bNoRandomCamo;				// Disables camo and layout randomizer
var() config bool		bBrightPlayers;		    	// Players have ambient glow to glow in the dark like the standard pawns.
//=============================================================================
// NON-CONFIG VARIABLES
//=============================================================================	
var() float				PlayerWalkSpeedFactor;		// sane default for use for ADS speed for your style (ADS speed is controlled by the weapons, so there's no point having this config)
var() float				PlayerCrouchSpeedFactor;
var() float				PlayerAnimationGroundSpeed;	// sets default.GroundSpeed - used for dealing with animations in C++ code

//=============================================================================
// NON-CONFIG VARIABLES - NOT REPLICATED
//=============================================================================	
var() bool				bRunInADS;					// Use run anims in ADS (because gametype has fast ADS move speed)
var() bool				bForceViewShake;			// Forces visual recoil
var() float				SightBobScale;				// Scales view bob when in iron sights
var() int				ConflictWeaponSlots;		// Number of slots available for main weapons in Conflict.
var() int				ConflictEquipmentSlots;		// Number of slots available for equipment in Conflict.

static final function InitializeReplicationInfo(BallisticReplicationInfo rep)
{
	rep.GameStyle 				= default.Index;

	rep.bKillstreaks			= default.bKillstreaks;
	rep.bNoRandomCamo			= default.bNoRandomCamo;
	rep.PlayerWalkSpeedFactor	= default.PlayerWalkSpeedFactor;
	rep.PlayerCrouchSpeedFactor = default.PlayerCrouchSpeedFactor;
	rep.PlayerAnimationGroundSpeed = default.PlayerAnimationGroundSpeed;

	// style-specific properties here
	FillReplicationInfo(rep);

	rep.BindDefaults();
}

static protected function FillReplicationInfo(BallisticReplicationInfo rep);

defaultproperties
{
	SightBobScale=1f

	InventoryModeIndex=0

	ConflictWeaponSlots=10
	ConflictEquipmentSlots=2

	PlayerWalkSpeedFactor=0.9
	PlayerCrouchSpeedFactor=0.45
	bNoRandomCamo=True
	bBrightPlayers=False
	bKillstreaks=False
}