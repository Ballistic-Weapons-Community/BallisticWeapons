//=============================================================================
// RSNovaLightMuzzleFlash.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaLightMuzzleFlash extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[4].Disabled = true;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.250000,Max=0.250000),Y=(Min=0.250000,Max=0.250000),Z=(Min=0.700000))
         Opacity=0.730000
         FadeOutStartTime=0.062500
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=30.000000)
         StartSizeRange=(X=(Min=140.000000,Max=180.000000),Y=(Min=140.000000,Max=180.000000),Z=(Min=140.000000,Max=180.000000))
         Texture=Texture'BallisticEffects.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.080000,Max=0.250000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSNovaLightMuzzleFlash.SpriteEmitter13'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=100.000000,Max=300.000000)
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
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.425000,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         FadeOutStartTime=0.040000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartLocationOffset=(X=-20.000000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=1.500000,Max=2.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
     End Object
     Emitters(1)=BeamEmitter'BallisticProV55.RSNovaLightMuzzleFlash.BeamEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=50.000000,Max=100.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         HighFrequencyPoints=7
         NoiseDeterminesEndPoint=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.317857,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         FadeOutStartTime=0.018000
         CoordinateSystem=PTCS_Relative
         MaxParticles=8
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=10.000000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=5.000000,Max=8.000000),Y=(Min=5.000000,Max=8.000000),Z=(Min=5.000000,Max=8.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
     End Object
     Emitters(2)=BeamEmitter'BallisticProV55.RSNovaLightMuzzleFlash.BeamEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(G=200,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=192,A=255))
         Opacity=0.950000
         FadeOutStartTime=0.150000
         FadeInEndTime=0.060000
         CoordinateSystem=PTCS_Relative
         MaxParticles=14
         StartLocationOffset=(X=-15.000000)
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=120.000000,Max=120.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSNovaLightMuzzleFlash.SpriteEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter16
         UseDirectionAs=PTDU_Forward
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.500000))
         FadeOutStartTime=0.050000
         FadeInEndTime=0.050000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         SpinCCWorCW=(X=1.000000)
         StartSpinRange=(X=(Min=0.475000,Max=0.475000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=80.000000),Y=(Min=50.000000,Max=80.000000),Z=(Min=50.000000,Max=80.000000))
         Texture=Texture'BallisticEffects.Particles.FlareC1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=1.000000)
         StartVelocityRange=(X=(Min=120.000000,Max=120.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RSNovaLightMuzzleFlash.SpriteEmitter16'

}
