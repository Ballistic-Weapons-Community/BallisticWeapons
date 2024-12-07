//=============================================================================
// A800Projectile_Red.
//
// Red! and bouncy! Modified code overrides detonate on to impact after 1 bounce
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A800Projectile_Red extends BallisticGrenade;

// don't override - use DampenFactor and DampenFactorParallel
simulated function HitWall(vector HitNormal, actor Wall)
{
  //local Vector VNorm;

	super.HitWall(HitNormal, Wall);

	if (DetonateOn != DT_Impact)
	{
		DetonateOn = DT_Impact;
	}
}

defaultproperties
{
	ArmedDetonateOn=DT_Timed
	ArmedPlayerImpactType=PIT_Detonate
    DampenFactor=0.9
    DampenFactorParallel=0.9
	ArmingDelay=0
	DetonateDelay=1
	RandomSpin=0
	WeaponClass=Class'BWBP_SWC_Pro.A800SkrithMinigun'
	bPenetrate=True
	AccelSpeed=100000.000000
	ImpactDamageType=Class'BWBP_SWC_Pro.DTA800MG'
	MyDamageType=Class'BWBP_SWC_Pro.DTA800MG'
	MyRadiusDamageType=Class'BWBP_SWC_Pro.DTA800MG'
	bUsePositionalDamage=True
	DamageTypeHead=Class'BWBP_SWC_Pro.DTA800MGHead'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	Speed=5500.000000
	MaxSpeed=14000.000000
	Damage=40.000000
	LightType=LT_Steady
	LightEffect=LE_QuadraticNonIncidence
	LightHue=180
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=6.000000
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.A73.A73Projectile'
	bDynamicLight=True
	AmbientSound=Sound'BW_Core_WeaponSound.A73.A73ProjFly'
	LifeSpan=4.000000
	Style=STY_Additive
    Physics=PHYS_Projectile
	SoundVolume=255
	SoundRadius=75.000000
	CollisionRadius=1.000000
	CollisionHeight=1.000000
	bFixedRotationDir=True
	RotationRate=(Roll=16384)
	DrawScale=0.6
	Skins(0)=FinalBlend'BW_Core_WeaponTex.A73OrangeLayout.A73BProjFinal'
	Skins(1)=FinalBlend'BW_Core_WeaponTex.A73OrangeLayout.A73BProj2Final'
	ImpactManager=Class'BallisticProV55.IM_A73ProjectileB'
	PenetrateManager=Class'BallisticProV55.IM_A73ProjectileB'
	TrailClass=Class'BallisticProV55.A73TrailEmitterB'
}
