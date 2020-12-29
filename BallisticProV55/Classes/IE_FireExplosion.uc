//=============================================================================
// IE_FireExplosion.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_FireExplosion extends BallisticEmitter
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
     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
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
         FadeOutStartTime=1.200000
         FadeInEndTime=0.680000
         MaxParticles=8
         StartLocationRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000))
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=20000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke5'
         SecondsBeforeInactive=0.000000
         StartVelocityRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=400.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=2.000000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_FireExplosion.SpriteEmitter6'

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
         AddLocationFromOtherEmitter=3
         StartSizeRange=(X=(Min=8.000000,Max=9.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.500000,Max=3.500000)
         VelocityLossRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000))
         AddVelocityFromOtherEmitter=3
     End Object
     Emitters(1)=TrailEmitter'BallisticProV55.IE_FireExplosion.TrailEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-400.000000)
         ExtentMultiplier=(X=0.700000,Y=0.700000,Z=0.700000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.600000,Max=0.800000),Z=(Min=0.400000,Max=0.600000))
         FadeOutStartTime=1.000000
         MaxParticles=75
         DetailMode=DM_SuperHigh
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=20.000000)
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=5.000000,Max=8.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SubdivisionEnd=15
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRadialRange=(Min=-500.000000,Max=-800.000000)
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=4.000000,Max=4.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_FireExplosion.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-450.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.750000),Z=(Min=0.250000,Max=0.550000))
         FadeOutStartTime=2.280000
         FadeInEndTime=0.090000
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
         StartVelocityRange=(X=(Min=-450.000000,Max=450.000000),Y=(Min=-450.000000,Max=450.000000),Z=(Min=-100.000000,Max=400.000000))
         VelocityLossRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_FireExplosion.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=128,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=64,R=192,A=255))
         FadeOutStartTime=0.472000
         MaxParticles=1100
         AddLocationFromOtherEmitter=3
         SpinsPerSecondRange=(X=(Max=0.500000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.750000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.800000)
         StartVelocityRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
         AddVelocityFromOtherEmitter=3
         AddVelocityMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.IE_FireExplosion.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.600000,Max=0.800000),Z=(Min=0.500000,Max=0.600000))
         MaxParticles=1
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=0.700000)
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_FireExplosion.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.600000,Max=0.800000),Z=(Min=0.500000,Max=0.600000))
         MaxParticles=1
         DetailMode=DM_SuperHigh
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=0.700000)
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.IE_FireExplosion.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Max=1.500000))
         FadeOutStartTime=0.200000
         MaxParticles=2
         AlphaRef=128
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.100000)
         StartSizeRange=(X=(Min=200.000000,Max=300.000000))
         InitialParticlesPerSecond=20.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(7)=SpriteEmitter'BallisticProV55.IE_FireExplosion.SpriteEmitter2'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
}
