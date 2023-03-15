//=============================================================================
// IE_BulletFrostHE. Used for the SX45 cryo amp shot
//
// by Sarge
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BulletFrostHE extends DGVEmitterOversize
	placeable;

simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_High)
	{
		Emitters[2].Disabled=true;
		Emitters[6].Disabled=true;
		Emitters[7].Disabled=true;
		Emitters[8].Disabled=true;
	}

	if ( PhysicsVolume.bWaterVolume )
	{
		Emitters[0].Disabled=true;
		Emitters[2].Disabled=true;
	}
	Super.PreBeginPlay();
}

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(1)=1
     DisableDGV(2)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter31
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=128,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=192,R=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.700000,Max=0.800000),Z=(Min=0.900000))
         FadeOutStartTime=1.000000
         FadeInEndTime=0.075000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartLocationOffset=(X=2.000000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=6.000000,Max=6.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.IE_BulletFrostHE.SpriteEmitter31'

     Begin Object Class=MeshEmitter Name=MeshEmitter7
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.VBlast'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.560000
         FadeOutStartTime=0.180000
         FadeInEndTime=0.010000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Y=(Min=-0.250000,Max=-0.250000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=MeshEmitter'BWBP_SKC_Pro.IE_BulletFrostHE.MeshEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter32
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.900000),Z=(Min=0.800000))
         Opacity=0.580000
         FadeOutStartTime=0.115000
         FadeInEndTime=0.035000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=5.000000)
         StartSizeRange=(X=(Min=35.000000,Max=45.000000),Y=(Min=35.000000,Max=45.000000),Z=(Min=35.000000,Max=45.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.IE_BulletFrostHE.SpriteEmitter32'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter33
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.275000,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.700000),Y=(Min=0.800000))
         FadeOutStartTime=0.063000
         MaxParticles=30
         DetailMode=DM_High
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=8.000000,Max=16.000000),Y=(Min=8.000000,Max=16.000000),Z=(Min=8.000000,Max=16.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
         StartVelocityRange=(X=(Min=50.000000,Max=500.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Max=200.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_SKC_Pro.IE_BulletFrostHE.SpriteEmitter33'

     Begin Object Class=MeshEmitter Name=MeshEmitter8
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Impact.ConcreteChip2'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-600.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.157143,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.492857,Color=(G=128,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.584000
         MaxParticles=4
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Max=4.000000),Y=(Max=4.000000),Z=(Max=4.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.050000,Max=0.300000),Y=(Min=0.050000,Max=0.300000),Z=(Min=0.050000,Max=0.300000))
         InitialParticlesPerSecond=5000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Max=150.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Max=200.000000))
     End Object
     Emitters(4)=MeshEmitter'BWBP_SKC_Pro.IE_BulletFrostHE.MeshEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter34
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000))
         Opacity=0.200000
         FadeOutStartTime=0.161000
         FadeInEndTime=0.031500
         MaxParticles=1
         DetailMode=DM_High
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
     End Object
     Emitters(5)=SpriteEmitter'BWBP_SKC_Pro.IE_BulletFrostHE.SpriteEmitter34'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter35
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
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(6)=SpriteEmitter'BWBP_SKC_Pro.IE_BulletFrostHE.SpriteEmitter35'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter36
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.275000,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=30,G=176,R=225,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.200000,Max=0.500000),Z=(Min=0.800000))
         FadeOutStartTime=0.063000
         MaxParticles=50
         DetailMode=DM_High
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=1.000000,Max=5.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.BFG.BFGTrail'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
         StartVelocityRange=(X=(Max=900.000000),Y=(Min=-750.000000,Max=750.000000),Z=(Min=-700.000000,Max=700.000000))
     End Object
     Emitters(7)=SpriteEmitter'BWBP_SKC_Pro.IE_BulletFrostHE.SpriteEmitter36'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter37
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.200000),Y=(Min=0.000000,Max=0.200000),Z=(Min=0.800000))
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100100,Max=0.100100)
     End Object
     Emitters(8)=SpriteEmitter'BWBP_SKC_Pro.IE_BulletFrostHE.SpriteEmitter37'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.700000,Max=0.900000))
         FadeOutStartTime=1.125000
         MaxParticles=50
         AlphaRef=150
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=3.000000,Max=5.000000),Z=(Min=3.000000,Max=5.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Regular
         Texture=Texture'BW_Core_WeaponTex.Particles.FlamePartsAlpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=20.000000,Max=150.000000))
     End Object
     Emitters(9)=SpriteEmitter'BWBP_SKC_Pro.IE_BulletFrostHE.SpriteEmitter4'

     AutoDestroy=True
}
