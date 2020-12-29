//=============================================================================
// M50SightLEDs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class M50SightLEDs extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.400000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-97.000000,Z=18.200001)
         StartSizeRange=(X=(Min=0.350000,Max=0.350000),Y=(Min=0.350000,Max=0.350000),Z=(Min=0.350000,Max=0.350000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.M50SightLEDs.SpriteEmitter0'

     bHidden=True
}
