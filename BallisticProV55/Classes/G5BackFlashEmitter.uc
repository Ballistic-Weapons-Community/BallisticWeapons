//=============================================================================
// G5BackFlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class G5BackFlashEmitter extends DGVEmitter;

defaultproperties
{
     bAutoAlignVelocity=True
     DisableDGV(0)=1
     DisableDGV(1)=1
     bAutoInit=False
     Begin Object Class=MeshEmitter Name=MeshEmitter4
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.G5.BazookaBackFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=192))
         FadeOutStartTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(Z=(Min=3.000000,Max=3.000000))
         SizeScale(1)=(RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         DrawStyle=PTDS_Brighten
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.G5BackFlashEmitter.MeshEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter23
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(G=128,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255))
         FadeOutStartTime=0.300000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-40.000000)
         StartSizeRange=(X=(Min=150.000000,Max=150.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.G5BackFlashEmitter.SpriteEmitter23'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter24
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=128,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.078571,Color=(B=64,G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.164286,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         Opacity=0.540000
         FadeOutStartTime=0.800000
         FadeInEndTime=0.200000
         MaxParticles=120
         StartLocationOffset=(X=-80.000000)
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.500000,Max=2.500000)
         SpawnOnTriggerRange=(Min=120.000000,Max=120.000000)
         SpawnOnTriggerPPS=100.000000
         StartVelocityRange=(X=(Min=-400.000000,Max=-600.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         VelocityLossRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.G5BackFlashEmitter.SpriteEmitter24'

}
