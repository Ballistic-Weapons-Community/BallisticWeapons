//-----------------------------------------------------------
// The trail effects for the KH MarkII cobra's TOW missiles.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//-----------------------------------------------------------
class KHMKIIRocketTrail extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.200000
         FadeOutStartTime=0.350000
         MaxParticles=400
         SpinsPerSecondRange=(X=(Min=0.250000,Max=0.500000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'EmitterTextures.MultiFrame.LargeFlames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-80.000000,Max=-60.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIRocketTrail.SpriteEmitter21'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter22
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.300000
         FadeOutStartTime=3.500000
         MaxParticles=300
         SpinsPerSecondRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=3.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=80.000000,Max=80.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'EmitterTextures.MultiFrame.smoke_a'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=5.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=-40.000000,Max=-20.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIRocketTrail.SpriteEmitter22'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=100
         DistanceThreshold=32.000000
         UseCrossedSheets=True
         PointLifeTime=3.000000
         AutomaticInitialSpawning=False
         Opacity=0.300000
         MaxParticles=1
         StartSizeRange=(X=(Min=48.000000,Max=48.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'AS_FX_TX.Trails.Trail_Blue'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(2)=TrailEmitter'BWBP_VPC_Pro.KHMKIIRocketTrail.TrailEmitter0'

     AutoDestroy=True
     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
}
