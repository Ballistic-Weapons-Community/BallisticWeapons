//=============================================================================
// CoachSteam.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CoachSteam extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.750000
         FadeOutStartTime=1.000000
         FadeInEndTime=0.200000
         MaxParticles=50
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.450000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=7.000000,Max=8.000000),Y=(Min=7.000000,Max=8.000000),Z=(Min=7.000000,Max=8.000000))
         InitialParticlesPerSecond=50.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-45.000000,Max=-15.000000),Y=(Min=-45.000000,Max=-15.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.CoachSteam.SpriteEmitter1'

     AutoDestroy=True
}
