//=============================================================================
// HVCMk9_PlayerEffect.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVCMk9_PlayerEffect extends DGVEmitter;

simulated function StartSound()
{
	AmbientSound = default.AmbientSound;
}
simulated function StopSound()
{
	AmbientSound=None;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseColorScale=True
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.157143,Color=(B=255,G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.346429,Color=(B=255,G=192,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         FadeOutStartTime=0.125000
         MaxParticles=2
         StartLocationRange=(Z=(Min=-20.000000,Max=20.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=60.000000),Y=(Min=40.000000,Max=60.000000),Z=(Min=40.000000,Max=60.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.HVCMk9_PlayerEffect.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.342857,Color=(B=255,G=160,R=64,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.800000))
         FadeOutStartTime=0.132000
         CoordinateSystem=PTCS_Relative
         MaxParticles=14
         StartLocationRange=(Z=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Min=0.300000,Max=0.300000))
         StartSizeRange=(X=(Min=14.000000,Max=24.000000),Y=(Min=14.000000,Max=24.000000),Z=(Min=14.000000,Max=24.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEpicEffects.Beams.BeamFalloff'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=50.000000,Max=400.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-50.000000,Max=200.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.HVCMk9_PlayerEffect.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-400.000000)
         ExtentMultiplier=(X=0.100000,Y=0.100000,Z=0.100000)
         DampingFactorRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=1.260000
         MaxParticles=120
         DetailMode=DM_SuperHigh
         StartLocationRange=(Z=(Min=-20.000000,Max=20.000000))
         StartSizeRange=(X=(Min=4.000000,Max=7.000000),Y=(Min=4.000000,Max=7.000000),Z=(Min=4.000000,Max=7.000000))
         InitialParticlesPerSecond=5.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=1000.000000
         LifetimeRange=(Min=2.500000,Max=2.500000)
         StartVelocityRange=(X=(Min=20.000000,Max=100.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.HVCMk9_PlayerEffect.SpriteEmitter9'

     Begin Object Class=BeamEmitter Name=BeamEmitter3
         BeamDistanceRange=(Min=100.000000,Max=200.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         HighFrequencyNoiseRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         HighFrequencyPoints=8
         NoiseDeterminesEndPoint=True
         UseColorScale=True
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.289286,Color=(B=255,G=128,R=64,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=255,R=128,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.900000,Max=0.900000))
         FadeOutStartTime=0.084000
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-20.000000)
         StartLocationRange=(Z=(Min=-20.000000,Max=20.000000))
         StartSizeRange=(X=(Min=5.000000,Max=7.000000),Y=(Min=5.000000,Max=7.000000),Z=(Min=5.000000,Max=7.000000))
         Texture=Texture'BallisticEpicEffects.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(3)=BeamEmitter'BallisticProV55.HVCMk9_PlayerEffect.BeamEmitter3'

     AutoDestroy=True
     AmbientSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Flesh'
     bHardAttach=True
     SoundVolume=255
     SoundRadius=128.000000
}
