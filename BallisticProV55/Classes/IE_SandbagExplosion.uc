class IE_SandbagExplosion extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter42
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=60.000000)
         ExtentMultiplier=(X=0.400000,Y=0.400000,Z=0.400000)
         ColorScale(0)=(Color=(B=111,G=202,R=251,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=66,G=205,R=251))
         Opacity=0.300000
         MaxParticles=20
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=6.000000,Max=12.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         SizeScale(3)=(RelativeTime=0.370000,RelativeSize=0.900000)
         SizeScale(4)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Max=75.000000),Y=(Max=75.000000),Z=(Max=75.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRadialRange=(Min=-500.000000,Max=-300.000000)
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=4.000000,Max=4.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_SandbagExplosion.SpriteEmitter42'

     AutoDestroy=True
}
