//=============================================================================
// InstantEffectParams.
//
// Parameters which define the gameplay properties of a shot 
// fired by an instant fire mode. 
//
// Can be used to implement ammo changes, etc.
//
// by Azarael 2020
//=============================================================================
class InstantEffectParams extends FireEffectParams
    editinlinenew
    DependsOn(BUtil);

//-----------------------------------------------------------------------------
// Range
//-----------------------------------------------------------------------------
var()   Range               TraceRange;             // Maximum range of this shot type
var()   Range               WaterTraceRange;        // Maximum range through water
var()   InterpCurve         RangeAttenCurve;        // Interpolation curve for damage reduction over range
//-----------------------------------------------------------------------------
// Damage
//-----------------------------------------------------------------------------
var()   int                 Damage;                 // Damage dealt by each shot
var()   float               HeadMult;               // Multiplier for head shot
var()   float               LimbMult;               // Multiplier for limb shot

var()   class<DamageType>	DamageType;				// Damage type to use
var()   class<DamageType>	DamageTypeHead;			// Damage type to use for head
var()   class<DamageType>	DamageTypeArm;			// Damage type to use for unimportant limbs

var()   bool				UseRunningDamage;		// Enable damage variations when running towards/away from enemies
var()   float				RunningSpeedThreshold;	// Instigator speed divided by this to figure out Running damage bonus
//-----------------------------------------------------------------------------
// Penetration
//-----------------------------------------------------------------------------
var()   float               PenetrationEnergy;      // Maximum distance in Unreal Units which this mode can penetrate walls
var()   int					PenetrateForce;			// The penetrating power of these bullets.
var()   bool				bPenetrate;				// Bullets can go though enemies

// Note - Deprecate these two
var()   float				PDamageFactor;		    // Damage multiplied by this with each penetration
var()   float				WallPDamageFactor;		// Damage multiplied by this for each wall penetration
//-----------------------------------------------------------------------------
// Momentum
//-----------------------------------------------------------------------------
var()   int                 MomentumTransfer;       // Momentum imparted to enemy in UU
var()   float				HookStopFactor;			// How much force is applied to counteract victim running. This * Victim.GroundSpeed
var()   float				HookPullForce;			// Velocity amount added to pull victim towards instigator

static simulated function Initialize(BallisticWeapon BW);

defaultproperties
{
    TraceRange=(Min=5000.000000,Max=5000.000000)
    RangeAttenCurve=(Points=((InVal=0,OutVal=1),(InVal=1,OutVal=1)))

    Damage=1
    HeadMult=1.25f
    LimbMult=0.7f

    UseRunningDamage=False
    RunningSpeedThreshold=300

    PDamageFactor=0.7
    WallPDamageFactor=0.95
}