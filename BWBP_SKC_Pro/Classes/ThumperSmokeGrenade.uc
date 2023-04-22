//=============================================================================
// BOGPGrenade.
//
// Grenade fired by the BGOP Grenade Pistol.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class ThumperSmokeGrenade extends BallisticGrenade;

defaultproperties
{
	WeaponClass=Class'ThumperGrenadeLauncher'

	ArmingDelay=0.2
    UnarmedDetonateOn=DT_ImpactTimed
	UnarmedPlayerImpactType=PIT_Bounce
	ArmedDetonateOn=DT_Impact
	ArmedPlayerImpactType=PIT_Detonate
	
	bNoInitialSpin=True
	bAlignToVelocity=True
	DetonateDelay=1.000000
	ImpactDamage=25
	ImpactDamageType=Class'BWBP_SKC_Pro.DTTOPORSmokeGrenade'
	ImpactManager=Class'BWBP_SKC_Pro.IM_ChaffGrenade'
	ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
	TrailClass=Class'BallisticProV55.MRLTrailEmitter'
	TrailOffset=(X=-4.000000)
	MyRadiusDamageType=Class'BWBP_SKC_Pro.DTTOPORSmokeGrenadeRadius'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=256.000000
	MotionBlurRadius=384.000000
	MotionBlurFactor=3.000000
	MotionBlurTime=4.000000
	Speed=3500.000000
	Damage=30.000000
	DamageRadius=256.000000
	MyDamageType=Class'BWBP_SKC_Pro.DTTOPORSmokeGrenade'
	ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_Grenade'
	DrawScale=0.300000
	bIgnoreTerminalVelocity=True
}
