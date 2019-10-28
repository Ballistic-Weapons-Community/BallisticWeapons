//=============================================================================
// Emitter for ignition system.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22AIgniter extends BallisticEmitter;

defaultproperties
{
     EmitterZTestSwitches(1)=ZM_OffWhenVisible
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         TriggerDisabled=False
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=128,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.289286,Color=(B=255,G=192,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=160,R=64,A=255))
         FadeOutStartTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=30
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=5.000000,Max=8.000000),Y=(Min=5.000000,Max=8.000000),Z=(Min=5.000000,Max=8.000000))
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=25.000000,Max=30.000000)
         SpawnOnTriggerPPS=200.000000
         StartVelocityRange=(X=(Max=250.000000),Y=(Min=-40.000000,Max=40.000000),Z=(Min=-40.000000,Max=40.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RX22AIgniter.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ZTest=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.303571,Color=(B=255,G=192,R=64,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=64,A=255))
         Opacity=0.740000
         FadeOutStartTime=0.060000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=3.000000)
         SizeScale(0)=(RelativeSize=1.200000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=0.170000,RelativeSize=0.800000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=0.700000)
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         LifetimeRange=(Min=0.600000,Max=0.600000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=5000.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RX22AIgniter.SpriteEmitter5'

     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'BallisticHardware2.A42.A42MuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.900000,Max=0.900000))
         FadeOutStartTime=0.230000
         FadeInEndTime=0.210000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
         StartSizeRange=(X=(Min=0.150000,Max=0.150000),Y=(Min=0.130000,Max=0.130000),Z=(Min=0.130000,Max=0.130000))
         LifetimeRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=5000.000000
     End Object
     Emitters(2)=MeshEmitter'BallisticProV55.RX22AIgniter.MeshEmitter2'

}
