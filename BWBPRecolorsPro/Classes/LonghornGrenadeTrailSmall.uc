//=============================================================================
// LonghornGrenadeTrailSmall.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class LonghornGrenadeTrailSmall extends BallisticEmitter;

simulated function ActivateBeacon()
{
	Emitters[3].Disabled=false;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=196,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.400000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.800000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=0.300000,Max=0.300000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=200.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.LonghornGrenadeTrailSmall.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=196,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.400000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.100000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationRange=(X=(Min=-8.000000,Max=-8.000000))
         SpinsPerSecondRange=(X=(Min=0.150000,Max=0.150000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=20.000000,Max=25.000000),Z=(Min=20.000000,Max=25.000000))
         InitialParticlesPerSecond=200.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.LonghornGrenadeTrailSmall.SpriteEmitter5'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=20
         DistanceThreshold=100.000000
         PointLifeTime=1.000000
         FadeOut=True
         FadeIn=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=64,G=64,R=64,A=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64,A=128))
         Opacity=0.100000
         FadeOutStartTime=0.400000
         FadeInEndTime=0.200000
         MaxParticles=3
         DetailMode=DM_High
         StartSizeRange=(X=(Min=70.000000,Max=80.000000),Y=(Min=25.000000,Max=27.000000),Z=(Min=25.000000,Max=27.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.750000,Max=1.000000)
     End Object
     Emitters(2)=TrailEmitter'BWBPRecolorsPro.LonghornGrenadeTrailSmall.TrailEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         FadeOut=True
         Disabled=True
         Backup_Disabled=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=196,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.160400
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.300000,Max=0.300000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=1.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         LifetimeRange=(Min=0.401000,Max=0.401000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPRecolorsPro.LonghornGrenadeTrailSmall.SpriteEmitter7'

     AutoDestroy=True
     bHardAttach=True
     bDirectional=True
}
