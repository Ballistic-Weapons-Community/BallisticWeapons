class IE_RaygunProjectile extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter27
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=200,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.225000
         FadeInEndTime=0.015000
         MaxParticles=1
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=4.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=9.000000)
         StartSizeRange=(X=(Min=15.000001,Max=15.000001),Y=(Min=15.000001,Max=15.000001),Z=(Min=15.000001,Max=15.000001))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
         LifetimeRange=(Min=0.750000,Max=0.750000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.IE_RaygunProjectile.SpriteEmitter27'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter28
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(Z=-250.000000)
         ColorScale(0)=(Color=(B=128,G=225,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=255,A=255))
         FadeOutStartTime=1.333333
         MaxParticles=5
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=5.000000)
         SpinsPerSecondRange=(X=(Max=0.150000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
         InitialParticlesPerSecond=75.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.SmokeWisp-Alpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.501000,Max=0.501000)
         StartVelocityRadialRange=(Min=30.000000,Max=95.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(1)=SpriteEmitter'BWBPOtherPackPro.IE_RaygunProjectile.SpriteEmitter28'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter31
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.210000
         FadeInEndTime=0.090000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=22.500000,Max=22.500000),Y=(Min=15.000001,Max=15.000001),Z=(Min=15.000001,Max=15.000001))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStarRed'
         LifetimeRange=(Min=0.750000,Max=0.750000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPOtherPackPro.IE_RaygunProjectile.SpriteEmitter31'

}
