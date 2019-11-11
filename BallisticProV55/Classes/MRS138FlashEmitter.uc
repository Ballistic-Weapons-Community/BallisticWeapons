//=============================================================================
// MRS138FlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MRS138FlashEmitter extends BallisticEmitter;//DGVEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (!class'BallisticMod'.default.bMuzzleSmoke)	{
		Emitters[0].Disabled = true;
	}
	if (WeaponAttachment(Owner) != None)
	{
		Emitters[2].ZTest = true;
		Emitters[3].disabled = true;
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=255,G=128,R=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.700000),Z=(Min=0.600000,Max=0.600000))
         Opacity=0.200000
         FadeOutStartTime=0.480000
         FadeInEndTime=0.360000
         MaxParticles=600
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.300000)
         SpawnOnTriggerRange=(Min=300.000000,Max=600.000000)
         SpawnOnTriggerPPS=300.000000
         StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.MRS138FlashEmitter.SpriteEmitter1'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BallisticHardware2.M806.PistolMuzzleFlash'
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
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=255,G=192,R=192))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=32,G=64,R=128))
         FadeOutStartTime=0.080000
         CoordinateSystem=PTCS_Relative
		 Opacity=0.5
         MaxParticles=1
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.350000,Max=0.350000),Z=(Min=0.350000,Max=0.350000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.MRS138FlashEmitter.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.142857,Color=(B=64,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=64,G=128,R=192))
         Opacity=0.50000
         FadeOutStartTime=0.200000
         FadeInEndTime=0.032000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=12.000000)
         StartLocationRange=(X=(Min=16.000000,Max=16.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.MRS138FlashEmitter.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.207143,Color=(B=128,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=32,G=96,R=255,A=255))
		 Opacity=0.5
         FadeOutStartTime=0.150500
         FadeInEndTime=0.021000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartLocationOffset=(X=30.000000)
         StartSizeRange=(X=(Min=2.500000,Max=5.000000),Y=(Min=2.500000,Max=5.000000),Z=(Min=2.500000,Max=5.000000))
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         LifetimeRange=(Min=0.350000,Max=0.350000)
         SpawnOnTriggerRange=(Min=20.000000,Max=14.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=800.000000,Max=4000.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=-400.000000,Max=400.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.MRS138FlashEmitter.SpriteEmitter0'

}
