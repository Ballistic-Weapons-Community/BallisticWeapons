//=============================================================================
// A42TrailEmitterBal.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class A42TrailEmitterBal extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=30,G=128,R=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=130,G=180,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=255,R=192))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.800000))
         Opacity=0.450000
         FadeOutStartTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartLocationOffset=(X=20.000000)
         StartSizeRange=(X=(Min=10.000000,Max=15.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.200000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.A42TrailEmitterBal.SpriteEmitter0'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=50.000000
         UseCrossedSheets=True
         PointLifeTime=0.750000
         FadeOut=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=8.000000,Max=0.800000),Y=(Min=0.250000,Max=0.350000),Z=(Min=0.100000,Max=0.150000))
         Opacity=0.300000
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSizeRange=(X=(Min=2.000000,Max=3.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=9999.000000,Max=9999.000000)
     End Object
     Emitters(1)=TrailEmitter'BallisticProV55.A42TrailEmitterBal.TrailEmitter0'

     bNoDelete=False
}
