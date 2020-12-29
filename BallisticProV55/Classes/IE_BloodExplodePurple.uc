//=============================================================================
// IE_BloodExplodePurple.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BloodExplodePurple extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(2)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-40.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.400000,Max=0.900000),Z=(Min=0.500000))
         Opacity=0.380000
         FadeOutStartTime=1.200000
         FadeInEndTime=0.080000
         MaxParticles=6
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=70.000000,Max=70.000000),Y=(Min=70.000000,Max=70.000000),Z=(Min=70.000000,Max=70.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Max=200.000000))
         VelocityLossRange=(X=(Min=1.500000,Max=1.500000),Y=(Min=1.500000,Max=1.500000),Z=(Min=1.500000,Max=1.500000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_BloodExplodePurple.SpriteEmitter4'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=15
         DistanceThreshold=10.000000
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-300.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.400000,Max=0.700000),Z=(Min=0.500000,Max=8.000000))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.050000
         MaxParticles=2
         DetailMode=DM_SuperHigh
         StartLocationRange=(Z=(Min=-10.000000,Max=30.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=70.000000,Max=90.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.Particles.BloodMistShot1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=300.000000,Max=500.000000),Z=(Min=100.000000,Max=120.000000))
     End Object
     Emitters(1)=TrailEmitter'BallisticProV55.IE_BloodExplodePurple.TrailEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.400000,Max=0.900000),Z=(Min=0.500000))
         FadeOutStartTime=1.360000
         FadeInEndTime=0.100000
         AlphaRef=128
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.380000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=80.000000,Max=80.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-80.000000,Max=80.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=150.000000,Max=300.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_BloodExplodePurple.SpriteEmitter1'

     AutoDestroy=True
}
