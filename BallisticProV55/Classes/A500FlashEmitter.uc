//=============================================================================
// A500FlashEmitter.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500FlashEmitter extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[1].ZTest = true;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         TriggerDisabled=False
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(G=255,R=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,R=96))
         FadeOutStartTime=0.450000
         FadeInEndTime=0.050000
         CoordinateSystem=PTCS_Relative
         MaxParticles=25
         StartSpinRange=(X=(Min=-16384.000000,Max=-16384.000000))
         StartSizeRange=(X=(Min=25.000000,Max=30.000000),Y=(Min=35.000000),Z=(Min=50.000000,Max=50.000000))
         Texture=Texture'BW_Core_WeaponTex.Reptile.AcidDrops01'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=550.000000
         StartVelocityRange=(X=(Min=150.000000,Max=1500.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.A500FlashEmitter.SpriteEmitter10'

     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Reptile.Reptile_MuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(G=255,R=128,A=255))
         ColorScale(1)=(RelativeTime=0.250000,Color=(G=255,R=96,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(Z=(Min=-0.500000,Max=0.500000))
         StartSpinRange=(Z=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.A500FlashEmitter.MeshEmitter2'

}
