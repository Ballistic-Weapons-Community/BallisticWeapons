//=============================================================================
// LAWSparkEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class LAWSparkEmitter extends BallisticEmitter
	placeable;

simulated event BaseChange()
{
	if (Base == None)
		Destroy();
}

function InvertY()
{
	local int i;
	for (i=0;i<Emitters.length;i++)
	{
		Emitters[i].StartLocationOffset.Y *= -1;
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseCollisionPlanes=True
         UseMaxCollisions=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseRandomSubdivision=True
         CollisionPlanes(0)=(Y=1.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.500000),Z=(Min=0.000000))
         FadeOutStartTime=0.800000
         FadeInEndTime=0.110000
         CoordinateSystem=PTCS_Relative
         MaxParticles=25
         StartLocationOffset=(X=-25.000000)
         StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.500000,Max=2.500000))
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=2.000000,Max=8.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.LAWSparkEmitter.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.500000,Max=0.500000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-25.000000)
         StartSpinRange=(X=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=35.000000,Max=35.000000),Y=(Min=35.000000,Max=35.000000),Z=(Min=35.000000,Max=35.000000))
         Texture=Texture'BallisticWeapons2.Effects.ClampedFlare1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.LAWSparkEmitter.SpriteEmitter1'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=6.000000,Max=64.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         HighFrequencyPoints=8
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000))
         FadeOutStartTime=0.076000
         FadeInEndTime=0.020000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartLocationOffset=(X=-25.000000)
         StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Z=(Min=-2.000000,Max=2.000000))
         SizeScale(0)=(RelativeSize=1.250000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.250000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
         InitialParticlesPerSecond=5.000000
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
         StartVelocityRadialRange=(Min=-1.000000,Max=-1.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(2)=BeamEmitter'BWBPRecolorsPro.LAWSparkEmitter.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.200000),Y=(Min=0.000000,Max=0.208000),Z=(Min=0.000000))
         Opacity=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         AutoResetTimeRange=(Min=0.500000,Max=0.500000)
         StartLocationOffset=(X=-25.000000)
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=3.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=45.000000))
         Texture=Texture'AW-2004Particles.Energy.ElecPanels'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPRecolorsPro.LAWSparkEmitter.SpriteEmitter2'

     bHardAttach=True
}
