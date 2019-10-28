//=============================================================================
// CYLOMk2RedGlow.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOMk2RedGlow extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[0].ZTest = true;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.607143,Color=(B=64,G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=64,G=128,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.830000,Max=0.830000),Y=(Min=0.630000,Max=0.630000),Z=(Min=0.430000,Max=0.630000))
         FadeOutStartTime=0.700000
         FadeInEndTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=7
         DetailMode=DM_High
         StartLocationOffset=(X=-20.000000)
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=60.000000,Max=60.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.CYLOMk2RedGlow.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter39
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.350000,Max=0.350000),Y=(Min=0.350000,Max=0.350000),Z=(Min=0.350000,Max=0.350000))
         Opacity=0.400000
         FadeOutStartTime=0.520000
         FadeInEndTime=0.220000
         MaxParticles=20
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=-60.000000,Max=20.000000),Y=(Min=-12.000000,Max=12.000000))
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.700000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=3.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.SmokeWisp-Alpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=30.000000,Max=60.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.CYLOMk2RedGlow.SpriteEmitter39'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=180,R=160,A=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=91,G=91,R=91,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.210000
         FadeOutStartTime=1.020000
         FadeInEndTime=0.560000
         MaxParticles=20
         StartLocationRange=(X=(Min=-30.000000))
         SpinsPerSecondRange=(X=(Max=0.150000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=3.000000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=5.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=8.000000)
         StartSizeRange=(X=(Min=12.000000,Max=16.000000),Y=(Min=12.000000,Max=16.000000),Z=(Min=12.000000,Max=16.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.SmokeWisp-Alpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=50.000000,Max=65.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPRecolorsPro.CYLOMk2RedGlow.SpriteEmitter26'

}
