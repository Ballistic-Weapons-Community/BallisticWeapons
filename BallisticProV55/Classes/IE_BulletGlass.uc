//=============================================================================
// IE_BulletGlass.
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BulletGlass extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         Disabled=True
         Backup_Disabled=True
         UniformSize=True
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_BulletGlass.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         Disabled=True
         Backup_Disabled=True
         UniformSize=True
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_BulletGlass.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         Disabled=True
         Backup_Disabled=True
         UniformSize=True
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_BulletGlass.SpriteEmitter2'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BallisticHardware2.Impact.Shard1'
         UseMeshBlendMode=False
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.500000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Max=3.000000),Y=(Max=4.000000),Z=(Max=4.000000))
         StartSizeRange=(X=(Min=0.125000,Max=0.375000),Y=(Min=0.125000,Max=0.375000),Z=(Min=0.125000,Max=0.375000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_Brighten
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=50.000000,Max=100.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-25.000000,Max=50.000000))
     End Object
     Emitters(3)=MeshEmitter'BallisticProV55.IE_BulletGlass.MeshEmitter0'

     Begin Object Class=SparkEmitter Name=SparkEmitter0
         Disabled=True
         Backup_Disabled=True
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(4)=SparkEmitter'BallisticProV55.IE_BulletGlass.SparkEmitter0'

     AutoDestroy=True
}
