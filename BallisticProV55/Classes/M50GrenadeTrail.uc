//=============================================================================
// M50GrenadeTrail.
//
// Trail for M900 grenades
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M50GrenadeTrail extends DGVEmitter;

defaultproperties
{
     bAutoAlignVelocity=True
     Begin Object Class=SpriteEmitter Name=SpriteEmitter45
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.350000
         FadeOutStartTime=0.660000
         FadeInEndTime=0.090000
         MaxParticles=90
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=2.000000,Max=3.000000))
         DrawStyle=PTDS_Darken
         Texture=Texture'BallisticEffects.Particles.Smoke5'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.500000)
         StartVelocityRange=(X=(Min=-8.000000,Max=-5.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.M50GrenadeTrail.SpriteEmitter45'

     bHardAttach=True
}
