//=============================================================================
// IE_M75General.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_M75General extends DGVEmitter
	placeable;

simulated event PreBeginPlay()
{
	if ( !FastTrace(Location + Vector(Rotation)*8 ,Level.GetLocalPlayerController().ViewTarget.Location) )
	{
		SetLocation(Location + Vector(Rotation)*8);
		Emitters[1].ZTest = true;
		Emitters[2].ZTest = true;
		Emitters[4].ZTest = true;
	}
	Super.PreBeginPlay();
}

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(1)=1
     DisableDGV(2)=1
     DisableDGV(3)=1
     DisableDGV(4)=1
     DisableDGV(6)=1
     DisableDGV(8)=1
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.RailWaveCircle'
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
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.317857,Color=(B=200,G=200,R=200,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         FadeOutStartTime=0.088000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=3.000000)
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.680000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.IE_M75General.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=192,R=128,A=255))
         FadeOutStartTime=0.042000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=80.000000,Max=80.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_M75General.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ZTest=False
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=200,R=180,A=255))
         ColorScale(1)=(RelativeTime=0.425000,Color=(B=255,G=200,R=180,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=192,R=128,A=255))
         ColorMultiplierRange=(X=(Min=0.000000),Y=(Min=0.800000))
         FadeOutStartTime=0.110000
         FadeInEndTime=0.110000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartSizeRange=(X=(Min=25.000000,Max=30.000000),Y=(Min=25.000000,Max=30.000000),Z=(Min=25.000000,Max=30.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_M75General.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.235714,Color=(B=255,G=192,R=160,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=128,R=64,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.700000),Y=(Min=0.600000))
         FadeOutStartTime=0.360000
         FadeInEndTime=0.140000
         CoordinateSystem=PTCS_Relative
         MaxParticles=8
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=10.000000)
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Max=150.000000),Y=(Min=-40.000000,Max=40.000000),Z=(Max=20.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_M75General.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255,A=255))
         FadeOutStartTime=0.095000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Max=120.000000),Y=(Max=120.000000),Z=(Max=120.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.IE_M75General.SpriteEmitter5'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Impact.ConcreteChip2'
         UseMeshBlendMode=False
         UseParticleColor=True
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-600.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=192,A=255))
         ColorScale(1)=(RelativeTime=0.164286,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.300000,Color=(G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=64,R=255,A=255))
         FadeOutStartTime=0.750000
         MaxParticles=8
         StartLocationOffset=(X=5.000000)
         SpinsPerSecondRange=(X=(Max=4.000000),Y=(Max=4.000000),Z=(Max=4.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.200000,Max=0.400000),Y=(Min=0.200000,Max=0.400000),Z=(Min=0.200000,Max=0.400000))
         InitialParticlesPerSecond=5000.000000
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=5000.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=0.500000,Max=600.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-100.000000,Max=300.000000))
     End Object
     Emitters(5)=MeshEmitter'BallisticProV55.IE_M75General.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.178571,Color=(B=255,G=192,A=192))
         ColorScale(2)=(RelativeTime=0.382143,Color=(B=255,G=128,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,A=192))
         FadeOutStartTime=0.130000
         FadeInEndTime=0.130000
         MaxParticles=80
         AddLocationFromOtherEmitter=5
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.002000)
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         AddVelocityFromOtherEmitter=5
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.IE_M75General.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
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
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.171429,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.467857,Color=(B=255,G=192,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=128,R=64,A=255))
         FadeOutStartTime=0.045500
         MaxParticles=15
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=25.000000),Y=(Min=10.000000,Max=25.000000),Z=(Min=10.000000,Max=25.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
         StartVelocityRange=(X=(Min=50.000000,Max=550.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-50.000000,Max=250.000000))
     End Object
     Emitters(7)=SpriteEmitter'BallisticProV55.IE_M75General.SpriteEmitter11'

     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.VBlast'
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
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=0.471429,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=192,R=128,A=255))
         FadeOutStartTime=0.060000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Y=(Min=-0.250000,Max=-0.250000))
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=1.500000,Max=1.500000),Y=(Min=1.500000,Max=1.500000),Z=(Min=1.500000,Max=2.000000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
     End Object
     Emitters(8)=MeshEmitter'BallisticProV55.IE_M75General.MeshEmitter2'

     AutoDestroy=True
}
