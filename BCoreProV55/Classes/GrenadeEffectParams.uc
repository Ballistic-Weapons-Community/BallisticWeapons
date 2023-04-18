class GrenadeEffectParams extends ProjectileEffectParams;

var() float						ImpactDamage;	// Damage on direct impact

// needs some thought
// var() float						ArmingDelay;	// Delay before switching to DT_Impact
// var() float						DetonateDelay;	// Delay before detonating after timer activation

defaultproperties
{
    ImpactDamage=1
}