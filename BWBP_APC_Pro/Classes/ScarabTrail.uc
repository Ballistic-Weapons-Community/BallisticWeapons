//=============================================================================
// ScarabTrail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ScarabTrail extends DGVEmitter;

defaultproperties
{
     bAutoAlignVelocity=True
     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=30.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.830000
         FadeOutStartTime=0.120000
         FadeInEndTime=0.120000
         MaxParticles=50
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=15.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke7c'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Max=10.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_APC_Pro.ScarabTrail.SpriteEmitter14'

     LifeSpan=5.000000
     bHardAttach=True
}
