//=============================================================================
// A73BPOWAHTrail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Wendigo_EMPTrail extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         UniformSize=True
         ColorScale(0)=(Color=(B=128,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=64,B=255,R=255))
         ColorMultiplierRange=(X=(Max=0.100000),Y=(Min=0.000000,Max=0.500000),Z=(Min=2.000000,Max=4.000000))
         Opacity=0.700000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=20.000000)
         StartSizeRange=(X=(Min=40.000000,Max=60.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BWBP_SKC_Tex.LS14.EMPProj'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.200000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.Wendigo_EMPTrail.SpriteEmitter1'

     Begin Object Class=BeamEmitter Name=BeamEmitter4
         BeamDistanceRange=(Min=250.000000,Max=250.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         HighFrequencyNoiseRange=(Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=64,B=255,R=64,A=64))
         ColorScale(1)=(RelativeTime=0.303571,Color=(G=64,B=255,R=64,A=64))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=64))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.100000),Y=(Min=0.000000,Max=0.500000),Z=(Min=2.000000,Max=4.000000))
         FadeOutStartTime=0.416000
         CoordinateSystem=PTCS_Relative
         MaxParticles=12
         DetailMode=DM_High
         SizeScale(0)=(RelativeSize=1.500000)
         SizeScale(1)=(RelativeTime=0.550000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.500000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=5.000000,Max=0.000000),Z=(Min=5.000000,Max=0.000000))
         InitialParticlesPerSecond=20.000000
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
         StartVelocityRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
     End Object
     Emitters(8)=BeamEmitter'BWBP_SKC_Pro.Wendigo_EMPTrail.BeamEmitter4'

     bNoDelete=False
}
