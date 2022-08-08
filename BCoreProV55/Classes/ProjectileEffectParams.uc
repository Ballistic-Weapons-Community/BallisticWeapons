//=============================================================================
// ProjectileEffectParams.
//
// Parameters which define the gameplay properties of a shot 
// fired by a projectile fire mode. 
//
// by Azarael 2020
//=============================================================================
class ProjectileEffectParams extends FireEffectParams
    editinlinenew
    DependsOn(BUtil);

// Determines how an explosive or radius-affecting projectile's effect declines over distance
enum ERadiusFallOffType
{
    RFO_Linear,     // Effect multiplied by ((damage radius - distance from centre) / damage radius)
    RFO_Quadratic,  // Effect multiplied by square of ((damage radius - distance from centre) / damage radius)
    RFO_None        // Effect is consistent for any distance
};

var()   class<BallisticProjectile>  ProjectileClass;
var()   vector			            SpawnOffset;

var()	float                       Speed;                  // Initial speed of projectile.
var()	float                       MaxSpeed;               // Limit on speed of projectile (0 means no limit)
var()   float                       AccelSpeed;

var()   float                       Damage;
var()   float	                    DamageRadius;
var()   float	                    MomentumTransfer;       // Momentum magnitude imparted by impacting projectile.
var()   bool                      	bLimitMomentumZ;        // Prevents Z momentum exceeding certain value
var()   float					    HeadMult;		        // Multiplier for effect against head
var()   float					    LimbMult;		        // Multiplier for effect against limb
var()   float                       MaxDamageGainFactor;    // Max multiplier for damage gained over range
var()   float                       DamageGainStartTime;    // Time in lifespan to start scaling damage up
var()   float                       DamageGainEndTime;      // Time in lifespan to stop scaling damage up

var()   ERadiusFallOffType          RadiusFallOffType;

static simulated function Initialize(BallisticWeapon BW);

defaultproperties
{
    HeadMult=1.500000
    LimbMult=0.700000
    MaxSpeed=0.000000
    DamageRadius=0.000000
    RadiusFallOffType=RFO_Quadratic
}