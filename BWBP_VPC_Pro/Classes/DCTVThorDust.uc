class DCTVThorDust extends BallisticEmitter;

var float XMirror, YMirror;
var float SpeedThreshold;

simulated function OrientateDust(bool bBackwards, bool bMirrored)
{
	if (bMirrored)
	{
		YMirror = -1;
		Emitters[1].StartLocationOffset.Y = default.Emitters[1].StartLocationOffset.Y * -1;
	}
	if (bBackwards)
	{
		XMirror = -1;
		Emitters[1].StartVelocityRange.X.Max = default.Emitters[1].StartVelocityRange.X.Max * -1;
		Emitters[1].StartVelocityRange.X.Min = default.Emitters[1].StartVelocityRange.X.Min * -1;
		Emitters[2].StartVelocityRange.X.Max = default.Emitters[2].StartVelocityRange.X.Max * -1;
		Emitters[2].StartVelocityRange.X.Min = default.Emitters[2].StartVelocityRange.X.Min * -1;
	}
}

simulated function SetDustColor(color DustColor)
{
	if (DustColor.R == 0 && DustColor.G == 0 && DustColor.B == 0)
	{
		DustColor.R=180;
		DustColor.G=140;
		DustColor.B=108;
	}
	DustColor.A=255;
	Emitters[0].ColorScale[0].Color = DustColor;
	Emitters[0].ColorScale[1].Color = DustColor;
	Emitters[1].ColorScale[0].Color = DustColor;
	Emitters[1].ColorScale[1].Color = DustColor;
}

simulated function UpdateDust(float Speed, bool bOn, float DigAmp)
{
	if (bOn)
	{
		Emitters[0].InitialParticlesPerSecond = 20 * Speed / SpeedThreshold;
		Emitters[1].InitialParticlesPerSecond = 15 * Speed / SpeedThreshold;
		Emitters[2].InitialParticlesPerSecond = 8 * DigAmp * Speed / SpeedThreshold;
		Emitters[0].ParticlesPerSecond = Emitters[0].InitialParticlesPerSecond;
		Emitters[1].ParticlesPerSecond = Emitters[1].InitialParticlesPerSecond;
		Emitters[2].ParticlesPerSecond = Emitters[2].InitialParticlesPerSecond;

		Emitters[1].StartVelocityRange.X.Max = default.Emitters[1].StartVelocityRange.X.Max * XMirror * Speed / SpeedThreshold;
		Emitters[1].StartVelocityRange.X.Min = Emitters[1].StartVelocityRange.X.Max;
		Emitters[2].StartVelocityRange.X.Max = default.Emitters[2].StartVelocityRange.X.Max * XMirror * Speed / SpeedThreshold;
		Emitters[2].StartVelocityRange.X.Min = Emitters[2].StartVelocityRange.X.Max;

		Emitters[0].AllParticlesDead = false;
		Emitters[1].AllParticlesDead = false;
		Emitters[2].AllParticlesDead = false;
	}
	else
	{
		Emitters[0].InitialParticlesPerSecond = 0;
		Emitters[1].InitialParticlesPerSecond = 0;
		Emitters[2].InitialParticlesPerSecond = 0;
	}
}

defaultproperties
{
     XMirror=1.000000
     YMirror=1.000000
     SpeedThreshold=1000.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=30.000000)
         ColorScale(0)=(Color=(B=128,G=165,R=204,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=165,R=204,A=255))
         Opacity=0.700000
         FadeOutStartTime=1.280000
         FadeInEndTime=0.640000
         MaxParticles=50000
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.400000)
         StartSizeRange=(X=(Max=120.000000),Y=(Max=120.000000),Z=(Max=130.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_VPC_Pro.DCTVThorDust.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=128,G=165,R=204,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=165,R=204,A=255))
         FadeOutStartTime=0.390000
         FadeInEndTime=0.180000
         MaxParticles=50000
         StartLocationOffset=(Y=-30.000000)
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=0.250000,Max=0.250000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.250000)
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-300.000000,Max=-300.000000),Z=(Min=150.000000,Max=150.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_VPC_Pro.DCTVThorDust.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-800.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.320000
         FadeInEndTime=0.120000
         MaxParticles=10000
         StartLocationOffset=(X=-50.000000,Z=-7.000000)
         StartLocationRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         RotationDampingFactorRange=(X=(Min=0.250000,Max=0.250000),Y=(Min=0.250000,Max=0.250000),Z=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=8.000000,Max=15.000000),Y=(Min=8.000000,Max=15.000000),Z=(Min=8.000000,Max=15.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=10000.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-400.000000,Max=-400.000000),Z=(Max=600.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_VPC_Pro.DCTVThorDust.SpriteEmitter2'

     CullDistance=8000.000000
     Physics=PHYS_Trailer
     bHardAttach=True
}
