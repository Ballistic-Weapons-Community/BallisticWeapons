//=============================================================================
// IE_ShellMetal.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_ShellMetal extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(3)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter39
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=128,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         StartLocationRange=(Y=(Min=-20.000000,Max=20.000000),Z=(Min=-15.000000,Max=15.000000))
         StartSizeRange=(X=(Min=1.500000,Max=3.000000))
         InitialParticlesPerSecond=100000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_ShellMetal.SpriteEmitter39'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter40
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=128,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255))
         FadeOutStartTime=0.500000
         MaxParticles=6
         StartLocationRange=(Y=(Min=-15.000000,Max=15.000000),Z=(Min=-10.000000,Max=10.000000))
         StartSizeRange=(X=(Min=0.500000,Max=1.500000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=25.000000,Max=100.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=70.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_ShellMetal.SpriteEmitter40'

     Begin Object Class=SparkEmitter Name=SparkEmitter4
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBetweenSegmentsRange=(Min=0.100000,Max=0.200000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=192,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255))
         FadeOutStartTime=0.500000
         StartLocationRange=(Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=12.000000))
         InitialParticlesPerSecond=100000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.250000,Max=1.250000)
         StartVelocityRange=(X=(Min=25.000000,Max=100.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-20.000000,Max=50.000000))
     End Object
     Emitters(2)=SparkEmitter'BallisticProV55.IE_ShellMetal.SparkEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.800000,Max=0.900000),Z=(Min=0.500000,Max=0.700000))
         Opacity=0.650000
         FadeOutStartTime=0.132000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=2.000000)
         StartLocationRange=(Y=(Min=-18.000000,Max=18.000000),Z=(Min=-13.000000,Max=13.000000))
         StartSizeRange=(X=(Min=5.000000,Max=15.000000),Y=(Min=5.000000,Max=15.000000),Z=(Min=5.000000,Max=15.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.200000,Max=0.400000)
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_ShellMetal.SpriteEmitter1'

     AutoDestroy=True
}
