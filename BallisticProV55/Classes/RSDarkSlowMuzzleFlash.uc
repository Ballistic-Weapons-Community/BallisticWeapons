//=============================================================================
// RSDarkSlowMuzzleFlash.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkSlowMuzzleFlash extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
	{
		Emitters[1].ZTest = true;
		Emitters[2].ZTest = true;
		Emitters[3].ZTest = true;
		Emitters[4].ZTest = true;
	}
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BallisticHardware2.M763.M763MuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.300000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=0.195000
         FadeInEndTime=0.010000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         Opacity=0.5
         StartLocationOffset=(X=1.000000)
         StartSpinRange=(Z=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.250000,Max=0.250000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.RSDarkSlowMuzzleFlash.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.150000,Color=(G=64,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.135000
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         Opacity=0.5
         StartLocationOffset=(X=10.000000)
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=50.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         Texture=Texture'BallisticEffects.Particles.DirtSpray'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=80.000000,Max=80.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSDarkSlowMuzzleFlash.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.355000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         Opacity=0.5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=50.000000)
         SizeScale(0)=(RelativeSize=0.600000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=7.000000,Max=7.000000),Y=(Min=90.000000,Max=90.000000),Z=(Min=90.000000,Max=90.000000))
         DrawStyle=PTDS_Darken
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=40.000000,Max=40.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSDarkSlowMuzzleFlash.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ZTest=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000),Z=(Min=0.500000))
         FadeOutStartTime=0.290000
         FadeInEndTime=0.015000
         CoordinateSystem=PTCS_Relative
         MaxParticles=30
         Opacity=0.5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=5.000000)
         StartLocationRange=(X=(Max=10.000000))
         StartSizeRange=(X=(Min=1.500000,Max=2.500000),Y=(Min=12.000000,Max=24.000000),Z=(Min=12.000000,Max=24.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=10.000000,Max=10.000000)
         SpawnOnTriggerPPS=5000.000000
         StartVelocityRange=(X=(Min=1.000000,Max=300.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSDarkSlowMuzzleFlash.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=192,G=224,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.214286,Color=(R=255,A=255))
         ColorScale(3)=(RelativeTime=0.428571,Color=(B=255,R=160,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,R=160,A=255))
         FadeOutStartTime=0.057000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         Opacity=0.5
         StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RSDarkSlowMuzzleFlash.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=0.260714,Color=(G=64,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.414286,Color=(B=128,G=192,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,R=192,A=255))
         FadeOutStartTime=0.584000
         FadeInEndTime=0.088000
         CoordinateSystem=PTCS_Relative
         MaxParticles=100
         Opacity=0.5
         DetailMode=DM_SuperHigh
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=45.000000,Max=45.000000)
         StartSizeRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
         Texture=Texture'BallisticEffects.Particles.FlareA1'
         LifetimeRange=(Min=0.800000,Max=0.800000)
         SpawnOnTriggerRange=(Min=12.000000,Max=10.000000)
         SpawnOnTriggerPPS=5000.000000
         StartVelocityRadialRange=(Min=-75.000000,Max=-75.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.RSDarkSlowMuzzleFlash.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.360714,Color=(R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.680000
         FadeInEndTime=0.096000
         CoordinateSystem=PTCS_Relative
         MaxParticles=45
         Opacity=0.5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-30.000000,Z=6.000000)
         StartSpinRange=(X=(Min=-0.030000,Max=0.030000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=0.370000,RelativeSize=1.500000)
         SizeScale(3)=(RelativeTime=0.500000,RelativeSize=0.700000)
         SizeScale(4)=(RelativeTime=0.620000,RelativeSize=1.000000)
         SizeScale(5)=(RelativeTime=0.750000,RelativeSize=0.800000)
         SizeScale(6)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.WaterSpray1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.200000,Max=1.200000)
         SpawnOnTriggerRange=(Min=15.000000,Max=15.000000)
         SpawnOnTriggerPPS=30.000000
         StartVelocityRange=(X=(Min=-100.000000,Max=-100.000000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.RSDarkSlowMuzzleFlash.SpriteEmitter14'

}
