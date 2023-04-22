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
var() config float		RecoilScale;			    // Scales weapon recoil pattern (results in tighter pattern and lower apparent recoil)
var() config float 		RecoilShotScale;			// Scales weapon recoil per shot (results in slower progress along the pattern)
var() config float		DamageScale;				// Scales anti-player damage
var() config float		VehicleDamageScale;			// Scales anti-vehicle damage

var() config int		InventoryModeIndex;			// Inventory mode used in this style - server only
var() config int		MaxInventoryCapacity;		// Maximum carrying capacity
var() config bool		bKillstreaks;				// Use killstreaks in this style - server only
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

	rep.AccuracyScale			= default.SwayScale;
	rep.DamageScale				= default.DamageScale;
	rep.VehicleDamageScale		= default.VehicleDamageScale;
	rep.RecoilScale				= default.RecoilScale;
	rep.RecoilShotScale			= default.RecoilShotScale;
	rep.MaxInventoryCapacity	= default.MaxInventoryCapacity;
	rep.bKillstreaks			= default.bKillstreaks;
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
	SwayScale=1.0f
	RecoilScale=1.0f
	RecoilShotScale=1.0f
	DamageScale=1.0f
	VehicleDamageScale=1.0f

	SightBobScale=1f

	InventoryModeIndex=0
	MaxInventoryCapacity=0

	ConflictWeaponSlots=10
	ConflictEquipmentSlots=2

	PlayerWalkSpeedFactor=0.9
	PlayerCrouchSpeedFactor=0.45

	bBrightPlayers=False
	bKillstreaks=True
}