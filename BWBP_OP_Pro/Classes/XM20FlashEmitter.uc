//=============================================================================
// MARSFlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20FlashEmitter extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (Weapon(Owner) == None)
		Emitters[1].ZTest = true;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP_SKC_Static.LaserCarbine.PlasmaMuzzleFlash'
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
		 SpinParticles=True
		 StartSpinRange=(Z=(Min=0.065,Max=0.0675))
         Acceleration=(X=-80.000000)
         ColorScale(0)=(Color=(B=128,G=128,R=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=128,G=128,R=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(B=0,G=0,R=64))
         ColorScale(3)=(RelativeTime=1.000000)
         FadeOutStartTime=0.048000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
		 RotationOffset=(Roll=1000)
         StartLocationOffset=(X=2.000000)
         StartSizeRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.600000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(0)=MeshEmitter'BWBP_OP_Pro.XM20FlashEmitter.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=212,R=192))
         ColorScale(1)=(RelativeTime=0.128571,Color=(B=64,G=96,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.275000,Color=(B=32,G=48,R=192,A=255))
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
         LifetimeRange=(Min=0.600000,Max=0.600000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=SpriteEmitter'BWBP_OP_Pro.XM20FlashEmitter.SpriteEmitter0'

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
		 SpinParticles=True
		 StartSpinRange=(Z=(Min=0.065,Max=0.0675))
         ColorScale(0)=(Color=(B=128,G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=128,G=128,R=255,A=255))
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
     Emitters(2)=MeshEmitter'BWBP_OP_Pro.XM20FlashEmitter.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=128,G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.260714,Color=(R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.300000,Max=0.300000))
         FadeOutStartTime=0.056000
         FadeInEndTime=0.004000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=10.000000)
         StartSizeRange=(X=(Min=240.000000,Max=240.000000),Y=(Min=240.000000,Max=240.000000),Z=(Min=240.000000,Max=240.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(3)=SpriteEmitter'BWBP_OP_Pro.XM20FlashEmitter.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=96,G=96,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.332143,Color=(R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.300000,Max=0.300000))
         Opacity=0.460000
         FadeOutStartTime=0.147000
         FadeInEndTime=0.045000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationOffset=(X=140.000000)
         StartSizeRange=(X=(Min=90.000000,Max=120.000000),Y=(Min=360.000000,Max=480.000000),Z=(Min=360.000000,Max=480.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.WaterSpray1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
         SpawnOnTriggerRange=(Min=3.000000,Max=3.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Min=10.000000,Max=10.000000))
     End Object
     Emitters(4)=SpriteEmitter'BWBP_OP_Pro.XM20FlashEmitter.SpriteEmitter10'

}
