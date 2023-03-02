//=============================================================================
// The Red Lights for the KHMKII.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//=============================================================================
class KHMKIILightRed extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.050000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=0.100000,RelativeSize=1.000000)
         SizeScale(3)=(RelativeTime=0.450000,RelativeSize=2.000000)
         SizeScale(4)=(RelativeTime=0.500000,RelativeSize=1.500000)
         SizeScale(5)=(RelativeTime=0.550000,RelativeSize=2.000000)
         SizeScale(6)=(RelativeTime=0.900000,RelativeSize=1.000000)
         SizeScale(7)=(RelativeTime=0.950000,RelativeSize=1.500000)
         SizeScale(8)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=1.000000
         Texture=Texture'EpicParticles.Flares.FlickerFlare'
         LifetimeRange=(Min=1.500000,Max=1.500000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_VPC_Pro.KHMKIILightRed.SpriteEmitter0'

     AutoDestroy=True
     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
}
