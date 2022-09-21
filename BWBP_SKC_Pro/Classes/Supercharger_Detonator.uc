//=============================================================================
// SMATGrenade.
//
// Grenade fired by SMAT Launcher.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_Detonator extends BallisticGrenade;


var   Supercharger_ChargeControl	ChargeControl;
var   Vector			EndPoint, StartPoint;
var   array<actor>		AlreadyHit;

simulated event PreBeginPlay()
{
	if (Owner != None && Pawn(Owner) != None)
		Instigator = Pawn(Owner);
	super.PreBeginPlay();
}

defaultproperties
{
	 bApplyParams=False
	 bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=0.2
     ImpactDamage=120
     ImpactManager=Class'BWBP_SKC_Pro.IM_XMExplosion'
	 bRandomStartRotation=False
     TrailClass=Class'BallisticProV55.M50GrenadeTrail'
     TrailOffset=(X=-8.000000)
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_Supercharge'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=1024.000000
     MotionBlurRadius=1024.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     ShakeRotMag=(X=512.000000,Y=400.000000)
     ShakeRotRate=(X=3000.000000,Z=3000.000000)
     ShakeOffsetMag=(X=20.000000,Y=30.000000,Z=30.000000)
     Speed=0.010000
     MaxSpeed=10000.000000
     Damage=400.000000
     DamageRadius=300.000000
     MomentumTransfer=180000.000000
     MyDamageType=Class'BWBP_SKC_Pro.DT_Supercharge'
	 DamageTypeHead=Class'BWBP_SKC_Pro.DT_Supercharge'
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
