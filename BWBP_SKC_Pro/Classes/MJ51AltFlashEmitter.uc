//=============================================================================
// MJ51AltFlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MJ51AltFlashEmitter extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[2].ZTest = true;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter5
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.M900.M900MuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=64,R=128))
         FadeOutStartTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(1)=(RelativeTime=0.100000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         DrawStyle=PTDS_Brighten
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(0)=MeshEmitter'BWBP_SKC_Pro.MJ51AltFlashEmitter.MeshEmitter5'

     Begin Object Class=SparkEmitter Name=SparkEmitter4
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBeforeVisibleRange=(Min=5.000000,Max=5.000000)
         TimeBetweenSegmentsRange=(Min=0.050000,Max=0.100000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255))
         FadeOutStartTime=0.300000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=0.700000)
         SpawnOnTriggerRange=(Min=20.000000,Max=20.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Min=500.000000,Max=1000.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(1)=SparkEmitter'BWBP_SKC_Pro.MJ51AltFlashEmitter.SparkEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=128,G=192,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=64,R=128))
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=20.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.MJ51AltFlashEmitter.SpriteEmitter7'

}
