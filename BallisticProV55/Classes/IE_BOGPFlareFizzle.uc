//=============================================================================
// IE_BOGPFlareFizzle.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BOGPFlareFizzle extends BallisticEmitter
	placeable;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	bDynamicLight = true;
	SetTimer(0.2, false);
}

simulated event Timer()
{
	Super.Timer();
	bDynamicLight = false;
}

simulated function SetupColor(int TeamNum)
{
	if(TeamNum != 1)
		return;

	LightHue = 160;

	Emitters[1].ColorMultiplierRange.X.Min=0.3;
	Emitters[1].ColorMultiplierRange.X.Max=0.4;
	Emitters[1].ColorMultiplierRange.Y.Max=0.3;
	Emitters[1].ColorMultiplierRange.Y.Max=0.4;
	Emitters[1].ColorMultiplierRange.Z.Max=1.0;
	Emitters[1].ColorMultiplierRange.Z.Max=1.0;

	Emitters[2].ColorMultiplierRange.X.Min=0.4;
	Emitters[2].ColorMultiplierRange.X.Max=0.5;
	Emitters[2].ColorMultiplierRange.Y.Max=0.4;
	Emitters[2].ColorMultiplierRange.Y.Max=0.5;
	Emitters[2].ColorMultiplierRange.Z.Max=1.0;
	Emitters[2].ColorMultiplierRange.Z.Max=1.0;

	Emitters[5].ColorMultiplierRange.X.Min=0.3;
	Emitters[5].ColorMultiplierRange.X.Max=0.4;
	Emitters[5].ColorMultiplierRange.Y.Max=0.4;
	Emitters[5].ColorMultiplierRange.Y.Max=0.6;
	Emitters[5].ColorMultiplierRange.Z.Max=1.0;
	Emitters[5].ColorMultiplierRange.Z.Max=1.0;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-450.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         MaxCollisions=(Min=1.000000,Max=1.000000)
         SpawnFromOtherEmitter=3
         SpawnAmount=1
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.000000
         FadeInEndTime=0.100000
         MaxParticles=15
         AlphaRef=200
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
         InitialParticlesPerSecond=99999.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.500000,Max=3.000000)
         StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-100.000000,Max=150.000000))
         VelocityLossRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_BOGPFlareFizzle.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.400000),Z=(Min=0.300000,Max=0.400000))
         FadeOutStartTime=5.000000
         MaxParticles=100
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.500000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=6.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-200.000000,Max=500.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_BOGPFlareFizzle.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.500000),Z=(Min=0.400000,Max=0.500000))
         Opacity=0.370000
         MaxParticles=30
         StartLocationRange=(X=(Min=-192.000000,Max=192.000000),Y=(Min=-192.000000,Max=192.000000),Z=(Min=-192.000000,Max=192.000000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=160.000000,Max=250.000000),Y=(Min=160.000000,Max=250.000000),Z=(Min=160.000000,Max=250.000000))
         InitialParticlesPerSecond=40.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_BOGPFlareFizzle.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.350000
         FadeOutStartTime=1.500000
         FadeInEndTime=0.400000
         MaxParticles=300
         StartLocationRange=(Z=(Max=8.000000))
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-8.000000,Max=8.000000),Y=(Min=-8.000000,Max=8.000000),Z=(Min=10.000000,Max=50.000000))
         VelocityLossRange=(Z=(Max=0.500000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_BOGPFlareFizzle.SpriteEmitter3'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_PointLife
         MaxPointsPerTrail=100
         DistanceThreshold=10.000000
         PointLifeTime=3.500000
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-450.000000)
         FadeOutStartTime=1.000000
         FadeInEndTime=1.000000
         MaxParticles=15
         AddLocationFromOtherEmitter=0
         StartSizeRange=(X=(Min=8.000000,Max=9.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.500000,Max=3.500000)
         VelocityLossRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000))
         AddVelocityFromOtherEmitter=0
     End Object
     Emitters(4)=TrailEmitter'BallisticProV55.IE_BOGPFlareFizzle.TrailEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.600000),Z=(Min=0.300000,Max=0.400000))
         Opacity=0.500000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=700.000000,Max=1000.000000),Y=(Min=700.000000,Max=1000.000000),Z=(Min=700.000000,Max=1000.000000))
         InitialParticlesPerSecond=200.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_BOGPFlareFizzle.SpriteEmitter5'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=20
     LightSaturation=128
     LightBrightness=200.000000
     LightRadius=256.000000
     LightPeriod=3
     bDirectional=True
}
