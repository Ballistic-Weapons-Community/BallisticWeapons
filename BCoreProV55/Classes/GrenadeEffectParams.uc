class GrenadeEffectParams extends ProjectileEffectParams;

enum EDetonateType				// Different ways that grenade can detonate
{
	DT_Timer,					// Detonate when timer runs out
	DT_Impact,					// Detonate on impact
	DT_ImpactTimed,				// Detonate on timer that only starts on impact
	DT_Still,					// Detonate after timer that starts when projectile is still
	DT_Disarm,					// Halt arming process, don't explode
	DT_None						// Don't use normal detonation
};

enum EPlayerImpactType	// Different ways that grenade can impact with players
{
	PIT_Bounce,					// Bounce off players
	PIT_Detonate,				// Detonate
	PIT_Stick					// Stick to players
};

var() float					ImpactDamage;	// Damage on direct impact
var() bool					bCombinedSplashImpact; // Deal both impact and splash damage on hit

var() bool					bOverrideArming;
var() float					ArmingDelay;	// Delay before switching to DT_Impact
var() float					DetonateDelay;	// Delay before detonating after timer activation

var() EDetonateType 		UnarmedDetonateOn;
var() EDetonateType 		ArmedDetonateOn;

var() EPlayerImpactType 	UnarmedPlayerImpactType;
var() EPlayerImpactType 	ArmedPlayerImpactType;


defaultproperties
{
    ImpactDamage=1
}