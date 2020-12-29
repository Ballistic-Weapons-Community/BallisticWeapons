//=============================================================================
// RSDarkFastMuzzleFlash.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkFastMuzzleFlash extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
	{
		Emitters[0].ZTest = true;
		Emitters[1].ZTest = true;
		Emitters[2].ZTest = true;
		Emitters[3].ZTest = true;
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ZTest=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.200000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.084000
         FadeInEndTime=0.012000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
		 Opacity=0.5
         StartLocationOffset=(X=10.000000)
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=40.000000),Y=(Min=70.000000,Max=80.000000),Z=(Min=70.000000,Max=80.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.DirtSpray'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=180.000000,Max=180.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSDarkFastMuzzleFlash.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
		 Opacity=0.5
         ColorScale(0)=(Color=(B=255,G=64,R=128,A=255))
         ColorScale(1)=(RelativeTime=0.121429,Color=(B=255,R=64,A=255))
         ColorScale(2)=(RelativeTime=0.300000,Color=(G=64,R=192,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=64,R=255,A=255))
         FadeOutStartTime=0.038000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationOffset=(X=5.000000)
         StartSizeRange=(X=(Min=30.000000,Max=35.000000),Y=(Min=30.000000,Max=35.000000),Z=(Min=30.000000,Max=35.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSDarkFastMuzzleFlash.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
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
         FadeOutStartTime=0.380000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
		 Opacity=0.5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=30.000000)
         SizeScale(0)=(RelativeSize=0.600000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=70.000000,Max=70.000000),Z=(Min=70.000000,Max=70.000000))
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=35.000000,Max=35.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSDarkFastMuzzleFlash.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
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
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.310000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
		 Opacity=0.5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=30.000000)
         SizeScale(0)=(RelativeSize=0.600000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=70.000000,Max=70.000000),Z=(Min=70.000000,Max=70.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=35.000000,Max=35.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSDarkFastMuzzleFlash.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(G=64,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.542857,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.455000
         MaxParticles=20
		 Opacity=0.5
         DetailMode=DM_SuperHigh
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=40.000000,Max=40.000000)
         StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=0.700000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=5000.000000
         StartVelocityRadialRange=(Min=60.000000,Max=60.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RSDarkFastMuzzleFlash.SpriteEmitter5'

}
