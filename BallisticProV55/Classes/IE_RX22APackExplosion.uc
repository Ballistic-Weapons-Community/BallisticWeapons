//=============================================================================
// IE_RX22APackExplosion.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_RX22APackExplosion extends BallisticEmitter
	placeable;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	bDynamicLight = true;
	SetTimer(0.2, false);
	if (!Level.GetLocalPlayerController().LineOfSightTo(self))
		Emitters[0].ZTest=true;
}

simulated event Timer()
{
	Super.Timer();
	bDynamicLight = false;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ZTest=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=64,G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.214286,Color=(B=128,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=32,G=192,R=255,A=255))
         FadeOutStartTime=0.055000
         FadeInEndTime=0.032500
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=180.000000,Max=180.000000),Y=(Min=180.000000,Max=180.000000),Z=(Min=180.000000,Max=180.000000))
         InitialParticlesPerSecond=6.000000
         Texture=Texture'BallisticEffects.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_RX22APackExplosion.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.700000,Max=0.900000),Z=(Min=0.600000,Max=0.700000))
         FadeOutStartTime=0.090000
         MaxParticles=6
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.400000)
         StartSizeRange=(X=(Min=140.000000,Max=160.000000),Y=(Min=140.000000,Max=160.000000),Z=(Min=140.000000,Max=160.000000))
         InitialParticlesPerSecond=15.000000
         Texture=Texture'BallisticEffects.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_RX22APackExplosion.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=128,G=212,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=128,R=255,A=255))
         FadeOutStartTime=0.318000
         MaxParticles=15
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=16.000000,Max=16.000000)
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=60.000000),Y=(Min=40.000000,Max=60.000000),Z=(Min=40.000000,Max=60.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.600000)
         StartVelocityRadialRange=(Min=-600.000000,Max=-400.000000)
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_RX22APackExplosion.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
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
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.171429,Color=(B=128,G=212,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=32,G=128,R=255,A=255))
         FadeOutStartTime=0.390000
         MaxParticles=40
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=32.000000,Max=32.000000)
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=60.000000),Y=(Min=30.000000,Max=60.000000),Z=(Min=30.000000,Max=60.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Max=100.000000))
         StartVelocityRadialRange=(Min=-700.000000,Max=-300.000000)
         VelocityLossRange=(X=(Min=1.500000,Max=1.500000),Y=(Min=1.500000,Max=1.500000),Z=(Min=1.000000,Max=1.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_RX22APackExplosion.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=1.220000
         FadeInEndTime=0.100000
         MaxParticles=8
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.200000)
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticWeapons2.Effects.Smoke7'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-80.000000,Max=200.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.IE_RX22APackExplosion.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-800.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.235714,Color=(B=64,G=212,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.578571,Color=(B=64,G=212,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=32,G=96,R=255,A=255))
         FadeOutStartTime=0.720000
         DetailMode=DM_SuperHigh
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=20.000000
         Texture=Texture'BallisticEffects.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=-200.000000,Max=600.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_RX22APackExplosion.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=128,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.164286,Color=(B=64,G=212,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.428571,Color=(B=32,G=64,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.296000
         FadeInEndTime=0.144000
         MaxParticles=60
         DetailMode=DM_SuperHigh
         AddLocationFromOtherEmitter=5
         StartSizeRange=(X=(Min=5.000000,Max=7.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.015000)
         InitialParticlesPerSecond=60.000000
         Texture=Texture'BallisticEffects.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         AddVelocityFromOtherEmitter=5
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.IE_RX22APackExplosion.SpriteEmitter11'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
}
