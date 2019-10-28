class IE_RaygunPlagueChargedExplosion extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter58
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=83,G=108,R=89,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=20,G=107,R=103,A=255))
         FadeOutStartTime=0.560000
         FadeInEndTime=0.020000
         MaxParticles=1
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=3.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=6.000000)
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.IE_RaygunPlagueChargedExplosion.SpriteEmitter58'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=151,G=232,R=177,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=64,A=255))
         FadeOutStartTime=0.200000
         MaxParticles=30
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=5.000000)
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.SmokeWisp-Alpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRadialRange=(Min=20.000000,Max=250.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(1)=SpriteEmitter'BWBPOtherPackPro.IE_RaygunPlagueChargedExplosion.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.330000
         FadeOutStartTime=0.040080
         MaxParticles=1
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.501000,Max=0.501000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPOtherPackPro.IE_RaygunPlagueChargedExplosion.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.500000),Z=(Min=0.000000,Max=0.500000))
         Opacity=0.630000
         FadeOutStartTime=0.077500
         FadeInEndTime=0.027500
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=5.000000)
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=25.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.NewSmoke1f'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRadialRange=(Min=350.000000,Max=500.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(3)=SpriteEmitter'BWBPOtherPackPro.IE_RaygunPlagueChargedExplosion.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=43,G=82,R=85,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=128,R=128,A=255))
         FadeOutStartTime=0.510000
         FadeInEndTime=0.090000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(4)=SpriteEmitter'BWBPOtherPackPro.IE_RaygunPlagueChargedExplosion.SpriteEmitter3'

}
