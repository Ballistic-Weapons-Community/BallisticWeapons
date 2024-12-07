//=============================================================================
// A49LobProjectileRed.
//
// Bigger, redder projectile for da A73.
//
// Kaboodles
//=============================================================================
class A49LobProjectileRed extends BallisticProjectile;

var() float FallSpeed;



simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, None);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	Explode(Location, HitNormal);
}

simulated function InitProjectile ()
{
	InitEffects();
}

defaultproperties
{
	WeaponClass=Class'BWBP_SKC_Pro.A49SkrithBlaster'
	FallSpeed=600.000000
	ImpactManager=Class'BallisticProV55.IM_A73PowerB'
	bPenetrate=False
	TrailClass=Class'BallisticProV55.A73PowerTrailEmitterB'
	MyRadiusDamageType=Class'BWBP_SKC_Pro.DTA49Skrith'
	bUsePositionalDamage=False
	ShakeRadius=384.000000
	ShakeRotMag=(Y=200.000000,Z=128.000000)
	ShakeRotRate=(X=3000.000000,Z=3000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(Y=15.000000,Z=15.000000)
	ShakeOffsetTime=2.000000
	MotionBlurRadius=250.000000
	MotionBlurFactor=2.000000
	MotionBlurTime=2.000000
	MyDamageType=Class'BWBP_SKC_Pro.DTA49Skrith'
	LightHue=150
	LightSaturation=0
	LightBrightness=225.000000
	LightRadius=18.000000
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkProjBig'
	LifeSpan=9.000000
	Physics=PHYS_Falling
	Skins(0)=FinalBlend'BW_Core_WeaponTex.A73OrangeLayout.A73BPowerF2'
	Skins(1)=FinalBlend'BW_Core_WeaponTex.A73OrangeLayout.A73BPowerF1'
	SoundRadius=128.000000
	bFixedRotationDir=False
	bOrientToVelocity=True
}
