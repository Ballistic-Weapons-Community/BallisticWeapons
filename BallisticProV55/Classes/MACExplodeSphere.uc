//=============================================================================
// MACExplodeSphere.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MACExplodeSphere extends BallisticEmitter
	placeable;

simulated event PostBeginPlay()
{
	local float Size;

	Super.PostBeginPlay();

	if (Owner!=None && MACBeacon(Owner)!=None)
	{
		Size = MACBeacon(Owner).DamageRadius * (1 - 40.0 / MACBeacon(Owner).Damage);
		Emitters[0].StartSizeRange.X.Max = Size / 64.0;
		Emitters[0].StartSizeRange.X.Min = Size / 64.0;
		Emitters[0].StartSizeRange.Y.Max = Size / 64.0;
		Emitters[0].StartSizeRange.Y.Min = Size / 64.0;
		Emitters[0].StartSizeRange.Z.Max = Size / 64.0;
		Emitters[0].StartSizeRange.Z.Min = Size / 64.0;
		Emitters[1].StartSizeRange.X.Max = Size;
		Emitters[1].StartSizeRange.X.Min = Size;
	}
}

defaultproperties
{
     EmitterZTestSwitches(1)=ZM_OffWhenVisible
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP4-Hardware.Artillery.ExplodeSphere'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=0.028571,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.057143,Color=(G=128,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.089286,Color=(R=255,A=255))
         ColorScale(4)=(RelativeTime=0.117857,Color=(G=128,R=255,A=255))
         ColorScale(5)=(RelativeTime=0.150000,Color=(R=255,A=255))
         ColorScale(6)=(RelativeTime=0.178571,Color=(G=128,R=255,A=255))
         ColorScale(7)=(RelativeTime=0.250000,Color=(R=255,A=255))
         ColorScale(8)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=5.280000
         MaxParticles=1
         SizeScale(1)=(RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=8.000000,Max=8.000000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.MACExplodeSphere.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.164286,Color=(R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=1.760000
         MaxParticles=1
         StartSizeRange=(X=(Min=64.000000,Max=64.000000),Y=(Min=64.000000,Max=64.000000),Z=(Min=64.000000,Max=64.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.MACExplodeSphere.SpriteEmitter2'

     AutoDestroy=True
}
