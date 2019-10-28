class RaygunPlagueShotTrail extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter22
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(G=200,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=128,A=255))
         FadeOutStartTime=0.560000
         FadeInEndTime=0.020000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=4.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=9.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         WarmupTicksPerSecond=1.000000
         RelativeWarmupTime=2.000000
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.RaygunPlagueShotTrail.SpriteEmitter22'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter23
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=1,G=126,R=111,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=30
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=5.000000)
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'AW-2004Particles.Energy.CloudLightning'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-50.000000,Max=-50.000000))
         StartVelocityRadialRange=(Min=35.000000,Max=35.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(1)=SpriteEmitter'BWBPOtherPackPro.RaygunPlagueShotTrail.SpriteEmitter23'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter24
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Z=(Min=0.000000,Max=0.000000))
         Opacity=0.330000
         FadeOutStartTime=0.040080
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPOtherPackPro.RaygunPlagueShotTrail.SpriteEmitter24'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter25
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.500000),Z=(Min=0.500000))
         Opacity=0.630000
         FadeOutStartTime=0.077500
         FadeInEndTime=0.027500
         MaxParticles=8
         DetailMode=DM_SuperHigh
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=5.000000)
         SpinsPerSecondRange=(X=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeSize=7.000000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         ParticlesPerSecond=8.000000
         InitialParticlesPerSecond=12.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.NewSmoke1f'
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRadialRange=(Min=30.000000,Max=370.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(3)=SpriteEmitter'BWBPOtherPackPro.RaygunPlagueShotTrail.SpriteEmitter25'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.160000
         FadeInEndTime=0.090000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         WarmupTicksPerSecond=1.000000
         RelativeWarmupTime=2.000000
     End Object
     Emitters(4)=SpriteEmitter'BWBPOtherPackPro.RaygunPlagueShotTrail.SpriteEmitter26'

}
