//=============================================================================
// BG_SlashHitBot.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_SlashHitBot extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(2)=1
     DisableDGV(3)=1
     bModifyLossRange=False
     Begin Object Class=TrailEmitter Name=TrailEmitter10
         TrailShadeType=PTTST_PointLife
         MaxPointsPerTrail=15
         DistanceThreshold=8.000000
         PointLifeTime=0.600000
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.400000),Z=(Min=0.500000))
         Opacity=0.900000
         FadeOutStartTime=0.350000
         FadeInEndTime=0.100000
         MaxParticles=3
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=8.000000)
         StartSizeRange=(X=(Min=5.000000,Max=25.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.Particles.BloodMistShot1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-100.000000,Max=-25.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-100.000000))
     End Object
     Emitters(0)=TrailEmitter'BallisticProV55.BG_SlashHitBot.TrailEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter41
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ExtentMultiplier=(X=0.300000,Y=0.300000,Z=0.300000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.610000
         FadeOutStartTime=0.198000
         FadeInEndTime=0.036000
         MaxParticles=15
         StartLocationOffset=(X=5.000000)
         StartLocationRange=(Y=(Max=10.000000))
         SpinsPerSecondRange=(X=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=2.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=1.000000,Max=5.000000),Y=(Min=1.000000,Max=5.000000),Z=(Min=1.000000,Max=5.000000))
         InitialParticlesPerSecond=50.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.Bot.Bot-Saw4'
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=1000.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=-100.000000,Max=-10.000000),Y=(Min=5.000000,Max=75.000000),Z=(Min=50.000000,Max=100.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.BG_SlashHitBot.SpriteEmitter41'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter42
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.500000),Z=(Min=0.600000))
         Opacity=0.650000
         FadeOutStartTime=0.900000
         FadeInEndTime=0.200000
         MaxParticles=1
         StartLocationOffset=(X=5.000000)
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=2.000000)
         StartVelocityRange=(X=(Min=-50.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=30.000000))
         VelocityLossRange=(X=(Min=1.500000,Max=1.500000),Y=(Min=1.500000,Max=1.500000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.BG_SlashHitBot.SpriteEmitter42'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter43
         UseDirectionAs=PTDU_Up
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-200.000000)
         ExtentMultiplier=(X=0.300000,Y=0.300000,Z=0.300000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.200000),Y=(Min=0.500000),Z=(Min=0.600000))
         FadeOutStartTime=0.180000
         StartLocationOffset=(X=5.000000)
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=5.000000,Max=10.000000),Z=(Min=5.000000,Max=10.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticWeapons2.Effects.SparkA1Alpha'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=1000.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-100.000000,Max=-50.000000),Y=(Min=-40.000000,Max=40.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.BG_SlashHitBot.SpriteEmitter43'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter44
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-250.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.200000),Y=(Min=0.500000),Z=(Min=0.600000))
         FadeOutStartTime=0.680000
         MaxParticles=20
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=5.000000,Max=10.000000),Z=(Min=5.000000,Max=10.000000))
         InitialParticlesPerSecond=175.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticWeapons2.Effects.SparkA1Alpha'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=50.000000,Max=400.000000),Z=(Max=25.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.BG_SlashHitBot.SpriteEmitter44'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter46
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.275000,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000),Z=(Min=0.700000,Max=0.800000))
         Opacity=0.800000
         FadeOutStartTime=0.063000
         MaxParticles=15
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=5.000000,Max=10.000000),Z=(Min=5.000000,Max=10.000000))
         InitialParticlesPerSecond=150.000000
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-100.000000,Max=-10.000000),Y=(Max=500.000000),Z=(Min=-50.000000,Max=100.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.BG_SlashHitBot.SpriteEmitter46'

     AutoDestroy=True
}
