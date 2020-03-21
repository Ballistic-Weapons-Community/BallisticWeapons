//=============================================================================
// M763FlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M763FlashEmitter extends BallisticEmitter;//DGVEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (!class'BallisticMod'.default.bMuzzleSmoke)	{
		Emitters[0].Disabled = true;
//		Emitters[3].Disabled = true;
	}
	if (WeaponAttachment(Owner) != None)
	{
		Emitters[2].ZTest = true;
		Emitters[3].disabled = true;
	}
}
/*
    Begin Object Class=SpriteEmitter Name=SpriteEmitter15
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
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.700000,Max=0.800000))
         Opacity=0.200000
         FadeOutStartTime=0.480000
         FadeInEndTime=0.360000
         MaxParticles=600
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=5.000000,Max=6.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.300000)
         SpawnOnTriggerRange=(Min=300.000000,Max=600.000000)
         SpawnOnTriggerPPS=300.000000
         StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'M763FlashEmitter.SpriteEmitter15'
*/

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter33
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
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.510000
         FadeOutStartTime=0.820000
         FadeInEndTime=0.260000
         MaxParticles=15
         StartLocationRange=(X=(Min=-20.000000))
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=4.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=8.000000)
         StartSizeRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.SmokeWisp-Alpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerRange=(Min=5.000000,Max=10.000000)
         SpawnOnTriggerPPS=4.000000
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=40.000000,Max=65.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.M763FlashEmitter.SpriteEmitter33'

     Begin Object Class=MeshEmitter Name=MeshEmitter9
         StaticMesh=StaticMesh'BallisticHardware2.M763.M763MuzzleFlash'
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
		 Opacity=0.35
         ColorScale(0)=(Color=(B=255,G=128,R=128))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=192,R=192))
         ColorScale(2)=(RelativeTime=0.300000,Color=(B=64,G=96,R=96,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=32,G=64,R=128))
         FadeOutStartTime=0.055000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.700000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.200000)
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.M763FlashEmitter.MeshEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter16
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=128,G=224,R=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=32,G=160,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.300000,Color=(B=64,G=64,R=96,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=64,R=96))
         FadeOutStartTime=0.095000
         Opacity=0.5
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationRange=(X=(Min=16.000000,Max=16.000000))
         StartSizeRange=(X=(Min=120.000000,Max=120.000000),Y=(Min=120.000000,Max=120.000000),Z=(Min=120.000000,Max=120.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.2500000,Max=0.250000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.M763FlashEmitter.SpriteEmitter16'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         MaxTrailTwistAngle=25
         PointLifeTime=2.000000
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=212,R=212,A=255))
         Opacity=0.600000
         FadeOutStartTime=0.800000
         MaxParticles=20
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=10.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerPPS=10.000000
     End Object
     Emitters(3)=TrailEmitter'BallisticProV55.M763FlashEmitter.TrailEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=192,G=224,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=128,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=64,G=128,R=255,A=255))
         FadeOutStartTime=0.033000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=30.000000,Max=40.000000),Y=(Min=30.000000,Max=40.000000),Z=(Min=30.000000,Max=40.000000))
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.200000,Max=0.200000)
         SpawnOnTriggerRange=(Min=16.000000,Max=20.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=100.000000,Max=2000.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.M763FlashEmitter.SpriteEmitter17'

}
