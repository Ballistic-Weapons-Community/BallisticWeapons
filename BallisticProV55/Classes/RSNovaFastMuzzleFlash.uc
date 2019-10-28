//=============================================================================
// RSNovaFastMuzzleFlash.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaFastMuzzleFlash extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[0].ZTest = true;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.085714,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.303571,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=0.578571,Color=(B=255,G=128,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,A=255))
         Opacity=0.630000
         FadeOutStartTime=0.052000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=10.000000)
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.340000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=60.000000,Max=80.000000),Y=(Min=60.000000,Max=80.000000),Z=(Min=60.000000,Max=80.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSNovaFastMuzzleFlash.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.092857,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.185714,Color=(G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.275000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=0.400000,Color=(B=255,G=128,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.028000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=40.000000)
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=35.000000,Max=35.000000),Y=(Min=120.000000,Max=120.000000),Z=(Min=120.000000,Max=120.000000))
         Texture=Texture'BallisticEffects.Particles.WaterSpray1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=340.000000,Max=340.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSNovaFastMuzzleFlash.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Up
         ProjectionNormal=(Y=1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.096429,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.260714,Color=(B=255,G=255,R=192,A=255))
         ColorScale(3)=(RelativeTime=0.510714,Color=(B=255,G=192,R=128,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.024000
         CoordinateSystem=PTCS_Relative
         MaxParticles=16
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-20.000000,Z=10.000000)
         StartLocationRange=(X=(Max=20.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=12.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=10.000000))
         Texture=Texture'BallisticEffects.Particles.DirtSpray'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=8.000000,Max=8.000000)
         SpawnOnTriggerPPS=5000.000000
         StartVelocityRange=(X=(Min=5.000000,Max=10.000000),Z=(Min=15.000000,Max=15.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSNovaFastMuzzleFlash.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         ProjectionNormal=(Y=1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.096429,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.260714,Color=(B=255,G=255,R=192,A=255))
         ColorScale(3)=(RelativeTime=0.510714,Color=(B=255,G=192,R=128,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.024000
         CoordinateSystem=PTCS_Relative
         MaxParticles=16
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-20.000000,Y=-8.600000,Z=-5.000000)
         StartLocationRange=(X=(Max=20.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=12.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=10.000000))
         Texture=Texture'BallisticEffects.Particles.DirtSpray'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=8.000000,Max=8.000000)
         SpawnOnTriggerPPS=5000.000000
         StartVelocityRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=-13.000000,Max=-13.000000),Z=(Min=-7.500000,Max=-7.500000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSNovaFastMuzzleFlash.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseDirectionAs=PTDU_Up
         ProjectionNormal=(Y=1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.096429,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.260714,Color=(B=255,G=255,R=192,A=255))
         ColorScale(3)=(RelativeTime=0.510714,Color=(B=255,G=192,R=128,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.024000
         CoordinateSystem=PTCS_Relative
         MaxParticles=16
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-20.000000,Y=8.600000,Z=-5.000000)
         StartLocationRange=(X=(Max=20.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=12.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=10.000000))
         Texture=Texture'BallisticEffects.Particles.DirtSpray'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=8.000000,Max=8.000000)
         SpawnOnTriggerPPS=5000.000000
         StartVelocityRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=13.000000,Max=13.000000),Z=(Min=-7.500000,Max=-7.500000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RSNovaFastMuzzleFlash.SpriteEmitter4'

}
