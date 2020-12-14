//=============================================================================
// A49FlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A49FlashEmitter extends DGVEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[2].ZTest = true;
}

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(2)=1
     bAutoInit=False
     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.A73.A73MuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=128))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(B=64,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         FadeOutStartTime=0.126000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.600000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.400000)
         StartSizeRange=(X=(Min=4.000000,Max=4.000000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(0)=MeshEmitter'BWBPRecolorsPro.A49FlashEmitter.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         Acceleration=(Z=-600.000000)
         DampingFactorRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=64,R=64))
         FadeOutStartTime=1.000000
         MaxParticles=100
         DetailMode=DM_High
         StartLocationRange=(Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         StartSizeRange=(X=(Min=12.000000,Max=20.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerRange=(Min=2.000000,Max=5.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Min=800.000000,Max=1600.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.A49FlashEmitter.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.089286,Color=(B=255,G=192,R=192))
         ColorScale(2)=(RelativeTime=0.200000,Color=(B=255,G=128,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255))
         FadeOutStartTime=0.066000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationRange=(X=(Min=160.000000,Max=160.000000))
         StartSizeRange=(X=(Min=140.000000,Max=180.000000),Y=(Min=140.000000,Max=180.000000),Z=(Min=140.000000,Max=180.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(2)=SpriteEmitter'BWBPRecolorsPro.A49FlashEmitter.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=2.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         SizeScale(0)=(RelativeTime=0.310000,RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=5.000000,Max=15.000000),Y=(Min=5.000000,Max=15.000000),Z=(Min=5.000000,Max=15.000000))
         DrawStyle=PTDS_Modulated
         Texture=Texture'BWBP_SKC_Tex.A6.Ripple-A49'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.201000,Max=0.201000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(3)=SpriteEmitter'BWBPRecolorsPro.A49FlashEmitter.SpriteEmitter10'

}
