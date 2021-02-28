//=============================================================================
// SK410FireTrail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SK410FireTrail extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter46
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.600000,Max=0.800000),Z=(Min=0.400000,Max=0.600000))
         MaxParticles=50
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=0.500000,Max=1.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke5'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.SK410FireTrail.SpriteEmitter46'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter47
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.600000,Max=0.800000),Z=(Min=0.400000,Max=0.800000))
         FadeOutFactor=(X=0.500000,Y=0.500000,Z=0.500000)
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=0.500000,Max=1.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.SK410FireTrail.SpriteEmitter47'

     Physics=PHYS_Trailer
     bHardAttach=True
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     bCollideWorld=True
     Mass=30.000000
}
