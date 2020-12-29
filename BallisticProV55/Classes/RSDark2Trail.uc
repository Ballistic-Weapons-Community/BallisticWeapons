//=============================================================================
// RSDark2Trail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDark2Trail extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.250000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.580000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=35.000000,Max=35.000000),Y=(Min=35.000000,Max=35.000000),Z=(Min=35.000000,Max=35.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSDark2Trail.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.600000
         FadeInEndTime=0.250000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=0.500000,Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaBubbleA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSDark2Trail.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Normal
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.420000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=0.500000,Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSDark2Trail.SpriteEmitter2'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=50.000000
         UseCrossedSheets=True
         PointLifeTime=2.000000
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255))
         ColorMultiplierRange=(X=(Min=0.750000,Max=0.750000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.600000
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSizeRange=(X=(Min=3.000000,Max=4.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=9999.000000,Max=9999.000000)
     End Object
     Emitters(3)=TrailEmitter'BallisticProV55.RSDark2Trail.TrailEmitter0'

}
