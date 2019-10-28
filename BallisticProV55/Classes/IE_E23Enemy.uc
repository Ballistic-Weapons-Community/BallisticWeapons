//=============================================================================
// IE_E23Enemy.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_E23Enemy extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(1)=1
     DisableDGV(2)=1
     DisableDGV(4)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(X=-25.000000,Y=-50.000000,Z=-50.000000)
         ColorScale(0)=(Color=(B=192,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.185714,Color=(B=96,G=200,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         FadeOutStartTime=0.495000
         MaxParticles=4
         StartLocationOffset=(X=5.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=50.000000,Max=400.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-250.000000,Max=250.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_E23Enemy.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=192,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.137500
         FadeInEndTime=0.075000
         MaxParticles=40
         AddLocationFromOtherEmitter=0
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=3.000000,Max=10.000000),Z=(Min=1.000000,Max=2.000000))
         InitialParticlesPerSecond=60.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.WaterRing1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_E23Enemy.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.162000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=35.000000,Max=40.000000),Y=(Min=35.000000,Max=40.000000),Z=(Min=35.000000,Max=40.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_E23Enemy.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.940000
         FadeInEndTime=0.220000
         MaxParticles=5
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         InitialParticlesPerSecond=25.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.NewSmoke1g'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=5.000000,Max=15.000000),Z=(Min=15.000000,Max=35.000000))
         VelocityLossRange=(Z=(Max=1.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_E23Enemy.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=1.000000,Z=0.000000)
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,R=255,A=255))
         FadeOutStartTime=0.100000
         FadeInEndTime=0.070000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(Z=2.000000)
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=10.000000,Max=14.000000),Y=(Min=10.000000,Max=14.000000),Z=(Min=10.000000,Max=14.000000))
         InitialParticlesPerSecond=4.000000
         DrawStyle=PTDS_Modulated
         Texture=Texture'BWBP4-Tex.VPR.Ripple-VPR'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.IE_E23Enemy.SpriteEmitter5'

     AutoDestroy=True
}
