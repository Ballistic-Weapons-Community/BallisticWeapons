//=============================================================================
// IE_GrenadeExplosion.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_FRAGExplosion extends BallisticEmitter
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
		Emitters[2].Disabled=true;
	if (Level.DetailMode < DM_High)
	{
		Emitters[1].Disabled=true;
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
         ColorScale(2)=(RelativeTime=0.317857,Color=(B=255,A=255))
         ColorScale(3)=(RelativeTime=0.571429,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(G=192,R=255))
         ColorMultiplierRange=(X=(Min=0.500000),Y=(Min=0.000000),Z=(Min=0.000000,Max=0.700000))
         Opacity=0.460000
         FadeOutStartTime=0.297000
         FadeInEndTime=0.066000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         DetailMode=DM_High
         StartLocationOffset=(X=2.000000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=146.000000,Max=166.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.100000,Max=1.100000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.IE_FRAGExplosion.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.900000),Z=(Min=0.500000,Max=0.700000))
         Opacity=0.580000
         FadeOutStartTime=0.115000
         FadeInEndTime=0.035000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=5.000000)
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=200.000000,Max=300.000000),Y=(Min=200.000000,Max=300.000000),Z=(Min=200.000000,Max=300.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.400000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.IE_FRAGExplosion.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-180.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.275000,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000),Z=(Min=0.700000,Max=0.800000))
         FadeOutStartTime=0.063000
         DetailMode=DM_High
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=0.000000,Max=40.000000),Y=(Min=0.000000,Max=40.000000),Z=(Min=0.000000,Max=40.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
         StartVelocityRange=(X=(Min=1800.000000,Max=1800.000000),Y=(Min=-540.000000,Max=540.000000),Z=(Max=720.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.IE_FRAGExplosion.SpriteEmitter8'

     Begin Object Class=MeshEmitter Name=MeshEmitter5
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Impact.ConcreteChip2'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.157143,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.482143,Color=(G=128,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.584000
         CoordinateSystem=PTCS_Relative
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Max=4.000000),Y=(Max=4.000000),Z=(Max=4.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         InitialParticlesPerSecond=5000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.300000,Max=1.300000)
         StartVelocityRange=(X=(Min=550.000000,Max=600.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
     End Object
     Emitters(3)=MeshEmitter'BWBP_SKC_Pro.IE_FRAGExplosion.MeshEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter34
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-40.000000)
         ColorScale(0)=(Color=(B=100,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         Opacity=0.250000
         FadeOutStartTime=0.760000
         FadeInEndTime=0.440000
         MaxParticles=4
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=140.000000,Max=140.000000),Y=(Min=140.000000,Max=140.000000),Z=(Min=140.000000,Max=140.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke1'
         StartVelocityRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
         VelocityLossRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.900000,Max=0.900000),Z=(Min=2.990000,Max=2.990000))
     End Object
     Emitters(4)=SpriteEmitter'BWBP_SKC_Pro.IE_FRAGExplosion.SpriteEmitter34'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
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
         Opacity=0.550000
         FadeOutStartTime=3.280000
         FadeInEndTime=1.120000
         StartLocationShape=PTLS_Sphere
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=75.000000,Max=75.000000),Y=(Min=75.000000,Max=75.000000),Z=(Min=75.000000,Max=75.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBP_SKC_Pro.IE_FRAGExplosion.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter19
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=0.200000
         MaxParticles=1
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(6)=SpriteEmitter'BWBP_SKC_Pro.IE_FRAGExplosion.SpriteEmitter19'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter20
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.178571,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.900000),Z=(Min=0.900000))
         Opacity=0.320000
         FadeOutStartTime=0.090000
         FadeInEndTime=0.044000
         MaxParticles=4
         StartLocationRange=(X=(Min=-40.000000,Max=40.000000),Y=(Min=-40.000000,Max=40.000000),Z=(Min=-40.000000,Max=40.000000))
         SpinsPerSecondRange=(X=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=50.000000,Max=80.000000),Y=(Min=50.000000,Max=80.000000),Z=(Min=50.000000,Max=80.000000))
         InitialParticlesPerSecond=15.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000))
     End Object
     Emitters(7)=SpriteEmitter'BWBP_SKC_Pro.IE_FRAGExplosion.SpriteEmitter20'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(8)=SpriteEmitter'BWBP_SKC_Pro.IE_FRAGExplosion.SpriteEmitter21'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter22
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
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.050000,Max=0.050000)
         StartVelocityRange=(Z=(Min=-100.000000))
         VelocityLossRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.300000,Max=0.400000))
         AddVelocityFromOtherEmitter=5
     End Object
     Emitters(9)=SpriteEmitter'BWBP_SKC_Pro.IE_FRAGExplosion.SpriteEmitter22'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
     bUnlit=False
}
