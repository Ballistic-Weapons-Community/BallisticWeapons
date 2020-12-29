//=============================================================================
// IE_HAMRExplosionDirt.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_HAMRExplosionDirt extends DGVEmitter
	placeable;

simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_SuperHigh)
		Emitters[2].Disabled=true;
	if (Level.DetailMode < DM_High)
		Emitters[1].Disabled=true;
	Super.PreBeginPlay();
}

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
     DisableDGV(0)=1
     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Artillery.Blast-FX'
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.300000),Y=(Min=0.150000,Max=0.150000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.405000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=3.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=2.500000,Max=3.250000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.750000,Max=0.750000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.IE_HAMRExplosionDirt.MeshEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-350.000000)
         ColorScale(0)=(Color=(G=64,R=96,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=32,R=64,A=255))
         Opacity=0.830000
         FadeOutStartTime=1.860000
         FadeInEndTime=0.120000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=15.000000,Max=20.000000),Z=(Min=15.000000,Max=20.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-75.000000,Max=75.000000),Y=(Min=-75.000000,Max=75.000000),Z=(Min=250.000000,Max=750.000000))
         VelocityLossRange=(Z=(Max=0.750000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_HAMRExplosionDirt.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-600.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.250000,Max=0.400000),Y=(Min=0.200000,Max=0.300000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=1.155000
         FadeInEndTime=0.015000
         MaxParticles=15
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-250.000000,Max=250.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=100.000000,Max=1000.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_HAMRExplosionDirt.SpriteEmitter1'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=350
         DistanceThreshold=30.000000
         PointLifeTime=1.500000
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.350000),Y=(Min=0.200000,Max=0.300000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.250000
         FadeInEndTime=0.100000
         MaxParticles=50
         AddLocationFromOtherEmitter=2
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Z=(Min=500.000000,Max=1000.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         AddVelocityFromOtherEmitter=2
     End Object
     Emitters(3)=TrailEmitter'BallisticProV55.IE_HAMRExplosionDirt.TrailEmitter0'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
}
