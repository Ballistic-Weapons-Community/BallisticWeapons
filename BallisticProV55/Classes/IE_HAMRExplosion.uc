//=============================================================================
// IE_HAMRExplosion.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_HAMRExplosion extends DGVEmitter
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
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.090000
         MaxParticles=2
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         InitialParticlesPerSecond=10.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_HAMRExplosion.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.750000,Max=0.750000))
         Opacity=0.640000
         FadeOutStartTime=0.090000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         InitialParticlesPerSecond=10.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_HAMRExplosion.SpriteEmitter1'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
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
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.405000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(Z=(Max=0.200000))
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=0.610000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=2.500000,Max=3.250000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.600000)
     End Object
     Emitters(2)=MeshEmitter'BallisticProV55.IE_HAMRExplosion.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(G=64,R=96,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=32,R=64,A=255))
         ColorMultiplierRange=(X=(Min=0.750000,Max=0.750000),Y=(Min=0.750000,Max=0.750000),Z=(Min=0.750000,Max=0.750000))
         Opacity=0.760000
         FadeOutStartTime=0.525000
         FadeInEndTime=0.090000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=8.000000)
         StartSizeRange=(X=(Min=25.000000,Max=40.000000),Y=(Min=25.000000,Max=40.000000),Z=(Min=25.000000,Max=40.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.NewSmoke1g'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=1.000000,Max=1000.000000),Y=(Min=-75.000000,Max=75.000000),Z=(Min=-75.000000,Max=75.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_HAMRExplosion.SpriteEmitter9'

     Begin Object Class=MeshEmitter Name=MeshEmitter4
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Impact.ConcreteChip3'
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=35
         SpinsPerSecondRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.000000,Max=0.800000),Y=(Min=0.000000,Max=0.800000),Z=(Min=0.000000,Max=0.800000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=50.000000,Max=750.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-250.000000,Max=250.000000))
         VelocityLossRange=(X=(Max=0.750000))
     End Object
     Emitters(4)=MeshEmitter'BallisticProV55.IE_HAMRExplosion.MeshEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
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
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.560000
         FadeInEndTime=0.260000
         MaxParticles=5
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.500000)
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.NewSmoke1f'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=15.000000,Max=100.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
         VelocityLossRange=(X=(Max=0.400000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_HAMRExplosion.SpriteEmitter10'

     Begin Object Class=TrailEmitter Name=TrailEmitter2
         TrailShadeType=PTTST_Linear
         MaxPointsPerTrail=350
         DistanceThreshold=30.000000
         PointLifeTime=1.500000
         FadeOut=True
         RespawnDeadParticles=False
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128))
         FadeOutStartTime=0.500000
         MaxParticles=30
         AddLocationFromOtherEmitter=2
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=3.000000,Max=5.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke5'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         AddVelocityFromOtherEmitter=2
     End Object
     Emitters(6)=TrailEmitter'BallisticProV55.IE_HAMRExplosion.TrailEmitter2'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
}
