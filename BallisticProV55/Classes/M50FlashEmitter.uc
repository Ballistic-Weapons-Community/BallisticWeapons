//=============================================================================
// M50FlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M50FlashEmitter extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[1].ZTest = true;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.M50.M50MuzzleFlash'
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
         Acceleration=(X=-80.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(B=64,G=64,R=64))
         ColorScale(3)=(RelativeTime=1.000000)
         FadeOutStartTime=0.048000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=2.000000)
         SizeScale(0)=(RelativeSize=0.600000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.5,Max=0.5),Y=(Min=0.5,Max=0.5),Z=(Min=0.5,Max=0.5))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.M50FlashEmitter.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=192,G=212,R=255))
         ColorScale(1)=(RelativeTime=0.128571,Color=(B=64,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.275000,Color=(B=32,G=96,R=192,A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.730000
         FadeOutStartTime=0.039000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=14.000000)
         StartSizeRange=(X=(Min=100.000000,Max=100.000000),Y=(Min=100.000000,Max=100.000000),Z=(Min=100.000000,Max=100.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.M50FlashEmitter.SpriteEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.FBlast'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         Opacity=0.440000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=10.000000)
         SizeScale(0)=(RelativeSize=0.700000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=0.250000,Max=0.250000),Z=(Min=0.250000,Max=0.250000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(2)=MeshEmitter'BallisticProV55.M50FlashEmitter.MeshEmitter1'

}
