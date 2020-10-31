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

static simulated final function Initialize(BallisticWeapon BW);

defaultproperties
{
    // AI //
    SplashDamage=false
    RecommendSplashDamage=false
    BotRefireRate=0.95
}