//=============================================================================
// IE_G28Explosion.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_G28Explosion extends BallisticEmitter
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
     Begin Object Class=SpriteEmitter Name=SpriteEmitter19
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.907143,Color=(B=225,G=225,R=225,A=160))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000)
         FadeOutStartTime=0.686190
         DetailMode=DM_High
         StartLocationRange=(X=(Min=-16.000000,Max=16.000000),Y=(Min=-16.000000,Max=16.000000),Z=(Min=-20.000000,Max=60.000000))
         AddLocationFromOtherEmitter=4
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.020000,Max=0.020000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.650000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=90.000000),Y=(Min=90.000000),Z=(Min=90.000000))
         InitialParticlesPerSecond=80.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=2.000000,Max=3.000000)
         InitialDelayRange=(Min=0.750000,Max=0.750000)
         StartVelocityRange=(X=(Min=-60.000000,Max=60.000000),Y=(Min=-60.000000,Max=60.000000),Z=(Min=0.800000,Max=20.000000))
         VelocityLossRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter19'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter20
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.700000
         FadeOutStartTime=0.119000
         MaxParticles=6
         StartLocationRange=(Z=(Min=0.100000,Max=0.100000))
         AddLocationFromOtherEmitter=0
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.010000)
         SizeScale(1)=(RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=0.250000,RelativeSize=3.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=48.000000,Max=48.000000),Y=(Min=48.000000,Max=48.000000),Z=(Min=48.000000,Max=48.000000))
         InitialParticlesPerSecond=300.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.500000,Max=1.500000)
         InitialDelayRange=(Min=0.750000,Max=0.750000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter20'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.907143,Color=(B=225,G=225,R=225,A=160))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000)
         FadeOutStartTime=0.686190
         DetailMode=DM_High
         StartLocationRange=(X=(Min=-16.000000,Max=16.000000),Y=(Min=-16.000000,Max=16.000000),Z=(Min=-20.000000,Max=60.000000))
         AddLocationFromOtherEmitter=4
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.020000,Max=0.020000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.650000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=90.000000),Y=(Min=90.000000),Z=(Min=90.000000))
         InitialParticlesPerSecond=80.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=3.000000)
         InitialDelayRange=(Min=0.750000,Max=0.750000)
         StartVelocityRange=(X=(Min=-60.000000,Max=60.000000),Y=(Min=-60.000000,Max=60.000000),Z=(Min=0.800000,Max=20.000000))
         VelocityLossRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter21'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter22
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         MaxParticles=5
         AddLocationFromOtherEmitter=2
         SizeScale(0)=(RelativeSize=5.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         InitialDelayRange=(Min=0.750000,Max=0.750000)
         AddVelocityFromOtherEmitter=2
     End Object
     Emitters(3)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter22'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter23
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.900000,Max=0.900000))
         Opacity=0.400000
         FadeOutStartTime=0.640000
         FadeInEndTime=0.030000
         MaxParticles=25
         StartLocationShape=PTLS_Sphere
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=75.000000,Max=75.000000),Y=(Min=75.000000,Max=75.000000),Z=(Min=75.000000,Max=75.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-100.000000,Max=100.000000))
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(4)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter23'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter24
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=100.000000)
         StartSizeRange=(X=(Min=3.500000,Max=3.500000),Y=(Min=3.500000,Max=3.500000),Z=(Min=3.500000,Max=3.500000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         InitialDelayRange=(Min=0.750000,Max=0.750000)
     End Object
     Emitters(5)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter24'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter25
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.300000
         FadeOutStartTime=4.410000
         FadeInEndTime=1.890000
         MaxParticles=50
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000))
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         LifetimeRange=(Min=7.000000,Max=7.000000)
         InitialDelayRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=15.000000,Max=15.000000))
         VelocityLossRange=(Z=(Min=0.250000,Max=0.250000))
     End Object
     Emitters(6)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter25'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-42.500000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(G=150,R=200,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=100,R=150,A=255))
         FadeOutStartTime=2.000000
         FadeInEndTime=2.000000
         MaxParticles=20
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.BurnFlare'
         LifetimeRange=(Min=5.000000,Max=5.000000)
         InitialDelayRange=(Min=0.750000,Max=0.750000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Max=100.000000))
     End Object
     Emitters(7)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter26'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter27
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         FadeOutStartTime=1.000000
         FadeInEndTime=1.000000
         MaxParticles=20
         StartLocationRange=(X=(Min=-40.000000,Max=40.000000),Y=(Min=-40.000000,Max=40.000000),Z=(Min=-40.000000,Max=40.000000))
         AddLocationFromOtherEmitter=4
         StartLocationShape=PTLS_Sphere
         SpinsPerSecondRange=(X=(Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         InitialDelayRange=(Min=0.750000,Max=0.750000)
     End Object
     Emitters(8)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter27'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter31
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-85.000000)
         ColorScale(0)=(Color=(G=150,R=200,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=100,R=150,A=255))
         Opacity=0.500000
         FadeOutStartTime=0.180000
         FadeInEndTime=0.180000
         MaxParticles=125
         StartLocationRange=(X=(Min=-80.000000,Max=80.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-80.000000,Max=80.000000))
         SphereRadiusRange=(Min=100.000000,Max=100.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.Rev_Particle1'
         InitialDelayRange=(Min=0.750000,Max=0.750000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=150.000000,Max=200.000000))
     End Object
     Emitters(9)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter31'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter38
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.300000
         FadeOutStartTime=4.410000
         FadeInEndTime=1.890000
         MaxParticles=50
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000))
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         LifetimeRange=(Min=7.000000,Max=7.000000)
         InitialDelayRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=15.000000,Max=15.000000))
         VelocityLossRange=(Z=(Min=0.250000,Max=0.250000))
     End Object
     Emitters(10)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter38'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter50
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.400000
         FadeOutStartTime=0.090000
         FadeInEndTime=0.090000
         MaxParticles=4
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.140000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=11.000000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=12.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=13.000000)
         StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.Explode2'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         InitialDelayRange=(Min=0.650000,Max=0.650000)
     End Object
     Emitters(11)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter50'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter81
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.000000
         FadeInEndTime=1.000000
         MaxParticles=2
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.140000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=11.000000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=12.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=13.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode3'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
         InitialDelayRange=(Min=0.750000,Max=0.750000)
     End Object
     Emitters(12)=SpriteEmitter'BWBPRecolorsPro.IE_G28Explosion.SpriteEmitter81'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
}
