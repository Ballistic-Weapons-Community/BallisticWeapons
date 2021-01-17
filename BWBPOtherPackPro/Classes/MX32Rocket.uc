class MX32Rocket extends BallisticProjectile;

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_MRLRocket'
     bRandomStartRotaion=False
     TrailClass=Class'BallisticProV55.MRLTrailEmitter'
     TrailOffset=(X=-4.000000)
     MyRadiusDamageType=Class'BWBPOtherPackPro.DT_MX32RocketRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=3500.000000
	 MaxSpeed=6000.000000
     Damage=48.000000
     DamageRadius=100.000000
     MomentumTransfer=20000.000000
     MyDamageType=Class'BWBPOtherPackPro.DT_MX32Rocket'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket'
     AmbientSound=Sound'BW_Core_WeaponSound.MRL.MRL-RocketFly'
     SoundVolume=64
     bCollideActors=True
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
