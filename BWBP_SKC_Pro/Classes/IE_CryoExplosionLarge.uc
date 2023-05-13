//===============================
//Butts
//
//================================
class IE_CryoExplosionLarge extends BallisticEmitter
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
     Begin Object Class=SparkEmitter Name=SparkEmitter2
         LineSegmentsRange=(Min=1.000000,Max=2.000000)
         TimeBeforeVisibleRange=(Min=0.050000,Max=0.050000)
         TimeBetweenSegmentsRange=(Min=0.150000,Max=0.250000)
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-40.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.600000),Y=(Min=0.600000,Max=0.900000))
         FadeOutStartTime=0.364000
         FadeInEndTime=0.084000
         MaxParticles=50
         DetailMode=DM_High
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=1.200000)
         StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Max=500.000000))
     End Object
     Emitters(0)=SparkEmitter'BWBP_SKC_Pro.IE_CryoExplosionLarge.SparkEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter104
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.900000,Max=0.900000))
         FadeOutStartTime=1.500000
         FadeInEndTime=1.500000
         MaxParticles=20
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=75.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         LifetimeRange=(Min=5.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=100.000000,Max=400.000000))
         VelocityLossRange=(X=(Min=1.900000,Max=1.900000),Y=(Min=1.900000,Max=1.900000),Z=(Min=1.900000,Max=1.900000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.IE_CryoExplosionLarge.SpriteEmitter104'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter105
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-400.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.560000
         FadeInEndTime=0.160000
         MaxParticles=50
         StartLocationShape=PTLS_Sphere
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.FlamePartsAlpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=6.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=-175.000000,Max=175.000000),Y=(Min=-175.000000,Max=175.000000),Z=(Min=25.000000,Max=550.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.IE_CryoExplosionLarge.SpriteEmitter105'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter106
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-300.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         ColorScale(0)=(Color=(B=255,G=150,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=150,R=100,A=255))
         FadeOutStartTime=0.700000
         FadeInEndTime=0.100000
         MaxParticles=50
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=10.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Specularity.BWSpecularity'
         LifetimeRange=(Min=3.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=150.000000,Max=450.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_SKC_Pro.IE_CryoExplosionLarge.SpriteEmitter106'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter107
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=200,R=150,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=200,R=150,A=255))
         FadeOutStartTime=0.560000
         FadeInEndTime=0.150000
         MaxParticles=3
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=90.000000,Max=150.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.070000,RelativeSize=3.000000)
         SizeScale(1)=(RelativeTime=0.340000,RelativeSize=4.000000)
         SizeScale(2)=(RelativeTime=0.810000,RelativeSize=5.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=90.000000,Max=90.000000),Y=(Min=90.000000,Max=90.000000),Z=(Min=90.000000,Max=90.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.NewSmoke1g'
         LifetimeRange=(Min=1.500000,Max=2.500000)
     End Object
     Emitters(4)=SpriteEmitter'BWBP_SKC_Pro.IE_CryoExplosionLarge.SpriteEmitter107'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter108
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=200,R=150,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=200,R=150,A=255))
         FadeOutStartTime=0.090000
         FadeInEndTime=0.090000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.070000,RelativeSize=3.000000)
         SizeScale(1)=(RelativeTime=0.340000,RelativeSize=4.000000)
         SizeScale(2)=(RelativeTime=0.810000,RelativeSize=5.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=175.000000,Max=175.000000),Y=(Min=175.000000,Max=175.000000),Z=(Min=175.000000,Max=175.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(5)=SpriteEmitter'BWBP_SKC_Pro.IE_CryoExplosionLarge.SpriteEmitter108'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter111
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.200000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.070000
         FadeInEndTime=0.040000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=900.000000,Max=900.000000),Y=(Min=900.000000,Max=900.000000),Z=(Min=900.000000,Max=900.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         LifetimeRange=(Min=0.600000,Max=0.600000)
     End Object
     Emitters(6)=SpriteEmitter'BWBP_SKC_Pro.IE_CryoExplosionLarge.SpriteEmitter111'

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
         FadeOutStartTime=0.006000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=20.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.GunFire.RailShock'
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(7)=SpriteEmitter'BWBP_SKC_Pro.IE_CryoExplosionLarge.SpriteEmitter0'
	 
     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=100.000000)
         ExtentMultiplier=(X=0.400000,Y=0.400000,Z=0.400000)
         ColorScale(0)=(Color=(B=255,G=255,R=225,A=255))
         ColorScale(1)=(RelativeTime=0.032143,Color=(B=255,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.064286,Color=(B=255,G=128,R=64,A=255))
         ColorScale(3)=(RelativeTime=0.114286,Color=(B=255,G=128,R=128,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,G=128,R=128,A=255))
         Opacity=0.700000
         FadeOutStartTime=10.000000
         MaxParticles=35
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=20.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         SizeScale(3)=(RelativeTime=0.370000,RelativeSize=0.900000)
         SizeScale(4)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Max=120.000000),Y=(Max=120.000000),Z=(Max=120.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRadialRange=(Min=-500.000000,Max=-300.000000)
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=4.000000,Max=4.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(8)=SpriteEmitter'BWBP_SKC_Pro.IE_CryoExplosionLarge.SpriteEmitter10'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
     bDirectional=True
}
