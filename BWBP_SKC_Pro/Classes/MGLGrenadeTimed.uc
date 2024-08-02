//=============================================================================
// MGL870Grenade.
//
// Grenade fired by MGL-870 grenade launcher.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MGLGrenadeTimed extends BallisticGrenade;

defaultproperties
{
	WeaponClass=Class'BWBP_SKC_Pro.MGLauncher'
	ArmedPlayerImpactType=PIT_Detonate
	bNoInitialSpin=True
	bAlignToVelocity=True
	DampenFactor=0.50000
	DampenFactorParallel=0.300000
	DetonateDelay=2.000000
	ImpactDamage=60
	ImpactDamageType=Class'BWBP_SKC_Pro.DTMGLGrenade'
	ImpactManager=Class'BWBP_SKC_Pro.IM_MGLGrenade'
	ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
	TrailClass=Class'BWBP_SKC_Pro.MGLNadeTrail'
	MyRadiusDamageType=Class'BWBP_SKC_Pro.DTMGLGrenadeRadius'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=512.000000
	MotionBlurRadius=400.000000
	MotionBlurFactor=3.000000
	MotionBlurTime=4.000000
	WallPenetrationForce=64
	Speed=4500.000000
	Damage=140.000000
	DamageRadius=768.000000
	MyDamageType=Class'BWBP_SKC_Pro.DTMGLGrenadeRadius'
	ImpactSound=Sound'BWBP_SKC_Sounds.Misc.FLAK-GrenadeBounce'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.M900.M900Grenade'
}
