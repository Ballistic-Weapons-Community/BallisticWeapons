//=============================================================================
// BOGPGrenadeSafe.
//
// Grenade fired by the BGOP Grenade Pistol. Won't detonate until armed.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BOGPGrenadeSafe extends BallisticGrenade;


defaultproperties
{
	WeaponClass=Class'BallisticProV55.BOGPPistol'

    ArmingDelay=0.25
	UnarmedDetonateOn=DT_Disarm
	UnarmedPlayerImpactType=PIT_Bounce
    ArmedDetonateOn=DT_Impact
    ArmedPlayerImpactType=PIT_Detonate

	bNoInitialSpin=True
	bAlignToVelocity=True
	DetonateDelay=1.000000
	ImpactDamageType=Class'BallisticProV55.DTBOGPGrenade'
	ImpactManager=Class'BallisticProV55.IM_M50Grenade'
	ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
	TrailClass=Class'BallisticProV55.MRLTrailEmitter'
	TrailOffset=(X=-4.000000)
	MyRadiusDamageType=Class'BallisticProV55.DTBOGPGrenadeRadius'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=256.000000
	MotionBlurRadius=384.000000
	MotionBlurFactor=3.000000
	MotionBlurTime=2.000000
	WallPenetrationForce=64
	MyDamageType=Class'BallisticProV55.DTBOGPGrenadeRadius'
	ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_Grenade'
	DrawScale=0.300000
	bIgnoreTerminalVelocity=True
}
