//=============================================================================
// IE_BOGPFlareImpact.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BOGPFlareImpact extends BallisticEmitter
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

	Emitters[4].ColorMultiplierRange.X.Min=0.3;
	Emitters[4].ColorMultiplierRange.X.Max=0.4;
	Emitters[4].ColorMultiplierRange.Y.Max=0.5;
	Emitters[4].ColorMultiplierRange.Y.Max=0.6;
	Emitters[4].ColorMultiplierRange.Z.Max=1.0;
	Emitters[4].ColorMultiplierRange.Z.Max=1.0;
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
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.500000,Max=3.000000)
         StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-100.000000,Max=150.000000))
         VelocityLossRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_BOGPFlareImpact.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-250.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.000000
         MaxParticles=6
         StartLocationRange=(X=(Min=-48.000000,Max=48.000000),Y=(Min=-48.000000,Max=48.000000),Z=(Max=6.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=5.000000,Max=10.000000),Z=(Min=5.000000,Max=10.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_BOGPFlareImpact.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         FadeOutStartTime=2.030000
         FadeInEndTime=0.420000
         MaxParticles=20
         StartLocationRange=(Z=(Max=8.000000))
         AddLocationFromOtherEmitter=1
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=6.000000,Max=10.000000),Y=(Min=6.000000,Max=10.000000),Z=(Min=6.000000,Max=10.000000))
         DrawStyle=PTDS_Darken
         Texture=Texture'BallisticEffects.Particles.Smoke2'
         LifetimeRange=(Min=3.500000,Max=3.500000)
         StartVelocityRange=(X=(Max=8.000000),Y=(Max=8.000000),Z=(Min=50.000000,Max=80.000000))
         VelocityLossRange=(Z=(Max=0.500000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_BOGPFlareImpact.SpriteEmitter2'

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
         Texture=Texture'BallisticEffects.Particles.Smoke4'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-8.000000,Max=8.000000),Y=(Min=-8.000000,Max=8.000000),Z=(Min=10.000000,Max=50.000000))
         VelocityLossRange=(Z=(Max=0.500000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_BOGPFlareImpact.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.600000),Z=(Min=0.300000,Max=0.400000))
         Opacity=0.800000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=300.000000,Max=350.000000),Y=(Min=300.000000,Max=350.000000),Z=(Min=300.000000,Max=350.000000))
         InitialParticlesPerSecond=200.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.IE_BOGPFlareImpact.SpriteEmitter4'

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
         Texture=Texture'BallisticEffects.Particles.Smoke2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.500000,Max=3.500000)
         VelocityLossRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000))
         AddVelocityFromOtherEmitter=0
     End Object
     Emitters(5)=TrailEmitter'BallisticProV55.IE_BOGPFlareImpact.TrailEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=150,G=220,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=96,R=192,A=255))
         FadeOutStartTime=0.472000
         MaxParticles=1100
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Max=0.500000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.750000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'BallisticEffects.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.800000)
         StartVelocityRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.IE_BOGPFlareImpact.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.600000,Max=0.800000),Z=(Min=0.400000,Max=0.600000))
         FadeOutStartTime=0.500000
         MaxParticles=175
         StartLocationRange=(X=(Min=-35.000000,Max=35.000000),Y=(Min=-35.000000,Max=35.000000),Z=(Min=2.000000,Max=3.000000))
         AddLocationFromOtherEmitter=1
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=5.000000,Max=7.000000))
         InitialParticlesPerSecond=60.000000
         Texture=Texture'BallisticEffects.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Max=100.000000))
     End Object
     Emitters(7)=SpriteEmitter'BallisticProV55.IE_BOGPFlareImpact.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.800000),Z=(Min=0.000000,Max=0.400000))
         FadeOutStartTime=0.240000
         FadeInEndTime=0.075000
         MaxParticles=45
         DetailMode=DM_SuperHigh
         AddLocationFromOtherEmitter=1
         StartSizeRange=(X=(Min=5.000000,Max=50.000000),Y=(Min=5.000000,Max=50.000000),Z=(Min=5.000000,Max=50.000000))
         InitialParticlesPerSecond=12.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         LifetimeRange=(Min=0.100000,Max=0.500000)
         StartVelocityRange=(Z=(Max=20.000000))
     End Object
     Emitters(8)=SpriteEmitter'BallisticProV55.IE_BOGPFlareImpact.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.800000),Z=(Min=0.700000))
         FadeOutStartTime=0.400000
         FadeInEndTime=0.200000
         MaxParticles=30
         StartLocationOffset=(Z=5.000000)
         StartLocationRange=(Z=(Max=2.000000))
         AddLocationFromOtherEmitter=1
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=20.000000,Max=35.000000))
         InitialParticlesPerSecond=8.000000
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Max=50.000000))
     End Object
     Emitters(9)=SpriteEmitter'BallisticProV55.IE_BOGPFlareImpact.SpriteEmitter9'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=20
     LightSaturation=200
     LightBrightness=150.000000
     LightRadius=48.000000
     LightPeriod=3
     bDirectional=True
}
