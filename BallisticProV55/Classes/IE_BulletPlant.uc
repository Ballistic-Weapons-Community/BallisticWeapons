//=============================================================================
// IE_BulletPlant.
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BulletPlant extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=25.000000)
         ColorScale(0)=(Color=(B=64,G=255,R=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=192,R=128))
         FadeOutStartTime=0.500000
         SpinsPerSecondRange=(X=(Max=0.250000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=25.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.Smoke1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-50.000000,Max=40.000000),Y=(Min=-40.000000,Max=40.000000),Z=(Min=-25.000000,Max=25.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_BulletPlant.SpriteEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BallisticHardware2.Impact.ConcreteChip1'
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(G=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255))
         FadeOutStartTime=0.500000
         MaxParticles=7
         SpinsPerSecondRange=(X=(Max=3.000000),Y=(Max=3.000000))
         StartSizeRange=(X=(Min=0.125000,Max=0.375000),Y=(Min=0.125000,Max=0.375000),Z=(Min=0.125000,Max=0.375000))
         InitialParticlesPerSecond=10000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=40.000000,Max=70.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-25.000000,Max=50.000000))
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.IE_BulletPlant.MeshEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BallisticHardware2.Impact.ConcreteChip1'
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-80.000000)
         ColorScale(0)=(Color=(B=64,G=255,R=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=255,R=128))
         ColorMultiplierRange=(X=(Min=0.000000,Max=2.000000),Y=(Min=0.500000),Z=(Min=0.000000))
         FadeOutStartTime=0.500000
         MaxParticles=15
         SpinsPerSecondRange=(X=(Max=3.000000),Y=(Max=3.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=0.125000,Max=0.375000),Y=(Min=0.125000,Max=0.375000),Z=(Min=0.125000,Max=0.375000))
         InitialParticlesPerSecond=250.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-120.000000,Max=-50.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=10.000000))
     End Object
     Emitters(2)=MeshEmitter'BallisticProV55.IE_BulletPlant.MeshEmitter1'

     AutoDestroy=True
}
