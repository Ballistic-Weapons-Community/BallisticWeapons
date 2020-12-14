//=============================================================================
// IE_WaterBloodGreen.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_WaterBloodGreen extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter33
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.300000),Y=(Min=0.750000),Z=(Min=0.000000,Max=0.300000))
         Opacity=0.300000
         FadeOutStartTime=0.500000
         FadeInEndTime=0.180000
         MaxParticles=20
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.680000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=15.000000,Max=30.000000),Y=(Min=15.000000,Max=30.000000),Z=(Min=15.000000,Max=30.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=-10.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_WaterBloodGreen.SpriteEmitter33'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter38
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.400000))
         Opacity=0.650000
         FadeOutStartTime=0.260000
         FadeInEndTime=0.180000
         MaxParticles=20
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.680000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=15.000000,Max=30.000000),Y=(Min=15.000000,Max=30.000000),Z=(Min=15.000000,Max=30.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticBloodPro.Alien.Alien-Saw1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=-10.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_WaterBloodGreen.SpriteEmitter38'

     AutoDestroy=True
     bHardAttach=True
}
