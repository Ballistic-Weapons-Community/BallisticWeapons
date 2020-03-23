//=============================================================================
// RSNovaSlowMuzzleFlash.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class LightningFlashEmitter extends BallisticEmitter;

/*simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[0].ZTest = true;
}*/

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseDirectionAs=PTDU_Up
         ProjectionNormal=(Y=1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,A=255))
         ColorScale(1)=(RelativeTime=0.303571,Color=(B=255,G=128,A=255))
         ColorScale(2)=(RelativeTime=0.600000,Color=(B=192,G=192,R=192,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=224,R=224,A=255))
         FadeOutStartTime=0.040000
         CoordinateSystem=PTCS_Relative
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-20.000000,Z=10.000000)
         StartLocationRange=(X=(Max=22.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=12.000000,Max=16.000000),Y=(Min=20.000000,Max=40.000000),Z=(Min=10.000000,Max=10.000000))
         Texture=Texture'BallisticEffects.Particles.DirtSpray'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=10.000000,Max=10.000000)
         SpawnOnTriggerPPS=5000.000000
         StartVelocityRange=(X=(Min=8.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSNovaSlowMuzzleFlash.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseDirectionAs=PTDU_Up
         ProjectionNormal=(Y=1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,A=255))
         ColorScale(1)=(RelativeTime=0.303571,Color=(B=255,G=128,A=255))
         ColorScale(2)=(RelativeTime=0.600000,Color=(B=192,G=192,R=192,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=224,R=224,A=255))
         FadeOutStartTime=0.040000
         CoordinateSystem=PTCS_Relative
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-20.000000,Y=-8.600000,Z=-5.000000)
         StartLocationRange=(X=(Max=22.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=12.000000,Max=16.000000),Y=(Min=20.000000,Max=40.000000),Z=(Min=10.000000,Max=10.000000))
         Texture=Texture'BallisticEffects.Particles.DirtSpray'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=10.000000,Max=10.000000)
         SpawnOnTriggerPPS=5000.000000
         StartVelocityRange=(X=(Min=8.000000,Max=40.000000),Y=(Min=-34.400002,Max=-34.400002),Z=(Min=-20.000000,Max=-20.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSNovaSlowMuzzleFlash.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseDirectionAs=PTDU_Up
         ProjectionNormal=(Y=1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,A=255))
         ColorScale(1)=(RelativeTime=0.303571,Color=(B=255,G=128,A=255))
         ColorScale(2)=(RelativeTime=0.600000,Color=(B=192,G=192,R=192,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=224,R=224,A=255))
         FadeOutStartTime=0.040000
         CoordinateSystem=PTCS_Relative
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-20.000000,Y=8.600000,Z=-5.000000)
         StartLocationRange=(X=(Max=22.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=12.000000,Max=16.000000),Y=(Min=20.000000,Max=40.000000),Z=(Min=10.000000,Max=10.000000))
         Texture=Texture'BallisticEffects.Particles.DirtSpray'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=10.000000,Max=10.000000)
         SpawnOnTriggerPPS=5000.000000
         StartVelocityRange=(X=(Min=8.000000,Max=40.000000),Y=(Min=34.400002,Max=34.400002),Z=(Min=-20.000000,Max=-20.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSNovaSlowMuzzleFlash.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.089286,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.178571,Color=(G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.275000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=0.400000,Color=(B=255,G=128,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.028000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=40.000000)
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=160.000000,Max=160.000000),Z=(Min=160.000000,Max=160.000000))
         Texture=Texture'BallisticEffects.Particles.WaterSpray1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=340.000000,Max=340.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSNovaSlowMuzzleFlash.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         TriggerDisabled=False
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.289286,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         FadeOutStartTime=0.035000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=40.000000),Y=(Min=20.000000,Max=40.000000),Z=(Min=20.000000,Max=40.000000))
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         SpawnOnTriggerRange=(Min=20.000000,Max=20.000000)
         SpawnOnTriggerPPS=5000.000000
         StartVelocityRange=(X=(Min=100.000000,Max=1200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=300.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RSNovaSlowMuzzleFlash.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         TriggerDisabled=False
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.485714,Color=(B=255,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.035000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartLocationOffset=(X=20.000000)
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=40.000000),Y=(Min=20.000000,Max=40.000000),Z=(Min=20.000000,Max=40.000000))
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         SpawnOnTriggerRange=(Min=20.000000,Max=20.000000)
         SpawnOnTriggerPPS=5000.000000
         StartVelocityRange=(X=(Min=400.000000,Max=1200.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=100.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.RSNovaSlowMuzzleFlash.SpriteEmitter12'

}
