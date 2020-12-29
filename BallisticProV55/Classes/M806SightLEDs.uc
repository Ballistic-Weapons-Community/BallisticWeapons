//=============================================================================
// M806SightLEDs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class M806SightLEDs extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-31.500000,Z=22.799999)
         StartSizeRange=(X=(Min=1.400000,Max=1.400000),Y=(Min=1.400000,Max=1.400000),Z=(Min=1.400000,Max=1.400000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.M806SightLEDs.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-262.000000,Y=-3.250000,Z=22.500000)
         StartSizeRange=(X=(Min=1.300000,Max=1.300000),Y=(Min=1.300000,Max=1.300000),Z=(Min=1.300000,Max=1.300000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.M806SightLEDs.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-262.000000,Y=3.250000,Z=22.500000)
         StartSizeRange=(X=(Min=1.300000,Max=1.300000),Y=(Min=1.300000,Max=1.300000),Z=(Min=1.300000,Max=1.300000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.M806SightLEDs.SpriteEmitter3'

     bHidden=True
}
