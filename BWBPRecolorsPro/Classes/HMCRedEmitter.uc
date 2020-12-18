//=============================================================================
// HMCRedEmitter
//
// Special muzzleflash for red team HMCs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HMCRedEmitter extends BallisticEmitter;


simulated event PostBeginPlay()
{
	local int i;
	
	Super.PostBeginPlay();
	
	if (WeaponAttachment(Owner) != None)
		for(i=0;i<Emitters.Length;i++) Emitters[i].ZTest = true;
}

defaultproperties
{
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
         Opacity=0.710000
         FadeOutStartTime=1.020000
         FadeInEndTime=0.560000
         MaxParticles=40
         StartLocationRange=(X=(Min=-30.000000))
         SpinsPerSecondRange=(X=(Max=0.150000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=0.900000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.400000)
         StartSizeRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.SmokeWisp-Alpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerRange=(Min=4.000000,Max=6.000000)
         SpawnOnTriggerPPS=20.000000
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=50.000000,Max=65.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.HMCRedEmitter.SpriteEmitter26'

     Begin Object Class=MeshEmitter Name=MeshEmitter4
         StaticMesh=StaticMesh'BallisticHardware2.R78.RifleMuzzleFlash'
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
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(B=64,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         Opacity=0.650000
         FadeOutStartTime=0.037500
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.200000)
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(1)=MeshEmitter'BWBPRecolorsPro.HMCRedEmitter.MeshEmitter4'

     Begin Object Class=MeshEmitter Name=MeshEmitter3
         StaticMesh=StaticMesh'BallisticHardware2.M925.M925MuzzleFlash'
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
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=200,G=192,R=192,A=255))
         ColorScale(2)=(RelativeTime=0.178571,Color=(B=112,G=96,R=96,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=160,G=64,R=64,A=255))
         Opacity=0.850000
         FadeOutStartTime=0.060000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.160000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.700000)
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(2)=MeshEmitter'BWBPRecolorsPro.HMCRedEmitter.MeshEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=192,G=224,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=64,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.178571,Color=(B=32,G=64,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=16,G=32,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.700000
         FadeOutStartTime=0.108000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=40.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(3)=SpriteEmitter'BWBPRecolorsPro.HMCRedEmitter.SpriteEmitter5'

}
