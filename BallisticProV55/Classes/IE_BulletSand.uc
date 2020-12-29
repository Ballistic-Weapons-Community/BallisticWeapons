//=============================================================================
// IE_BulletSand.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BulletSand extends DGVEmitter
	placeable;

simulated event PostBeginPlay()
{
	if ( PhysicsVolume.bWaterVolume )
	{
		Emitters[2].Disabled=true;
		Emitters[1].Acceleration.Z = 20.0;
		Emitters[1].VelocityLossRange.X.Min=2.000000;
		Emitters[1].VelocityLossRange.X.Max=2.000000;
		Emitters[1].VelocityLossRange.Y.Min=2.000000;
		Emitters[1].VelocityLossRange.Y.Max=2.000000;
		Emitters[1].VelocityLossRange.Z.Min=2.000000;
		Emitters[1].VelocityLossRange.Z.Max=2.000000;
	}
	super.PostBeginPlay();
}

defaultproperties
{
     DisableDGV(0)=1
     Begin Object Class=MeshEmitter Name=MeshEmitter6
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
         ColorScale(0)=(Color=(B=64,G=96,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=96,R=128,A=255))
         ColorMultiplierRange=(Y=(Min=0.750000,Max=0.750000),Z=(Min=0.500000,Max=0.500000))
         FadeOutFactor=(X=1.500000,Y=1.200000)
         FadeOutStartTime=0.432000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=0.370000,RelativeSize=1.800000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.500000,Max=0.500000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.200000,Max=1.200000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.IE_BulletSand.MeshEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter30
         UseCollisionPlanes=True
         UseMaxCollisions=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=64,G=96,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=111,R=128,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.400000,Max=0.400000))
         FadeOutStartTime=0.735000
         FadeInEndTime=0.135000
         MaxParticles=30
         DetailMode=DM_SuperHigh
         AlphaRef=64
         SpinsPerSecondRange=(X=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=5.000000,Max=8.000000),Y=(Min=5.000000,Max=8.000000),Z=(Min=5.000000,Max=8.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.FlamePartsAlpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=50.000000,Max=180.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_BulletSand.SpriteEmitter30'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter31
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-5.000000)
         ColorScale(0)=(Color=(B=96,G=140,R=192,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=96,G=140,R=192,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.800000))
         Opacity=0.760000
         FadeOutFactor=(X=1.500000,Y=1.200000)
         FadeOutStartTime=1.080000
         FadeInEndTime=0.600000
         MaxParticles=8
         StartLocationOffset=(X=10.000000)
         SpinsPerSecondRange=(X=(Max=0.200000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Max=20.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_BulletSand.SpriteEmitter31'

     AutoDestroy=True
}
