//=============================================================================
// IE_RadarWave.
//
// In this universe you can taste and feel the radar waves
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_RadarWave extends BallisticEmitter
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

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
		 UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=100,G=0,R=0,A=0))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=50,G=0,R=0,A=0))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.600000,Max=0.600000))
		 Opacity=0.6
         FadeOutStartTime=0.200000
         MaxParticles=1
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=450.000000,Max=450.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.900000,Max=0.900000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.IE_RadarWave.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.300000,Y=0.300000,Z=0.300000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.700000,Max=0.700000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.700000,Max=0.800000),Z=(Min=0.100000,Max=0.200000))
         Opacity=0.630000
         FadeOutStartTime=0.050000
         MaxParticles=9
         AddLocationFromOtherEmitter=5
         AlphaRef=128
         SpinsPerSecondRange=(X=(Max=2.000000))
         StartSizeRange=(X=(Min=30.000000,Max=40.000000),Y=(Min=30.000000,Max=40.000000),Z=(Min=30.000000,Max=40.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.050000,Max=0.050000)
         StartVelocityRange=(Z=(Min=-100.000000))
         VelocityLossRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.300000,Max=0.400000))
         AddVelocityFromOtherEmitter=5
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.IE_RadarWave.SpriteEmitter4'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=160
     LightSaturation=150
     LightBrightness=80.000000
     LightRadius=252.000000
     LightPeriod=3
}
