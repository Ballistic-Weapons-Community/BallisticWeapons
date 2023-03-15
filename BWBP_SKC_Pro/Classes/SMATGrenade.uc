//=============================================================================
// SMATGrenade.
//
// Grenade fired by SMAT Launcher.
//
// by SK
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SMATGrenade extends BallisticGrenade;

defaultproperties
{
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=0.000001
     ImpactDamage=120
     ImpactManager=Class'BallisticProV55.IM_RPG'
     TrailClass=Class'BallisticProV55.M50GrenadeTrail'
     TrailOffset=(X=-8.000000)
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DTSMATSuicide'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=2048.000000
     MotionBlurRadius=1768.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     ShakeRotMag=(X=512.000000,Y=400.000000)
     ShakeRotRate=(X=3000.000000,Z=3000.000000)
     ShakeOffsetMag=(X=20.000000,Y=30.000000,Z=30.000000)
     Speed=0.010000
     MaxSpeed=10000.000000
     Damage=1512.000000
     DamageRadius=768.000000
     MomentumTransfer=180000.000000
     MyDamageType=Class'BWBP_SKC_Pro.DTSMATSuicide'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.G5.G5Rocket'
     bDynamicLight=True
     AmbientSound=Sound'BW_Core_WeaponSound.G5.G5-RocketFly'
     DrawScale=0.500000
     SoundVolume=192
     SoundRadius=128.000000
     RotationRate=(Roll=32768)
}
