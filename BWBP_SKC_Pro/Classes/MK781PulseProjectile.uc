//=============================================================================
// X007Projectile.
//
// An electrical bolt
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mk781PulseProjectile extends BallisticProjectile;

var() Sound FlySound;

var int ImpactDamage;

simulated function PostBeginPlay()
{
	SetTimer(0.15, false);
	super.PostBeginPlay();
	if (FastTrace(Location + vector(rotation) * 3000, Location))
		PlaySound(FlySound, SLOT_Interact, 1.0, , 512, , false);
}

simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, None);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	Explode(Location, HitNormal);
}

simulated event Tick(float DT)
{
	local Rotator R;

	R.Roll = Rotation.Roll;
	SetRotation(Rotator(velocity)+R);
}

simulated event Timer()
{
	SetPhysics(PHYS_Falling);
}

defaultproperties
{
     ImpactDamage=100
     ImpactManager=Class'BWBP_SKC_Pro.IM_EMPRocketAlt'
     bCheckHitSurface=True
     bRandomStartRotation=False
     AccelSpeed=50000.000000
     TrailClass=Class'Onslaught.ONSBluePlasmaSmallFireEffect'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_Mk781Bolt'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=1024.000000
     MotionBlurRadius=200.000000
     Speed=2500.000000
     MaxSpeed=5000.000000
     Damage=100.000000
     DamageRadius=256.000000
     MomentumTransfer=70000.000000
     MyDamageType=Class'BWBP_SKC_Pro.DT_Mk781Bolt'
     LightHue=180
     LightSaturation=100
     LightBrightness=160.000000
     LightRadius=8.000000
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkProjBig'
     AmbientSound=Sound'WeaponSounds.ShockRifle.ShockRifleProjectile'
     LifeSpan=16.000000
     Skins(0)=FinalBlend'BWBP_SKC_Tex.LS14.EMPProjFB'
     Skins(1)=FinalBlend'BWBP_SKC_Tex.LS14.EMPProjFB'
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
	 ModeIndex=1
}
