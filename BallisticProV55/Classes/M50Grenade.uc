//=============================================================================
// M50Grenade.
//
// Grenade fired by M900 Attached grenade launcher.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M50Grenade extends BallisticGrenade;

defaultproperties
{
    WeaponClass=Class'BallisticProV55.M50AssaultRifle'

    ArmingDelay=0.3
	UnarmedDetonateOn=DT_ImpactTimed
    UnarmedPlayerImpactType=PIT_Bounce
    ArmedDetonateOn=DT_Impact
    ArmedPlayerImpactType=PIT_Detonate

    bNoInitialSpin=True
    bAlignToVelocity=True
    DetonateDelay=1.000000
    ImpactDamageType=Class'BallisticProV55.DTM50Grenade'
    ImpactManager=Class'BallisticProV55.IM_M50Grenade'
    ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
    TrailClass=Class'BallisticProV55.M50GrenadeTrail'
    TrailOffset=(X=-8.000000)
    MyRadiusDamageType=Class'BallisticProV55.DTM50GrenadeRadius'
    SplashManager=Class'BallisticProV55.IM_ProjWater'
    ShakeRadius=256.000000
    MotionBlurRadius=384.000000
    MotionBlurFactor=3.000000
    MotionBlurTime=2.000000
    WallPenetrationForce=64
    MyDamageType=Class'BallisticProV55.DTM50GrenadeRadius'
    ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
    StaticMesh=StaticMesh'BW_Core_WeaponStatic.M900.M900Grenade'
    bIgnoreTerminalVelocity=True
	ModeIndex=1
}
