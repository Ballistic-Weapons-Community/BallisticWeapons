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
var() config float		SwayScale;			    	// Scales weapon sway
var() config float		DamageScale;				// Scales weapon damage
var() config float		RecoilScale;			    // Scales weapon recoil

var() config int		InventoryModeIndex;			// Inventory mode used in this style - server only
var() config int		MaxInventoryCapacity;		// Maximum carrying capacity
var() config bool		bKillstreaks;				// Use killstreaks in this style - server only

//=============================================================================
// NON-CONFIG VARIABLES
//=============================================================================	
var() bool				bRunInADS;					// Use run anims in ADS (because gametype has fast ADS move speed)
var() float				PlayerWalkSpeedFactor;		// sane default for use for ADS speed for your style (ADS speed is controlled by the weapons, so there's no point having this config)
var() float				PlayerCrouchSpeedFactor;

static final function InitializeReplicationInfo(BallisticReplicationInfo rep)
{
	rep.GameStyle 				= default.Index;

	rep.AccuracyScale			= default.SwayScale;
	rep.DamageScale				= default.DamageScale;
	rep.RecoilScale				= default.RecoilScale;
	rep.MaxInventoryCapacity	= default.MaxInventoryCapacity;
	rep.bKillstreaks			= default.bKillstreaks;
	rep.PlayerWalkSpeedFactor	= default.PlayerWalkSpeedFactor;
	rep.PlayerCrouchSpeedFactor = default.PlayerCrouchSpeedFactor;

	// style-specific properties here
	FillReplicationInfo(rep);

	rep.BindDefaults();
}

static protected function FillReplicationInfo(BallisticReplicationInfo rep);

defaultproperties
{
    Index=GS_Arena
	StyleName="Pro"

	SwayScale=1.0f
	DamageScale=1.0f
    RecoilScale=1.0f

	MaxInventoryCapacity=12

	PlayerWalkSpeedFactor=0.9
	PlayerCrouchSpeedFactor=0.45

	bKillstreaks=True
	bRunInADS=True
}