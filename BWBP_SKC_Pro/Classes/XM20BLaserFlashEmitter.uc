//=============================================================================
// GRSXXLaserFlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20BLaserFlashEmitter extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.260714,Color=(B=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.300000,Max=0.300000))
         FadeOutStartTime=0.056000
         FadeInEndTime=0.004000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=10.000000)
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=80.000000,Max=80.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.XM20BLaserFlashEmitter.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.332143,Color=(B=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.300000,Max=0.300000))
         Opacity=0.460000
         FadeOutStartTime=0.147000
         FadeInEndTime=0.045000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationOffset=(X=140.000000)
         StartSizeRange=(X=(Min=30.000000,Max=40.000000),Y=(Min=120.000000,Max=160.000000),Z=(Min=120.000000,Max=160.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.WaterSpray1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
         SpawnOnTriggerRange=(Min=3.000000,Max=3.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Min=10.000000,Max=10.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.XM20BLaserFlashEmitter.SpriteEmitter10'

     bNoDelete=False
}
