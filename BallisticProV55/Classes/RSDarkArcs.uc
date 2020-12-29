//=============================================================================
// RSNovaArc.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkArcs extends BallisticEmitter;

simulated function SetGap(float Alpha)
{
	Emitters[0].StartLocationOffset.Z = default.Emitters[0].StartLocationOffset.Z * Alpha * Owner.DrawScale;
	Emitters[0].StartVelocityRange.Z.Max = default.Emitters[0].StartVelocityRange.Z.Max * Alpha * Owner.DrawScale;
	Emitters[0].StartVelocityRange.Z.Min = Emitters[0].StartVelocityRange.Z.Max;

	Emitters[1].StartLocationOffset.Z = default.Emitters[1].StartLocationOffset.Z * Alpha * Owner.DrawScale;
	Emitters[2].StartLocationOffset.Z = default.Emitters[2].StartLocationOffset.Z * Alpha * Owner.DrawScale;
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         LowFrequencyNoiseRange=(X=(Min=-1.500000,Max=1.500000),Y=(Min=-1.500000,Max=1.500000))
         HighFrequencyNoiseRange=(X=(Min=-0.500000,Max=0.500000),Y=(Min=-0.500000,Max=0.500000))
         HighFrequencyPoints=5
         UseColorScale=True
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=64,G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.250000,Color=(G=64,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.033000
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         StartLocationOffset=(Z=-3.000000)
         StartLocationRange=(X=(Max=40.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.800000,Max=1.200000),Y=(Min=0.800000,Max=1.200000),Z=(Min=0.800000,Max=1.200000))
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
         StartVelocityRange=(Z=(Min=18.000000,Max=18.000000))
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.RSDarkArcs.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Normal
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=18.000000,Z=-2.200000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=1.700000,Max=1.700000),Z=(Min=1.700000,Max=1.700000))
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSDarkArcs.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Normal
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=18.000000,Z=2.200000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=1.700000,Max=1.700000),Z=(Min=1.700000,Max=1.700000))
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSDarkArcs.SpriteEmitter1'

}
