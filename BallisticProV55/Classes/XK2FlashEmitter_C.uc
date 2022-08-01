//=============================================================================
// XK2FlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XK2FlashEmitter_C extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
//	if (WeaponAttachment(Owner) != None)
	if (Weapon(Owner) == None)
		Emitters[1].ZTest = true;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter4
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.R78.RifleMuzzleFlash'
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
     Emitters(0)=MeshEmitter'BallisticProV55.XK2FlashEmitter_C.MeshEmitter4'

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
         ColorScale(2)=(RelativeTime=0.200000,Color=(B=64,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.020000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=20.000000)
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=80.000000,Max=80.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.XK2FlashEmitter_C.SpriteEmitter5'

     bNoDelete=False
}
