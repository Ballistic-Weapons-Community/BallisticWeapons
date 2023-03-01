//=============================================================================
// FireEffectParams.
//
// Parameters which define the effects of some weapon fire which could 
// vary with the ammunition type or projectile defined.
//
// This includes things such as the fire sound, muzzle flash, recoil, 
// damage, inaccuracy and AI parameters.
//
// Subclasses:
// - AmmoParams         (instant fire effects + this data)
// - ProjectileParams   (projectile values + this data) 
//
// by Azarael 2020
//=============================================================================
class FireEffectParams extends Object
    editinlinenew
    DependsOn(BUtil);

enum FireSpreadMode
{
	FSM_Rectangle,	// Standard random rectangular box.
	FSM_Scatter,	// An elliptical spread pattern with higher concentration towards the center.
	FSM_Circle		// More evenly spread elliptical pattern.
};

//-----------------------------------------------------------------------------
// Appearance
//-----------------------------------------------------------------------------
var() class<Actor>				MuzzleFlashClass;	    // The actor class to use for this fire's muzzle flash
var() float                     FlashScaleFactor;
var() Name						FlashBone;			// Bone to attach muzzle flash to
//-----------------------------------------------------------------------------
// Sound
//-----------------------------------------------------------------------------
var() BUtil.FullSound		    FireSound;	            // Fire sound to play
//-----------------------------------------------------------------------------
// Recoil
//-----------------------------------------------------------------------------
var() float				        Recoil;				    // Amount of recoil added each shot
var() float				        PushbackForce;		    // How much to jolt player back when they fire
var() float				        Chaos;				    // Chaos added to aim when fired. Will be auto calculated if < 0
//-----------------------------------------------------------------------------
// Dispersal
//-----------------------------------------------------------------------------
var() BUtil.IntVector2	        Inaccuracy;			    // X and Y inaccuracy in rotational units
var() FireSpreadMode	        SpreadMode;		        // The type of spread pattern to use
//-----------------------------------------------------------------------------
// AI
//-----------------------------------------------------------------------------
var() bool 				        SplashDamage;           // capable of inflicting damage on a miss  
var() bool 				        RecommendSplashDamage;  // primarily deals damage through splash (rockets, grenade, etc)

var() float                     BotRefireRate;          // probability that bot will decide to repeatedly fire weapon rather than taking another action
var() float                     WarnTargetPct;          // probability that a bot attacked with this mode will be warned of the incoming shot and may evade

var() String                    ShotTypeString, EffectString;

//===========================================================================
// Weapon menu
//===========================================================================
struct FireModeStats
{
	var	String		EffectString;
    var String      ShotTypeString;
    var String      Damage;
	var	int			DamageInt;
    var float       HeadMult;
    var float       LimbMult;
	var	int			DPS;
	var	float		TTK;
	var	String		RPM;
	var	int			RPShot;
	var	int			RPS;
	var	float		FCPShot;
	var	float		FCPS;
	var	String		RangeOpt, RangeDecayed, RangeMax;
};

static simulated function Initialize(BallisticWeapon BW);

//Accessor stub for stats
function FireModeStats GetStats() 
{
	local FireModeStats FS;
	
	FS.EffectString = EffectString;
    FS.ShotTypeString = ShotTypeString;
	FS.RPShot = Recoil;
	FS.FCPShot = Chaos;
	
	return FS;
}

defaultproperties
{
    FlashScaleFactor=1f
	FlashBone="tip"
    // AI //
    SplashDamage=false
    RecommendSplashDamage=false
    BotRefireRate=0.95

    FireSound=(Volume=1.000000,Radius=512.000000,Pitch=1.000000,bNoOverride=True)

    ShotTypeString="times"
    EffectString="Unknown"
}