//=============================================================================
// IE_HMCImpact.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_HMCImpact extends DGVEmitterOversize
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
         ColorScale(1)=(RelativeTime=0.314286,Color=(B=200,G=200,R=200,A=255))
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
     Emitters(0)=MeshEmitter'BWBPRecolorsPro.IE_HMCImpact.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.170000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.IE_HMCImpact.SpriteEmitter1'

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
     Emitters(2)=SpriteEmitter'BWBPRecolorsPro.IE_HMCImpact.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
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
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.171429,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.457143,Color=(B=255,G=192,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=128,R=64,A=255))
         FadeOutStartTime=0.045500
         MaxParticles=45
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=55.000000),Y=(Min=10.000000,Max=55.000000),Z=(Min=10.000000,Max=55.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.050000,Max=1.050000)
         StartVelocityRange=(X=(Min=50.000000,Max=550.000000),Y=(Min=-350.000000,Max=350.000000),Z=(Min=-550.000000,Max=350.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBPRecolorsPro.IE_HMCImpact.SpriteEmitter4'

     Begin Object Class=BeamEmitter Name=BeamEmitter2
         BeamDistanceRange=(Min=20.000000,Max=150.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         HighFrequencyPoints=8
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.157143,Color=(B=128,G=64,A=255))
         ColorScale(2)=(RelativeTime=0.257143,Color=(B=255,G=224,R=192,A=255))
         ColorScale(3)=(RelativeTime=0.357143,Color=(B=128,A=255))
         ColorScale(4)=(RelativeTime=0.457143,Color=(B=255,G=192,R=128,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.112000
         MaxParticles=20
         DetailMode=DM_SuperHigh
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=150.000000
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-0.500000,Max=0.700000))
     End Object
     Emitters(4)=BeamEmitter'BWBPRecolorsPro.IE_HMCImpact.BeamEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(X=2.000000,Y=4.000000,Z=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.500000),Y=(Min=0.000000,Max=0.500000))
         FadeOutStartTime=0.100000
         SpinCCWorCW=(X=0.810000)
         SpinsPerSecondRange=(X=(Min=1.000000,Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'EpicParticles.Flares.HotSpot'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(5)=SpriteEmitter'BWBPRecolorsPro.IE_HMCImpact.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=-1.000000)
         ExtentMultiplier=(X=0.700000,Y=0.700000,Z=0.700000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=128))
         ColorScale(1)=(RelativeTime=0.289286,Color=(B=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.482143,Color=(B=255,A=255))
         ColorScale(3)=(RelativeTime=0.675000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.100000),Y=(Min=0.000000,Max=0.100000))
         FadeOutStartTime=1.920000
         MaxParticles=5
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=20.000000)
         StartSizeRange=(X=(Min=5.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'EmitterTextures.MultiFrame.LargeFlames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Min=1.000000,Max=1.000000))
         StartVelocityRadialRange=(Min=-10.000000,Max=10.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(6)=SpriteEmitter'BWBPRecolorsPro.IE_HMCImpact.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter25
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         Acceleration=(Y=4.000000,Z=-1.000000)
         ExtentMultiplier=(X=0.700000,Y=0.700000,Z=0.700000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=128))
         ColorScale(1)=(RelativeTime=0.482143,Color=(B=255,A=255))
         ColorScale(2)=(RelativeTime=0.675000,Color=(B=255,G=255,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255))
         ColorMultiplierRange=(X=(Min=0.000000),Y=(Min=0.000000))
         FadeOutStartTime=0.510000
         MaxParticles=5
         SphereRadiusRange=(Min=10.000000,Max=20.000000)
         SpinCCWorCW=(X=0.750000)
         SpinsPerSecondRange=(X=(Min=2.000000,Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=5.000000,Max=150.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.501000,Max=0.501000)
         StartVelocityRange=(Z=(Min=1.000000,Max=1.000000))
         StartVelocityRadialRange=(Min=-10.000000,Max=10.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(7)=SpriteEmitter'BWBPRecolorsPro.IE_HMCImpact.SpriteEmitter25'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
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
         Acceleration=(Z=-250.000000)
         ColorScale(0)=(Color=(B=255,G=255,A=255))
         ColorScale(1)=(RelativeTime=0.171429,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.332143,Color=(B=255,A=255))
         ColorScale(3)=(RelativeTime=0.457143,Color=(B=255,G=192,R=128,A=255))
         ColorScale(4)=(RelativeTime=0.821429,Color=(B=255,G=255,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(G=255,A=255))
         ColorScale(6)=(RelativeTime=1.000000,Color=(B=255,G=128,R=64,A=255))
         FadeOutStartTime=0.045500
         MaxParticles=45
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=25.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.350000,Max=1.350000)
         StartVelocityRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-300.000000,Max=300.000000))
     End Object
     Emitters(8)=SpriteEmitter'BWBPRecolorsPro.IE_HMCImpact.SpriteEmitter26'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter28
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(X=2.000000,Y=4.000000,Z=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.500000),Y=(Min=0.000000,Max=0.500000))
         FadeOutStartTime=0.100000
         SpinCCWorCW=(X=0.810000)
         SpinsPerSecondRange=(X=(Min=1.000000,Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(9)=SpriteEmitter'BWBPRecolorsPro.IE_HMCImpact.SpriteEmitter28'

     AutoDestroy=True
}
