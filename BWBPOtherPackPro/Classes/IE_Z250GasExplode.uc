class IE_Z250GasExplode extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=151,G=232,R=177,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=64,A=255))
         Opacity=0.470000
         FadeOutStartTime=0.391000
         MaxParticles=30
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=5.000000)
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=4.000000,Max=20.000000),Y=(Min=2.000000,Max=10.000000),Z=(Min=2.000000,Max=10.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaBubbleA1'
         LifetimeRange=(Min=1.000000,Max=1.700000)
         StartVelocityRadialRange=(Min=15.000000,Max=250.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.IE_Z250GasExplode.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-250.000000)
         ColorScale(0)=(Color=(G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.630000
         FadeOutStartTime=0.075000
         FadeInEndTime=0.045000
         MaxParticles=20
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=5.000000)
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=15.000000,Max=35.000000),Y=(Min=15.000000,Max=35.000000),Z=(Min=15.000000,Max=35.000000))
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke5'
         LifetimeRange=(Min=1.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-900.000000,Max=900.000000),Y=(Min=-900.000000,Max=900.000000),Z=(Max=1300.000000))
         VelocityLossRange=(X=(Max=6.000000),Y=(Max=6.000000),Z=(Max=6.000000))
         GetVelocityDirectionFrom=PTVD_StartPositionAndOwner
     End Object
     Emitters(1)=SpriteEmitter'BWBPOtherPackPro.IE_Z250GasExplode.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.700000,Max=0.700000))
         Opacity=0.400000
         FadeOutStartTime=0.140000
         FadeInEndTime=0.045000
         MaxParticles=1
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         LifetimeRange=(Min=0.900000,Max=0.900000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPOtherPackPro.IE_Z250GasExplode.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.700000,Max=0.700000))
         Opacity=0.400000
         FadeOutStartTime=0.140000
         FadeInEndTime=0.045000
         MaxParticles=1
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         LifetimeRange=(Min=0.900000,Max=0.900000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPOtherPackPro.IE_Z250GasExplode.SpriteEmitter0'

}
