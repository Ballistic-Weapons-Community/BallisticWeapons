//=============================================================================
// MRT6Smoke.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MRT6Smoke extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=15.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         Opacity=0.430000
         FadeOutStartTime=0.380000
         FadeInEndTime=0.060000
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         SpinsPerSecondRange=(X=(Max=0.100000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=20.000000,Max=30.000000),Z=(Min=20.000000,Max=30.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=80.000000,Max=250.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-10.000000,Max=30.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.MRT6Smoke.SpriteEmitter0'

     AutoDestroy=True
}
