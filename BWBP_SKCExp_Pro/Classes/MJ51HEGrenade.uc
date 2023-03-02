//=============================================================================
// MJ51HEGrenade.
//
// Rifle grenade fired by the MJ51
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MJ51HEGrenade extends BallisticGrenade;


defaultproperties
{
    DetonateOn=DT_Impact
    PlayerImpactType=PIT_Detonate
    bNoInitialSpin=True
    bAlignToVelocity=True
    ImpactDamage=80
    ImpactDamageType=Class'BWBP_SKCExp_Pro.DTMJ51HEGrenade'
    ImpactManager=Class'BWBP_SKC_Pro.IM_LonghornMax'
    ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BWBP_SKC_Pro.ChaffTrail'
    TrailOffset=(X=-8.000000)
    MyRadiusDamageType=Class'BWBP_SKCExp_Pro.DTMJ51HEGrenade'
    SplashManager=Class'BallisticProV55.IM_ProjWater'
    ShakeRadius=512.000000
    MotionBlurRadius=384.000000
    MotionBlurFactor=3.000000
    MotionBlurTime=4.000000
    Speed=1750.000000
    MaxSpeed=4500.000000
    Damage=140.000000
    DamageRadius=512.000000
    WallPenetrationForce=128
    MyDamageType=Class'BWBP_SKCExp_Pro.DTMJ51HEGrenade'
    ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
    StaticMesh=StaticMesh'BWBP_SKC_StaticExp.MJ51.MOACProjLaunched'
    DrawScale=0.120000
    bIgnoreTerminalVelocity=True
	ModeIndex=1
}
