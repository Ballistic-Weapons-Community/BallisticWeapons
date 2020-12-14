//=============================================================================
// HVCMk9RedMuzzleFlash.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVPCMuzzleFlash extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[0].ZTest = true;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ZTest=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.125000,Color=(B=64,R=64,A=255))
         ColorScale(2)=(RelativeTime=0.257143,Color=(B=64,G=128,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.385714,Color=(B=64,R=64,A=255))
         ColorScale(4)=(RelativeTime=0.578571,Color=(B=32,G=64,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.062500
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=30.000000)
         StartSizeRange=(X=(Min=140.000000,Max=140.000000),Y=(Min=140.000000,Max=140.000000),Z=(Min=140.000000,Max=140.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=5000.000000
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.HVCMk9RedMuzzleFlash.SpriteEmitter5'

     Begin Object Class=BeamEmitter Name=BeamEmitter5
         BeamDistanceRange=(Min=200.000000,Max=500.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(Y=(Min=-40.000000,Max=40.000000),Z=(Min=-40.000000,Max=40.000000))
         HighFrequencyNoiseRange=(Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         HighFrequencyPoints=8
         NoiseDeterminesEndPoint=True
         UseBranching=True
         BranchProbability=(Min=0.300000,Max=0.500000)
         BranchEmitter=2
         BranchSpawnAmountRange=(Min=1.000000,Max=1.000000)
         LinkupLifetime=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.314286,Color=(B=128,G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=200,A=255))
         FadeOutStartTime=0.040000
         CoordinateSystem=PTCS_Relative
         MaxParticles=8
         StartLocationOffset=(X=10.000000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=15.000000,Max=20.000000),Z=(Min=15.000000,Max=20.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=6.000000,Max=8.000000)
         SpawnOnTriggerPPS=20.000000
         StartVelocityRange=(X=(Min=1.500000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(1)=BeamEmitter'BallisticProV55.HVCMk9RedMuzzleFlash.BeamEmitter5'

     Begin Object Class=BeamEmitter Name=BeamEmitter6
         BeamDistanceRange=(Min=100.000000,Max=300.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(Y=(Min=-40.000000,Max=40.000000),Z=(Min=-40.000000,Max=40.000000))
         HighFrequencyNoiseRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         HighFrequencyPoints=7
         NoiseDeterminesEndPoint=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.303571,Color=(B=128,G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.018000
         CoordinateSystem=PTCS_Relative
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=10.000000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(2)=BeamEmitter'BallisticProV55.HVCMk9RedMuzzleFlash.BeamEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.607143,Color=(R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.700000
         FadeInEndTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=7
         StartLocationOffset=(X=-20.000000)
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerRange=(Min=7.000000,Max=7.000000)
         SpawnOnTriggerPPS=8.000000
         StartVelocityRange=(X=(Min=60.000000,Max=60.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.HVCMk9RedMuzzleFlash.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseDirectionAs=PTDU_Forward
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.250000,Max=0.250000))
         FadeOutStartTime=0.050000
         FadeInEndTime=0.050000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         DetailMode=DM_SuperHigh
         SpinCCWorCW=(X=1.000000)
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=120.000000,Max=120.000000),Y=(Min=120.000000,Max=120.000000),Z=(Min=120.000000,Max=120.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareC1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.750000,Max=0.750000)
         SpawnOnTriggerRange=(Min=4.000000,Max=4.000000)
         SpawnOnTriggerPPS=9.000000
         StartVelocityRange=(X=(Min=120.000000,Max=120.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.HVCMk9RedMuzzleFlash.SpriteEmitter8'

}
