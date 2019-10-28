//=============================================================================
// IE_SlugHE. The explosive slugs fired by the SK-410
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_SlugHE extends BallisticEmitter
	placeable;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	bDynamicLight = true;
	SetTimer(0.2, false);
}

simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_SuperHigh)
		Emitters[3].Disabled=true;
	if (Level.DetailMode < DM_High)
	{
		Emitters[6].Disabled=true;
		Emitters[7].Disabled=true;
	}
	Super.PreBeginPlay();
}

simulated event Timer()
{
	Super.Timer();
	bDynamicLight = false;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=128,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.114286,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.314286,Color=(B=255,A=255))
         ColorScale(3)=(RelativeTime=0.571429,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(G=192,R=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.460000
         FadeOutStartTime=0.297000
         FadeInEndTime=0.066000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         DetailMode=DM_High
         StartLocationOffset=(X=2.000000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=64.000000,Max=64.000000),Y=(Min=64.000000,Max=64.000000),Z=(Min=64.000000,Max=64.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.501000,Max=0.501000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.IE_SlugHE.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.500000),Z=(Min=0.300000,Max=0.500000))
         Opacity=0.580000
         FadeOutStartTime=0.115000
         FadeInEndTime=0.035000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=5.000000)
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=150.000000),Y=(Min=10.000000,Max=150.000000),Z=(Min=10.000000,Max=150.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.400000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.IE_SlugHE.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=100,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=100,G=100,R=100,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         Opacity=0.360000
         FadeOutStartTime=0.570000
         FadeInEndTime=0.140000
         MaxParticles=5
         StartLocationShape=PTLS_Sphere
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPRecolorsPro.IE_SlugHE.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter34
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.260714,Color=(R=255,A=255))
         ColorScale(2)=(RelativeTime=0.542857,Color=(G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=0.200000
         MaxParticles=1
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPRecolorsPro.IE_SlugHE.SpriteEmitter34'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.700000,Max=0.700000),Z=(Min=0.400000,Max=0.400000))
         Opacity=0.600000
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'XEffects.Skins.MuzFlashA_t'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(4)=SpriteEmitter'BWBPRecolorsPro.IE_SlugHE.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter19
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
         StartSizeRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=20.000000,Max=30.000000),Z=(Min=20.000000,Max=30.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.050000,Max=0.050000)
         StartVelocityRange=(Z=(Min=-100.000000))
         VelocityLossRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.300000,Max=0.400000))
         AddVelocityFromOtherEmitter=5
     End Object
     Emitters(5)=SpriteEmitter'BWBPRecolorsPro.IE_SlugHE.SpriteEmitter19'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter20
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=5.000000)
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=0.207143,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.360714,Color=(A=255))
         ColorScale(3)=(RelativeTime=0.889286,Color=(A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.650000
         FadeOutStartTime=0.132000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=2.000000)
         StartLocationRange=(Y=(Min=-18.000000,Max=18.000000),Z=(Min=-13.000000,Max=13.000000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=8.000000,Max=25.000000),Y=(Min=8.000000,Max=25.000000),Z=(Min=8.000000,Max=25.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BallisticEffects.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.100000,Max=0.900000)
         StartVelocityRange=(Z=(Max=60.000000))
     End Object
     Emitters(6)=SpriteEmitter'BWBPRecolorsPro.IE_SlugHE.SpriteEmitter20'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=0.207143,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.357143,Color=(G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.889286,Color=(R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.900000),Z=(Min=0.000000,Max=0.300000))
         FadeOutStartTime=0.132000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=2.000000)
         StartLocationRange=(Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         SpinCCWorCW=(X=0.000000)
         SpinsPerSecondRange=(X=(Max=0.290000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=25.000000,Max=45.000000),Y=(Min=25.000000,Max=45.000000),Z=(Min=25.000000,Max=45.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB2'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.100000,Max=0.800000)
     End Object
     Emitters(7)=SpriteEmitter'BWBPRecolorsPro.IE_SlugHE.SpriteEmitter21'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=16.000000
     LightPeriod=3
     bUnlit=False
}
