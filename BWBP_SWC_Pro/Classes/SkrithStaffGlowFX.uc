//=============================================================================
// SkrithStaffGlowFX.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SkrithStaffGlowFX extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[0].ZTest = true;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=8.000000,Max=0.800000),Y=(Min=2.000000,Max=0.400000),Z=(Min=0.000000,Max=0.200000))
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=22.500000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=5.000000,Max=10.000000),Z=(Min=5.000000,Max=10.000000))
         Texture=Texture'BW_Core_WeaponTex.A73OrangeLayout.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SWC_Pro.SkrithStaffGlowFX.SpriteEmitter2'

     bNoDelete=False
}
