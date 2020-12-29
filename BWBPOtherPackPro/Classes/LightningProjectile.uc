//=============================================================================
// Slow moving energy projectile
//
// To do: Slow vehicles.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LightningProjectile extends BallisticProjectile;

defaultproperties
{
     ImpactManager=Class'BWBPOtherPackPro.IM_LightningArcProj'
     AccelSpeed=150.000000
     MyRadiusDamageType=Class'BWBPOtherPackPro.DT_LightningProjectile'
     bTearOnExplode=False
     MotionBlurRadius=300.000000
     ShakeRotMag=(Y=200.000000,Z=128.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Y=15.000000,Z=15.000000)
     ShakeOffsetTime=2.000000
     Speed=250.000000
     MaxSpeed=10000.000000
     bSwitchToZeroCollision=True
     Damage=70.000000
     DamageRadius=100.000000
     MyDamageType=Class'BWBPOtherPackPro.DT_LightningProjectile'
     LightHue=180
     LightSaturation=100
     LightBrightness=160.000000
     LightRadius=8.000000
     StaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleSphere3'
     Skins(0)=FinalBlend'PickupSkins.Shaders.FinalHealthCore'
     DrawScale=0.200000
     bNetTemporary=False
     bSkipActorPropertyReplication=True
     bOnlyDirtyReplication=True
     AmbientSound=Sound'WeaponSounds.ShockRifleProjectile'
     LifeSpan=16.000000
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     CollisionRadius=20.000000
     CollisionHeight=20.000000
     bCollideActors=True
     bCollideWorld=True
     bProjTarget=True
}