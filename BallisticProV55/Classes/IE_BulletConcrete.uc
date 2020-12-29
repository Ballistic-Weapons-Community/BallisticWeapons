//=============================================================================
// IE_BulletConcrete.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BulletConcrete extends DGVEmitter
	placeable;

simulated event PostBeginPlay()
{
	if ( PhysicsVolume.bWaterVolume )
	{
		Emitters[0].Disabled=true;
		Emitters[1].Disabled=true;
		Emitters[2].Acceleration.Z = 50.0;
		Emitters[2].VelocityLossRange.X.Min=1.000000;
		Emitters[2].VelocityLossRange.X.Max=1.000000;
		Emitters[2].VelocityLossRange.Y.Min=1.000000;
		Emitters[2].VelocityLossRange.Y.Max=1.000000;
	}
	if (vector(Rotation).Z > 0.5)
	{
		Emitters[1].Disabled = true;
		Emitters[3].Disabled = true;
	}
	super.PostBeginPlay();
}

defaultproperties
{
     DisableDGV(4)=1
     bModifyLossRange=False
     Begin Object Class=SpriteEmitter Name=SpriteEmitter27
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=64,G=64,R=64,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.760000
         FadeOutStartTime=0.460000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.340000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=40.000000),Y=(Min=20.000000,Max=40.000000),Z=(Min=20.000000,Max=40.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=60.000000,Max=100.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-5.000000,Max=20.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_BulletConcrete.SpriteEmitter27'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter28
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=64,G=64,R=64))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.540000
         FadeOutStartTime=0.520000
         MaxParticles=25
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=7.000000,Max=8.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.200000)
         StartVelocityRange=(X=(Min=2.000000,Max=5.000000),Y=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_BulletConcrete.SpriteEmitter28'

     Begin Object Class=MeshEmitter Name=MeshEmitter12
         StaticMesh=StaticMesh'BallisticHardware2.Impact.ConcreteChip2'
         UseMeshBlendMode=False
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(B=255,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=192,R=192,A=255))
         FadeOutStartTime=0.312000
         MaxParticles=4
         SpinsPerSecondRange=(X=(Min=0.500000,Max=3.000000),Y=(Min=0.500000,Max=3.000000),Z=(Min=0.500000,Max=3.000000))
         StartSizeRange=(X=(Min=0.100000,Max=0.200000),Y=(Min=0.100000,Max=0.200000),Z=(Min=0.100000,Max=0.200000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=50.000000,Max=250.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-70.000000,Max=150.000000))
     End Object
     Emitters(2)=MeshEmitter'BallisticProV55.IE_BulletConcrete.MeshEmitter12'

     Begin Object Class=MeshEmitter Name=MeshEmitter13
         StaticMesh=StaticMesh'BallisticHardware2.Impact.ConcreteChip3'
         UseMeshBlendMode=False
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=192,R=192,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.710000
         FadeInEndTime=0.180000
         MaxParticles=3
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-1.000000)
         StartLocationRange=(Y=(Min=-6.000000,Max=6.000000),Z=(Min=-6.000000,Max=6.000000))
         SpinsPerSecondRange=(X=(Max=0.300000),Y=(Max=0.300000),Z=(Max=0.500000))
         StartSpinRange=(Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.000000,Max=0.100000),Y=(Min=0.400000,Max=0.800000),Z=(Min=0.400000,Max=0.800000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=2.000000,Max=20.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Max=50.000000))
     End Object
     Emitters(3)=MeshEmitter'BallisticProV55.IE_BulletConcrete.MeshEmitter13'

     Begin Object Class=MeshEmitter Name=MeshEmitter14
         StaticMesh=StaticMesh'BallisticHardware2.Effects.VolumetricA3'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.085000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=1.500000,Max=1.500000),Z=(Min=1.500000,Max=1.500000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(4)=MeshEmitter'BallisticProV55.IE_BulletConcrete.MeshEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.314286,Color=(B=64,G=224,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=16,G=64,R=255,A=255))
         FadeOutStartTime=0.060000
         MaxParticles=3
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.700000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=5.000000,Max=12.000000),Y=(Min=5.000000,Max=12.000000),Z=(Min=5.000000,Max=12.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=50.000000,Max=300.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_BulletConcrete.SpriteEmitter3'

     AutoDestroy=True
}
