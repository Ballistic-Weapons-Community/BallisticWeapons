//=============================================================================
// IE_BulletWood.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BulletExpWood extends DGVEmitter
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
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=30.000000,Max=60.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.IE_BulletExpWood.SpriteEmitter42'

     Begin Object Class=MeshEmitter Name=MeshEmitter19
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Impact.WoodChipA1'
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
         DetailMode=DM_High
         SpinsPerSecondRange=(X=(Max=2.000000),Y=(Max=3.000000),Z=(Max=3.000000))
         StartSizeRange=(X=(Min=0.040000,Max=0.100000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=0.700000)
         StartVelocityRange=(X=(Min=20.000000,Max=200.000000),Y=(Min=-60.000000,Max=60.000000),Z=(Min=-40.000000,Max=120.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=MeshEmitter'BWBP_SKC_Pro.IE_BulletExpWood.MeshEmitter19'

     Begin Object Class=MeshEmitter Name=MeshEmitter20
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Impact.WoodImpactHoleA1'
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
     Emitters(2)=MeshEmitter'BWBP_SKC_Pro.IE_BulletExpWood.MeshEmitter20'

     Begin Object Class=MeshEmitter Name=MeshEmitter21
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.VolumetricA3'
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
     Emitters(3)=MeshEmitter'BWBP_SKC_Pro.IE_BulletExpWood.MeshEmitter21'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.200000
         FadeOutStartTime=0.161000
         FadeInEndTime=0.031500
         MaxParticles=1
         DetailMode=DM_High
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=35.000000,Max=35.000000),Y=(Min=35.000000,Max=35.000000),Z=(Min=35.000000,Max=35.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
     End Object
     Emitters(4)=SpriteEmitter'BWBP_SKC_Pro.IE_BulletExpWood.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000,Max=0.800000))
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(5)=SpriteEmitter'BWBP_SKC_Pro.IE_BulletExpWood.SpriteEmitter14'

     AutoDestroy=True
}
