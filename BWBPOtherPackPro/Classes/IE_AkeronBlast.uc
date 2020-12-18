class IE_AkeronBlast extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter23
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.138000
         CoordinateSystem=PTCS_Relative
         MaxParticles=25
         StartLocationRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=0.900000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.250000)
         StartSizeRange=(X=(Min=15.000000,Max=35.000000),Y=(Min=15.000000,Max=35.000000),Z=(Min=15.000000,Max=35.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Explosions.Fire.Fireballs1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.400000,Max=0.600000)
         StartVelocityRange=(X=(Max=1600.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
         VelocityLossRange=(X=(Min=4.000000,Max=4.000000))
         GetVelocityDirectionFrom=PTVD_StartPositionAndOwner
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.IE_AkeronBlast.SpriteEmitter23'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter24
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.350000,Max=0.350000),Y=(Min=0.350000,Max=0.350000),Z=(Min=0.350000,Max=0.350000))
         Opacity=0.280000
         FadeOutStartTime=1.720000
         FadeInEndTime=0.680000
         CoordinateSystem=PTCS_Relative
         MaxParticles=35
         StartLocationRange=(X=(Min=-1.000000,Max=-1.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         StartSizeRange=(X=(Min=30.000000,Max=55.000000),Y=(Min=30.000000,Max=55.000000),Z=(Min=30.000000,Max=55.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.NewSmoke1g'
         StartVelocityRange=(X=(Min=50.000000,Max=1000.000000),Y=(Min=-260.000000,Max=250.000000),Z=(Min=-260.000000,Max=250.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         GetVelocityDirectionFrom=PTVD_StartPositionAndOwner
     End Object
     Emitters(1)=SpriteEmitter'BWBPOtherPackPro.IE_AkeronBlast.SpriteEmitter24'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.660000
         FadeOutStartTime=0.174000
         FadeInEndTime=0.120000
         CoordinateSystem=PTCS_Relative
         StartLocationRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         SpinsPerSecondRange=(X=(Max=0.500000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=35.000000,Max=75.000000),Y=(Min=35.000000,Max=75.000000),Z=(Min=35.000000,Max=75.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'AW-2004Explosions.Fire.Fireball2'
         LifetimeRange=(Min=0.400000,Max=0.600000)
         StartVelocityRange=(X=(Min=1500.000000,Max=2500.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000))
         GetVelocityDirectionFrom=PTVD_StartPositionAndOwner
     End Object
     Emitters(2)=SpriteEmitter'BWBPOtherPackPro.IE_AkeronBlast.SpriteEmitter0'

     AutoDestroy=True
}
