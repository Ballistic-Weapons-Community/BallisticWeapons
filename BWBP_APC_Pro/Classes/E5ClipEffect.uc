//=============================================================================
// E5ClipEffect.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class E5ClipEffect extends BallisticEmitter;

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
         ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.800000
         FadeInEndTime=0.110000
         CoordinateSystem=PTCS_Relative
         MaxParticles=25
         StartLocationOffset=(Y=-22.000000)
         StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.500000,Max=2.500000))
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Y=(Min=5.000000,Max=50.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_APC_Pro.E5ClipEffect.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         SpinParticles=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(X=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=25.000000,Max=50.000000))
         Texture=Texture'BW_Core_WeaponTex.Effects.ClampedFlare1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_APC_Pro.E5ClipEffect.SpriteEmitter1'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=32.000000,Max=48.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         HighFrequencyPoints=8
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Z=(Min=0.300000,Max=0.500000))
         FadeOutStartTime=0.076000
         FadeInEndTime=0.020000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(Y=-25.000000)
         StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Z=(Min=-2.000000,Max=2.000000))
         SizeScale(0)=(RelativeSize=1.250000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.250000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
         InitialParticlesPerSecond=5.000000
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(Y=(Min=25.000000,Max=25.000000))
         StartVelocityRadialRange=(Min=-1.000000,Max=-1.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(2)=BeamEmitter'BWBP_APC_Pro.E5ClipEffect.BeamEmitter0'

     bHidden=True
     bHardAttach=True
}
