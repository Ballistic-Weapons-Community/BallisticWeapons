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
var() config float 		ReloadScale;				// Scales reload speed
var() config float		DamageScale;				// Scales anti-player damage
var() config float		VehicleDamageScale;			// Scales anti-vehicle damage
// The Weapons tab's advanced rules. A scale of 1 leaves a weapon as it is made
var() config float		MagazineScale;			// Scales magazine capacity
var() config float		AimSpeedScale;			// Scales how fast sights are raised and lowered
var() config float		FireRateScale;			// Scales how fast guns fire
var() config float		ShotgunSpreadScale;		// Scales the pellet spread of shotguns
var() config float		HeadshotScale;			// Scales the damage bonus of a head hit. 0 = none
var() config float		BlastRadiusScale;		// Scales the damage radius of explosives
var() config float		PenetrationScale;		// Scales how much wall and how many players a shot goes through
var() config bool		bWeaponsAffectMovement;	// A weapon slows or speeds up its holder and changes the height of jumps
var() config bool		bAimingSlowsMovement;	// Aiming down sights slows its holder
var() config bool		bLimbDamageReduction;	// A limb hit does less damage than a body hit
var() config bool		bDamageFalloff;			// Bullets lose damage over distance

var() config int		InventoryModeIndex;			// Inventory mode used in this style - server only
var() config int		MaxInventoryCapacity;		// Maximum carrying capacity
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

	rep.AccuracyScale			= default.SwayScale;
	rep.DamageScale				= default.DamageScale;
	rep.VehicleDamageScale		= default.VehicleDamageScale;
	rep.RecoilScale				= default.RecoilScale;
	rep.RecoilShotScale			= default.RecoilShotScale;
	rep.ReloadScale				= default.ReloadScale;
	rep.MagazineScale			= default.MagazineScale;
	rep.AimSpeedScale			= default.AimSpeedScale;
	rep.FireRateScale			= default.FireRateScale;
	rep.ShotgunSpreadScale		= default.ShotgunSpreadScale;
	rep.HeadshotScale			= default.HeadshotScale;
	rep.BlastRadiusScale		= default.BlastRadiusScale;
	rep.PenetrationScale		= default.PenetrationScale;
	rep.bWeaponsAffectMovement	= default.bWeaponsAffectMovement;
	rep.bAimingSlowsMovement	= default.bAimingSlowsMovement;
	rep.bLimbDamageReduction	= default.bLimbDamageReduction;
	rep.bDamageFalloff			= default.bDamageFalloff;
	rep.MaxInventoryCapacity	= default.MaxInventoryCapacity;
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
	SwayScale=1.0f
	RecoilScale=1.0f
	RecoilShotScale=1.0f
	ReloadScale=1.0f
	DamageScale=1.0f
	VehicleDamageScale=1.0f
	MagazineScale=1.0f
	AimSpeedScale=1.0f
	FireRateScale=1.0f
	ShotgunSpreadScale=1.0f
	HeadshotScale=1.0f
	BlastRadiusScale=1.0f
	PenetrationScale=1.0f
	bWeaponsAffectMovement=True
	bAimingSlowsMovement=True
	bLimbDamageReduction=True
	bDamageFalloff=True

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