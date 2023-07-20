//=============================================================================
// BulldogRocket.
//
// FRAG-12 explosive charge. Faster ones have quicker arming.
//
// by Sergeant Kelly and edited by Azarael
//=============================================================================
class BulldogRocketFast extends BallisticGrenade;


simulated function Landed (vector HitNormal)
{
	Explode(Location, HitNormal);
}

defaultproperties
{
	WeaponClass=Class'BWBP_SKC_Pro.BulldogAssaultCannon'
	DampenFactor=0.15000
	DampenFactorParallel=0.300000

	ArmingDelay=0.01
	UnarmedDetonateOn=DT_Disarm
	UnarmedPlayerImpactType=PIT_Bounce
	ArmedDetonateOn=DT_Impact
	ArmedPlayerImpactType=PIT_Detonate

	ImpactDamage=125
	ImpactDamageType=Class'BWBP_SKC_Pro.DT_BulldogImpact'
	ImpactManager=Class'BWBP_SKC_Pro.IM_BulldogFRAG'
	ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
	TrailClass=Class'BallisticProV55.MRLTrailEmitter'
	TrailOffset=(X=-14.000000)


	SplashManager=Class'BallisticProV55.IM_ProjWater'
	Speed=23000.000000
	MaxSpeed=23000.000000
	Damage=110.000000
	DamageRadius=512.000000
	WallPenetrationForce=64
	MomentumTransfer=60000.000000
	MyDamageType=Class'BWBP_SKC_Pro.DTBulldogFRAG'
	MyRadiusDamageType=Class'BWBP_SKC_Pro.DTBulldogFRAGRadius'

	LightType=LT_Steady
	LightEffect=LE_QuadraticNonIncidence
	LightHue=25
	LightSaturation=100
	LightBrightness=200.000000
	LightRadius=15.000000
	bDynamicLight=True

	StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj'
	RotationRate=(Roll=32768)

	AmbientSound=Sound'BW_Core_WeaponSound.G5.G5-RocketFly'
	SoundVolume=192
	SoundRadius=128.000000

	DrawScale=2.500000

	bIgnoreTerminalVelocity=True
	ModeIndex=1
}
