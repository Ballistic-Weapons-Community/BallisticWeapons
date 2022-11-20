//=============================================================================
// A73TrailEmitterBal.
//
// Small sparkly bits added.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class A73PowerTrailEmitterBal extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=120,G=32,R=120))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=240,G=64,R=240))
         Opacity=0.700000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartLocationOffset=(X=-20.000000)
         StartSizeRange=(X=(Min=50.000000,Max=80.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.400000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.A73PowerTrailEmitterBal.SpriteEmitter1'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=50.000000
         UseCrossedSheets=True
         PointLifeTime=0.500000
         FadeOut=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(Y=(Min=0.350000,Max=0.450000))
         Opacity=0.700000
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSizeRange=(X=(Min=15.000000,Max=20.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=9999.000000,Max=9999.000000)
     End Object
     Emitters(1)=TrailEmitter'BallisticProV55.A73PowerTrailEmitterBal.TrailEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=True
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.467857,Color=(B=255,G=64,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.100000
         MaxParticles=40
         DetailMode=DM_SuperHigh
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartLocationRange=(X=(Min=-5.000000,Max=35.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         SizeScale(0)=(RelativeSize=1.200000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BWBP_KBP_Tex.A73Purple.A73MuzzleFlash'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SubdivisionStart=1
         SubdivisionEnd=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=1.200000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.A73PowerTrailEmitterBal.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=True
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=255,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=255,G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.385714,Color=(B=192,G=64,R=192,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=96,A=255))
         FadeOutStartTime=0.600000
         MaxParticles=36
         DetailMode=DM_High
         //CoordinateSystem=PTCS_Relative
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=3.000000,Max=6.000000))
         InitialParticlesPerSecond=60.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.600000,Max=1.200000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.A73PowerTrailEmitterBal.SpriteEmitter3'

     bNoDelete=False
     Physics=PHYS_Trailer
}
