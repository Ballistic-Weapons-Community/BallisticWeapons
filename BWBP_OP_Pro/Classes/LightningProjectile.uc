//=============================================================================
// Slow moving energy projectile
//
// To do: Slow vehicles.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LightningProjectile extends BallisticProjectile;

// Got hit, explode with a tiny delay
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (class<DT_LightningRifle>(DamageType) == None)
		return;

    Damage = 1;

	Explode(Location, Normal(Velocity));
}

defaultproperties
{
     ImpactManager=Class'BWBP_OP_Pro.IM_LightningArcProj'
     AccelSpeed=500.000000
     MyRadiusDamageType=Class'BWBP_OP_Pro.DT_LightningProjectile'
     bTearOnExplode=True
     MotionBlurRadius=300.000000
     ShakeRotMag=(Y=200.000000,Z=128.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Y=15.000000,Z=15.000000)
     ShakeOffsetTime=2.000000
     Speed=250.000000
     MaxSpeed=5000.000000
     bSwitchToZeroCollision=True
     Damage=70.000000
     DamageRadius=100.000000
     MyDamageType=Class'BWBP_OP_Pro.DT_LightningProjectile'
     bDynamicLight=True
     LightType=LT_Steady
     LightHue=150
     LightSaturation=0
     LightBrightness=225.000000
     LightRadius=12.000000
     StaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleSphere3'
     Skins(0)=FinalBlend'PickupSkins.Shaders.FinalHealthCore'
     DrawScale=0.300000
     bNetTemporary=False
     AmbientSound=Sound'WeaponSounds.ShockRifleProjectile'
     LifeSpan=16.000000
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     CollisionRadius=16.000000
     CollisionHeight=16.000000
     bCollideActors=True
     bCollideWorld=True
     bProjTarget=True
}