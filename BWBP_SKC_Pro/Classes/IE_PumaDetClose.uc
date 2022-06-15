//=============================================================================
// IE_PumaDetClose.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_PumaDetClose extends BallisticEmitter
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
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'AW-2004Particles.Weapons.HellB_Ring'
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=175,G=140,R=32))
         ColorScale(1)=(RelativeTime=0.696429,Color=(B=200,G=150))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=1
         DetailMode=DM_High
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.500000)
         InitialParticlesPerSecond=5000.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(0)=MeshEmitter'BWBP_SKC_Pro.IE_PumaDetClose.MeshEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'AW-2004Particles.Weapons.HellB_Ring'
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=175,G=140))
         ColorScale(1)=(RelativeTime=0.696429,Color=(B=200,G=150))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=1
         DetailMode=DM_High
         StartSpinRange=(Y=(Min=0.250000,Max=0.250000),Z=(Min=0.250000,Max=0.250000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.500000)
         InitialParticlesPerSecond=5000.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(1)=MeshEmitter'BWBP_SKC_Pro.IE_PumaDetClose.MeshEmitter1'

     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'AW-2004Particles.Weapons.HellB_Ring'
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=175,G=140))
         ColorScale(1)=(RelativeTime=0.696429,Color=(B=200,G=150))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=1
         DetailMode=DM_High
         StartSpinRange=(Y=(Min=0.250000,Max=0.250000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.500000)
         InitialParticlesPerSecond=5000.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(2)=MeshEmitter'BWBP_SKC_Pro.IE_PumaDetClose.MeshEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=205,G=171,R=114))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=203,G=84,R=158))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=30.000000,Max=60.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         InitialParticlesPerSecond=10.000000
         Texture=Texture'AW-2004Particles.Fire.BlastMark'
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(3)=SpriteEmitter'BWBP_SKC_Pro.IE_PumaDetClose.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=202,G=174,R=117))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=206,G=84,R=81))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=60.000000,Max=90.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=10.000000
         Texture=Texture'AW-2004Particles.Energy.EclipseCircle'
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(4)=SpriteEmitter'BWBP_SKC_Pro.IE_PumaDetClose.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Right
         UseColorScale=True
         RespawnDeadParticles=False
         UniformSize=True
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=128))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=255,G=128,R=128))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=100
         DetailMode=DM_High
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=8.000000,Max=8.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000))
         ScaleSizeByVelocityMultiplier=(X=0.030000)
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRadialRange=(Min=-100.000000,Max=-200.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=0.250000,RelativeVelocity=(X=1.500000,Y=1.500000,Z=1.500000))
         VelocityScale(2)=(RelativeTime=1.000000,RelativeVelocity=(X=2.000000,Y=2.000000,Z=2.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBP_SKC_Pro.IE_PumaDetClose.SpriteEmitter2'

     Begin Object Class=MeshEmitter Name=MeshEmitter3
         StaticMesh=StaticMesh'AW-2004Particles.Weapons.PlasmaSphere'
         UseParticleColor=True
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,R=108))
         ColorScale(1)=(RelativeTime=0.696429,Color=(B=255,G=157,R=194))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=1
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         InitialParticlesPerSecond=500.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(6)=MeshEmitter'BWBP_SKC_Pro.IE_PumaDetClose.MeshEmitter3'

     Begin Object Class=MeshEmitter Name=MeshEmitter4
         StaticMesh=StaticMesh'BWBP_SKC_Static.PUMA.ShieldShard'
         UseParticleColor=True
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=20
         StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Regular
         LifetimeRange=(Min=0.500000,Max=1.000000)
         StartVelocityRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=-600.000000,Max=600.000000))
     End Object
     Emitters(7)=MeshEmitter'BWBP_SKC_Pro.IE_PumaDetClose.MeshEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.539286,Color=(B=255,G=192,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.092000
         FadeInEndTime=0.032000
         MaxParticles=1
         DetailMode=DM_High
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=350.000000,Max=350.000000),Y=(Min=350.000000,Max=350.000000),Z=(Min=350.000000,Max=350.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.ElectroShock'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(8)=SpriteEmitter'BWBP_SKC_Pro.IE_PumaDetClose.SpriteEmitter10'

     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
     bNoDelete=False
     bUnlit=False
}
