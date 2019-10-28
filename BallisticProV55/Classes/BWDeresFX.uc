//=============================================================================
// BWPlayerSpaBWDeresFXwnFX.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class BWDeresFX extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=87,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.185714,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.400000,Color=(G=210,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.750000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.590000
         FadeOutStartTime=0.360000
         FadeInEndTime=0.160000
         MaxParticles=35
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-25.000000,Max=25.000000))
         SpinsPerSecondRange=(X=(Max=0.250000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=25.000000,Max=40.000000),Y=(Min=25.000000,Max=40.000000),Z=(Min=25.000000,Max=40.000000))
         InitialParticlesPerSecond=8.000000
         Texture=Texture'BallisticBloodPro.DeRez.Wisp2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=5.000000,Max=25.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BWDeresFX.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=87,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.185714,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.400000,Color=(G=210,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.590000
         FadeOutStartTime=0.540000
         FadeInEndTime=0.320000
         MaxParticles=20
         StartLocationOffset=(Z=15.000000)
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-25.000000,Max=25.000000))
         SpinsPerSecondRange=(X=(Max=0.240000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=25.000000,Max=40.000000),Y=(Min=25.000000,Max=40.000000),Z=(Min=25.000000,Max=40.000000))
         InitialParticlesPerSecond=5.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BallisticBloodPro.DeRez.Wisp1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=10.000000,Max=35.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.BWDeresFX.SpriteEmitter2'

     AutoDestroy=True
}
