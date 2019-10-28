//=============================================================================
// IE_BulletWood.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BulletWood extends DGVEmitter
	placeable;

simulated event PreBeginPlay()
{
//	if (Level.DetailMode < DM_SuperHigh)
//		bHidden=true;
	if (Level.DetailMode < DM_High)
		Emitters[1].Disabled=true;
	if ( PhysicsVolume.bWaterVolume )
	{
		Emitters[0].Disabled=true;
		Emitters[1].Acceleration.Z = 50.0;
		Emitters[1].VelocityLossRange.X.Min=1.000000;
		Emitters[1].VelocityLossRange.X.Max=1.000000;
		Emitters[1].VelocityLossRange.Y.Min=1.000000;
		Emitters[1].VelocityLossRange.Y.Max=1.000000;
	}
	Super.PreBeginPlay();
}

defaultproperties
{
     DisableDGV(2)=1
     DisableDGV(3)=1
     bModifyLossRange=False
     Begin Object Class=SpriteEmitter Name=SpriteEmitter42
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-30.000000)
         ColorScale(0)=(Color=(B=32,G=128,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.650000,Max=0.650000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.760000
         FadeOutStartTime=0.390000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=25.000000,Max=30.000000),Y=(Min=25.000000,Max=30.000000),Z=(Min=25.000000,Max=30.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=30.000000,Max=60.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_BulletWood.SpriteEmitter42'

     Begin Object Class=MeshEmitter Name=MeshEmitter19
         StaticMesh=StaticMesh'BallisticHardware2.Impact.WoodChipA1'
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
         FadeOutStartTime=0.427000
         SpinsPerSecondRange=(X=(Max=2.000000),Y=(Max=3.000000),Z=(Max=3.000000))
         StartSizeRange=(X=(Min=0.040000,Max=0.100000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=0.700000)
         StartVelocityRange=(X=(Min=20.000000,Max=200.000000),Y=(Min=-60.000000,Max=60.000000),Z=(Min=-40.000000,Max=120.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.IE_BulletWood.MeshEmitter19'

     Begin Object Class=MeshEmitter Name=MeshEmitter20
         StaticMesh=StaticMesh'BallisticHardware2.Impact.WoodImpactHoleA1'
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=2.680000
         FadeInEndTime=0.240000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartSpinRange=(Z=(Min=-0.080000,Max=0.080000))
         StartSizeRange=(X=(Min=0.100000,Max=0.150000),Y=(Min=0.080000,Max=0.100000),Z=(Min=0.080000,Max=0.100000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000)
     End Object
     Emitters(2)=MeshEmitter'BallisticProV55.IE_BulletWood.MeshEmitter20'

     Begin Object Class=MeshEmitter Name=MeshEmitter21
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
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.075000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.180000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.500000,Max=0.600000),Y=(Min=0.900000),Z=(Min=0.900000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(3)=MeshEmitter'BallisticProV55.IE_BulletWood.MeshEmitter21'

     AutoDestroy=True
}
