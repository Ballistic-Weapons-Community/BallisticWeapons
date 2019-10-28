//=============================================================================
// IE_HVCDischarge.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_DefibDischarge extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Normal
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.539286,Color=(B=255,G=192,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.092000
         FadeInEndTime=0.032000
         MaxParticles=1
         DetailMode=DM_High
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=400.000000,Max=400.000000),Y=(Min=400.000000,Max=400.000000),Z=(Min=400.000000,Max=400.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BWBP2-FX.Particles.ElectroShock'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.IE_DefibDischarge.SpriteEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=150.000000,Max=300.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         HighFrequencyPoints=8
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.157143,Color=(B=128,G=64,A=255))
         ColorScale(2)=(RelativeTime=0.260714,Color=(B=255,G=224,R=192,A=255))
         ColorScale(3)=(RelativeTime=0.360714,Color=(B=128,A=255))
         ColorScale(4)=(RelativeTime=0.457143,Color=(B=255,G=192,R=128,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.300000
         FadeOutStartTime=0.112000
         MaxParticles=6
         DetailMode=DM_SuperHigh
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=3.000000,Max=5.000000),Z=(Min=3.000000,Max=5.000000))
         InitialParticlesPerSecond=150.000000
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-0.500000,Max=0.700000))
     End Object
     Emitters(1)=BeamEmitter'BWBPOtherPackPro.IE_DefibDischarge.BeamEmitter0'

     AutoDestroy=True
}
