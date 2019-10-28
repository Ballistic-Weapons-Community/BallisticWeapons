//=============================================================================
// Mk781FlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MK781FlashEmitter extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (!class'BallisticMod'.default.bMuzzleSmoke)	{
		Emitters[3].Disabled = true;
	}
	if (WeaponAttachment(Owner) != None)
	{
		Emitters[2].ZTest = true;
		Emitters[3].disabled = true;
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter37
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
         Opacity=0.560000
         FadeOutStartTime=0.540000
         FadeInEndTime=0.240000
         MaxParticles=35
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.SmokeWisp-Alpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerRange=(Min=8.000000,Max=10.000000)
         SpawnOnTriggerPPS=5.000000
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=20.000000,Max=35.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.MK781FlashEmitter.SpriteEmitter37'

     Begin Object Class=MeshEmitter Name=MeshEmitter10
         StaticMesh=StaticMesh'BallisticHardware2.MRT6.MRT6MuzzleFlash'
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
         ColorScale(0)=(Color=(B=255,G=128,R=128))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=255,G=192,R=192))
         ColorScale(2)=(RelativeTime=0.300000,Color=(B=96,G=96,R=96,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=32,G=64,R=96))
         FadeOutStartTime=0.072000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.700000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.200000)
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=MeshEmitter'BWBPRecolorsPro.MK781FlashEmitter.MeshEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=128,G=224,R=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.300000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=64,R=128))
         FadeOutStartTime=0.072000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationRange=(X=(Min=16.000000,Max=16.000000))
         StartSizeRange=(X=(Min=45.000000,Max=45.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(2)=SpriteEmitter'BWBPRecolorsPro.MK781FlashEmitter.SpriteEmitter18'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         MaxTrailTwistAngle=25
         PointLifeTime=2.000000
         FadeOut=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         Opacity=0.600000
         FadeOutStartTime=0.200000
         MaxParticles=20
         StartSizeRange=(X=(Min=4.000000,Max=5.000000),Y=(Min=4.000000,Max=5.000000),Z=(Min=4.000000,Max=5.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerPPS=10.000000
     End Object
     Emitters(3)=TrailEmitter'BWBPRecolorsPro.MK781FlashEmitter.TrailEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter20
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=192,G=224,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=192,G=192,R=192,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         FadeOutStartTime=0.017500
         FadeInEndTime=0.010000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=15.000000,Max=20.000000),Z=(Min=15.000000,Max=20.000000))
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         SpawnOnTriggerRange=(Min=16.000000,Max=20.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=200.000000,Max=2000.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(4)=SpriteEmitter'BWBPRecolorsPro.MK781FlashEmitter.SpriteEmitter20'

}
