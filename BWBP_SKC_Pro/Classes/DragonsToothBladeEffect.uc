//=============================================================================
// HVCMk9RedMuzzleFlash.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DragonsToothBladeEffect extends BallisticEmitter;

simulated function Destroyed()
{
	if (bDynamicLight)
		bDynamicLight=False;
	super.Destroyed();
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter3
         BeamEndPoints(0)=(offset=(X=(Min=160.000000,Max=160.000000)))
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=0.200000
         LowFrequencyNoiseRange=(X=(Min=-65524.000000,Max=-65509.000000))
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Max=3525.000000),Z=(Min=-5.000000,Max=5.000000))
         HighFrequencyPoints=2
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.500000),Y=(Min=0.000000,Max=0.700000))
         FadeOutStartTime=0.330562
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         StartSizeRange=(X=(Min=0.000000,Max=13.799000),Y=(Min=0.000000,Max=1.799000),Z=(Min=0.000000,Max=1.799000))
         InitialParticlesPerSecond=50.000000
         Texture=Texture'BWBP_SKC_Tex.DragonToothSword.DTS-Glow'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=BeamEmitter'BWBP_SKC_Pro.DragonsToothBladeEffect.BeamEmitter3'

     AutoDestroy=True
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=160
     LightSaturation=64
     LightBrightness=224.000000
     LightRadius=12.000000
     bDynamicLight=True
     bHardAttach=True
}
