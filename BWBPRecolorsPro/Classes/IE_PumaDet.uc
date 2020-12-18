//=============================================================================
// IE_PumaDet.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_PumaDet extends BallisticEmitter
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
		Emitters[1].Disabled=true;
		Emitters[2].Disabled=true;
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
     Begin Object Class=SpriteEmitter Name=SpriteEmitter93
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.056000
         FadeInEndTime=0.056000
         MaxParticles=3
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=70.000000,Max=70.000000),Y=(Min=70.000000,Max=70.000000),Z=(Min=70.000000,Max=70.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.GunFire.A73Projectile2'
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.IE_PumaDet.SpriteEmitter93'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter94
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=150,R=150,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=100,R=170,A=255))
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.IE_PumaDet.SpriteEmitter94'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter95
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=200,R=200,A=255))
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.GunFire.RailShock'
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPRecolorsPro.IE_PumaDet.SpriteEmitter95'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter96
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=200,G=150,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=100,R=150,A=255))
         FadeOutStartTime=0.300000
         FadeInEndTime=0.300000
         MaxParticles=5
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=5.000000,Max=50.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=70.000000,Max=70.000000),Y=(Min=70.000000,Max=70.000000),Z=(Min=70.000000,Max=70.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBPRecolorsPro.IE_PumaDet.SpriteEmitter96'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter97
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,R=100,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.056000
         FadeInEndTime=0.056000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=0.620000,RelativeSize=3.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=0.300000,Max=0.400000)
     End Object
     Emitters(4)=SpriteEmitter'BWBPRecolorsPro.IE_PumaDet.SpriteEmitter97'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter98
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=40
         StartLocationShape=PTLS_Sphere
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-300.000000,Max=300.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBPRecolorsPro.IE_PumaDet.SpriteEmitter98'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=100.000000,Max=100.000000)
         DetermineEndPointBy=PTEP_Distance
         RotatingSheets=2
         HighFrequencyNoiseRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.700000,Max=0.700000))
         MaxParticles=8
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
     End Object
     Emitters(6)=BeamEmitter'BWBPRecolorsPro.IE_PumaDet.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,R=100,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.056000
         FadeInEndTime=0.056000
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=0.620000,RelativeSize=3.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode2s'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.700000,Max=0.900000)
     End Object
     Emitters(7)=SpriteEmitter'BWBPRecolorsPro.IE_PumaDet.SpriteEmitter0'

     Begin Object Class=SparkEmitter Name=SparkEmitter0
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBetweenSegmentsRange=(Min=0.200000,Max=0.200000)
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=150
         AddLocationFromOtherEmitter=5
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=150.000000
         Texture=Texture'BallisticEffects.GunFire.A73Projectile2'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Max=20.000000),Y=(Max=20.000000),Z=(Max=20.000000))
     End Object
     Emitters(8)=SparkEmitter'BWBPRecolorsPro.IE_PumaDet.SparkEmitter0'

     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
     bUnlit=False
}
