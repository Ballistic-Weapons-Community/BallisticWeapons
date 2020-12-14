//=============================================================================
// RX22ACloudBang.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22ACloudBang extends BallisticEmitter;

simulated function InitCloudBang(float ScaleFactor)
{
	Emitters[0].Opacity = ScaleFactor;
	Emitters[1].Opacity = ScaleFactor;
	Emitters[1].InitialParticlesPerSecond = 14 - 5 * ScaleFactor;
	if (ScaleFactor < 0.25)
	{
		Emitters[3].Disabled=true;
		Emitters[4].Disabled=true;
	}
	else
	{
		Emitters[3].Opacity = FMin(1.0, ScaleFactor+0.25);
		Emitters[4].LifeTimeRange.Min = 0.25 + ScaleFactor * 0.4;
		Emitters[4].LifeTimeRange.Min = Emitters[4].LifeTimeRange.Max;
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.442857,Color=(B=128,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=64,G=192,R=255,A=255))
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=120.000000,Max=120.000000),Y=(Min=120.000000,Max=120.000000),Z=(Min=120.000000,Max=120.000000))
         InitialParticlesPerSecond=2.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RX22ACloudBang.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=192,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         FadeOutStartTime=0.066500
         MaxParticles=4
         StartLocationRange=(X=(Min=-80.000000,Max=80.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-80.000000,Max=80.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=9.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RX22ACloudBang.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=40.000000)
         ColorScale(0)=(Color=(B=64,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.092857,Color=(G=64,R=192,A=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         Opacity=0.600000
         FadeOutStartTime=2.070000
         FadeInEndTime=0.810000
         MaxParticles=5
         StartLocationOffset=(Z=60.000000)
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.200000)
         StartSizeRange=(X=(Min=70.000000,Max=80.000000),Y=(Min=70.000000,Max=80.000000),Z=(Min=70.000000,Max=80.000000))
         InitialParticlesPerSecond=12.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Max=200.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RX22ACloudBang.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=80.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.467857,Color=(B=64,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         FadeOutStartTime=0.140000
         FadeInEndTime=0.021000
         MaxParticles=2
         StartSpinRange=(X=(Min=0.475000,Max=0.525000))
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=240.000000,Max=240.000000),Y=(Min=240.000000,Max=240.000000),Z=(Min=240.000000,Max=240.000000))
         InitialParticlesPerSecond=8.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.600000,Max=0.600000)
         InitialDelayRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=-160.000000,Max=160.000000),Y=(Min=-160.000000,Max=160.000000),Z=(Min=180.000000,Max=180.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RX22ACloudBang.SpriteEmitter3'

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
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.485714,Color=(B=64,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=64,R=255,A=255))
         FadeOutStartTime=0.060000
         MaxParticles=40
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=50.000000,Max=50.000000)
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(1)=(RelativeTime=0.180000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=60.000000),Y=(Min=40.000000,Max=60.000000),Z=(Min=40.000000,Max=60.000000))
         InitialParticlesPerSecond=120.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         InitialDelayRange=(Min=0.300000,Max=0.300000)
         StartVelocityRadialRange=(Min=-500.000000,Max=-500.000000)
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RX22ACloudBang.SpriteEmitter4'

     AutoDestroy=True
}
