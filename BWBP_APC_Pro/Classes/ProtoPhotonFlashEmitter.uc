//=============================================================================
// ProtoPhotonFlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ProtoPhotonFlashEmitter extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter5
         StaticMesh=StaticMesh'BWBP_CC_Static.ProtoLMG.ProtoLMGMuzzleFlash'
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
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=192,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=160,G=64,R=64,A=255))
         FadeOutStartTime=0.130000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.200000)
         StartSizeRange=(X=(Min=1.500000,Max=1.500000),Y=(Min=1.300000,Max=1.300000),Z=(Min=1.300000,Max=1.300000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(0)=MeshEmitter'BWBP_APC_Pro.ProtoPhotonFlashEmitter.MeshEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=192,R=64,A=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=64,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.607143,Color=(B=255,G=192,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=192,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.900000),Z=(Min=0.900000))
         Opacity=0.670000
         FadeOutStartTime=0.044000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationOffset=(X=50.000000)
         StartLocationRange=(X=(Max=120.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
		 StartSizeRange=(X=(Min=30.000000,Max=60.000000),Y=(Min=30.000000,Max=60.000000),Z=(Min=30.000000,Max=60.000000))
		 Texture=Texture'BWBP_SKC_Tex.XM20.F2000-LensFlares2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=3.000000,Max=3.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=SpriteEmitter'BWBP_APC_Pro.ProtoPhotonFlashEmitter.SpriteEmitter26'
     
	 bNoDelete=False
}
