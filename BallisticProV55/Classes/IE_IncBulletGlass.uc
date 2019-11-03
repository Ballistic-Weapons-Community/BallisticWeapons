//=============================================================================
// IE_BulletGlass.
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_IncBulletGlass extends DGVEmitter
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

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-5.000000)
         ColorScale(0)=(Color=(B=192,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.220000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.350000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=254,R=255,A=255))
         ColorMultiplierRange=(X=(Min=5.500000,Max=0.600000),Z=(Min=0.400000,Max=0.400000))
         FadeOutStartTime=0.150000
         MaxParticles=5
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Min=0.450000,Max=0.550000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.200000)
         StartSizeRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(5)=SpriteEmitter'IE_IncBulletGlass.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=6.500000,Max=6.500000),Y=(Min=6.500000,Max=6.500000),Z=(Min=6.500000,Max=6.500000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(6)=SpriteEmitter'IE_IncBulletGlass.SpriteEmitter14'

     AutoDestroy=True
}
