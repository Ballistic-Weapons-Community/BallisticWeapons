//=============================================================================
// A73OrangeLayoutPOWAHTrail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class A73PowerTrailEmitterB extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         UniformSize=True
         ColorScale(0)=(Color=(G=128,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=255,R=255))
         ColorMultiplierRange=(X=(Min=8.000000,Max=0.800000),Y=(Min=2.000000,Max=0.400000),Z=(Min=0.000000,Max=0.200000))
         Opacity=0.700000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartLocationOffset=(X=100.000000)
         StartSizeRange=(X=(Min=60.000000,Max=80.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.A73OrangeLayout.A73bPower'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.200000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.A73PowerTrailEmitterB.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=8.000000,Max=0.800000),Y=(Min=2.000000,Max=0.400000),Z=(Min=0.000000,Max=0.200000))
         Opacity=0.940000
         FadeOutStartTime=0.390000
         FadeInEndTime=0.080000
         CoordinateSystem=PTCS_Relative
         MaxParticles=12
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=35.000000,Max=50.000000),Y=(Min=35.000000,Max=50.000000),Z=(Min=35.000000,Max=50.000000))
         Texture=Texture'BW_Core_WeaponTex.A73OrangeLayout.A73bPower'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.A73PowerTrailEmitterB.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=32,G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=32,G=64,R=255,A=255))
         FadeOutStartTime=0.670000
         FadeInEndTime=0.130000
         MaxParticles=250
         StartLocationOffset=(X=-10.000000)
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Max=25.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.A73PowerTrailEmitterB.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=64,R=255,A=255))
         Opacity=0.390000
         FadeOutStartTime=1.525000
         FadeInEndTime=0.125000
         MaxParticles=175
         StartLocationOffset=(X=-20.000000,Z=10.000000)
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.500000,Max=2.500000)
         StartVelocityRange=(X=(Min=-25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=15.000000,Max=50.000000))
         VelocityLossRange=(Z=(Max=0.500000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.A73PowerTrailEmitterB.SpriteEmitter9'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=50
         DistanceThreshold=500.000000
         PointLifeTime=3.500000
         FadeOut=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
         Opacity=0.600000
         FadeOutStartTime=0.100000
         MaxParticles=1
         DetailMode=DM_SuperHigh
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=4.000000,Max=5.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BW_Core_WeaponTex.A73OrangeLayout.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(7)=TrailEmitter'BallisticProV55.A73PowerTrailEmitterB.TrailEmitter1'

     bNoDelete=False
}
