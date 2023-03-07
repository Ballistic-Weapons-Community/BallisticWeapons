//=============================================================================
// AY90WaveTrailEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90WaveTrailEmitter extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         UniformSize=True
         ColorScale(0)=(Color=(G=128,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=255,R=255))
         Opacity=0.700000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartLocationOffset=(X=100.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BWBP_SKC_Tex.A73b.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKCExp_Pro.AY90WaveTrailEmitter.SpriteEmitter1'

     Begin Object Class=BeamEmitter Name=BeamEmitter12
         BeamEndPoints(0)=(ActorTag="Second",Weight=1.000000)
         DetermineEndPointBy=PTEP_OffsetAsAbsolute
         BeamTextureUScale=2.000000
         LowFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-10.000000,Max=10.000000))
         LowFrequencyPoints=4
         Disabled=True
         Backup_Disabled=True
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         MaxParticles=3
         StartSizeRange=(X=(Min=5.000000,Max=10.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         LifetimeRange=(Min=0.010000,Max=0.010000)
     End Object
     Emitters(1)=BeamEmitter'BWBP_SKCExp_Pro.AY90WaveTrailEmitter.BeamEmitter12'

     bNoDelete=False
}
