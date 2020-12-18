//=============================================================================
// XMV850FlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XMV850FlashEmitter extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[2].ZTest = true;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter39
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
         Opacity=0.360000
         FadeOutStartTime=0.520000
         FadeInEndTime=0.220000
         MaxParticles=90
         StartLocationRange=(X=(Min=-60.000000,Max=20.000000),Y=(Min=-12.000000,Max=12.000000))
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.500000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=3.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.SmokeWisp-Alpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerPPS=25.000000
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=30.000000,Max=60.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.XMV850FlashEmitter.SpriteEmitter39'

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
         Opacity=0.850000
         FadeOutStartTime=0.037500
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.200000)
         StartSizeRange=(Y=(Min=1.500000,Max=1.500000),Z=(Min=1.500000,Max=1.500000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.XMV850FlashEmitter.MeshEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=192,G=224,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=64,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(B=64,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.020000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=20.000000)
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=80.000000,Max=80.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.XMV850FlashEmitter.SpriteEmitter5'

}
