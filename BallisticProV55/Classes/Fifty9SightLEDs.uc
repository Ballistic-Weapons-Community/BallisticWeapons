//=============================================================================
// Fifty9SightLEDs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Fifty9SightLEDs extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.700000,Max=0.700000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-54.000000,Y=-0.850000,Z=11.600000)
         StartSizeRange=(X=(Min=0.450000,Max=0.450000),Y=(Min=0.450000,Max=0.450000),Z=(Min=0.450000,Max=0.450000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.Fifty9SightLEDs.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.700000,Max=0.700000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-54.000000,Y=0.850000,Z=11.600000)
         StartSizeRange=(X=(Min=0.450000,Max=0.450000),Y=(Min=0.450000,Max=0.450000),Z=(Min=0.450000,Max=0.450000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.Fifty9SightLEDs.SpriteEmitter1'

     bHidden=True
     RelativeRotation=(Roll=8192)
}
