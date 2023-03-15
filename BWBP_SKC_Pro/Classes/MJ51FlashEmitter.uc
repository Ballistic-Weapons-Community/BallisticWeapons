//=============================================================================
// MJ51FlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MJ51FlashEmitter extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[1].ZTest = true;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP_SKC_StaticExp.MJ51.MJ51MuzzleFlash'
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
         StartLocationOffset=(X=15.000000)
         SizeScale(0)=(RelativeSize=0.600000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(0)=MeshEmitter'BWBP_SKC_Pro.MJ51FlashEmitter.MeshEmitter0'

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
         StartSizeRange=(X=(Min=140.000000,Max=140.000000),Y=(Min=140.000000,Max=140.000000),Z=(Min=140.000000,Max=140.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.MJ51FlashEmitter.SpriteEmitter0'

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
         StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(2)=MeshEmitter'BWBP_SKC_Pro.MJ51FlashEmitter.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=180,R=160,A=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=91,G=91,R=91,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.510000
         FadeOutStartTime=1.020000
         FadeInEndTime=0.560000
         MaxParticles=2
         StartLocationRange=(X=(Min=-30.000000))
         SpinsPerSecondRange=(X=(Max=0.150000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=3.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.SmokeWisp-Alpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerRange=(Min=4.000000,Max=6.000000)
         SpawnOnTriggerPPS=20.000000
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=50.000000,Max=65.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_SKC_Pro.MJ51FlashEmitter.SpriteEmitter26'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=192,G=212,R=255))
         ColorScale(1)=(RelativeTime=0.125000,Color=(B=64,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.275000,Color=(B=32,G=96,R=192,A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.310000
         FadeOutStartTime=0.039000
         MaxParticles=1
         StartLocationOffset=(X=14.000000)
         SpinCCWorCW=(X=0.200000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.NewSmoke1g'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.900000,Max=0.900000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=10.000000))
     End Object
     Emitters(4)=SpriteEmitter'BWBP_SKC_Pro.MJ51FlashEmitter.SpriteEmitter5'

}
