//=============================================================================
// D49FlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class D49FlashEmitter extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[1].ZTest = true;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter7
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.R78.RifleMuzzleFlash'
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
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.400000,Color=(B=64,G=64,R=66,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=64,R=128))
         FadeOutStartTime=0.048000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         DrawStyle=PTDS_Brighten
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.D49FlashEmitter.MeshEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=192,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.300000,Color=(A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=64,R=128))
         Opacity=0.890000
         FadeOutStartTime=0.054000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationRange=(X=(Min=100.000000,Max=100.000000))
         StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.D49FlashEmitter.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
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
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=64,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255,A=255))
         FadeOutStartTime=0.015000
         FadeInEndTime=0.015000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartLocationOffset=(X=5.000000,Z=6.000000)
         StartSpinRange=(X=(Min=0.270000,Max=0.270000))
         StartSizeRange=(X=(Min=40.000000,Max=60.000000),Y=(Min=40.000000,Max=60.000000),Z=(Min=40.000000,Max=60.000000))
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=15.000000,Max=20.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=300.000000,Max=3800.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-300.000000,Max=300.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.D49FlashEmitter.SpriteEmitter21'

}
