//=============================================================================
// IE_HMCLase.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_HMCLase extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(1)=1
     DisableDGV(3)=1
     bModifyLossRange=False
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.500000))
         FadeOutStartTime=0.025000
         FadeInEndTime=0.006000
         MaxParticles=20
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=18.000000,Max=38.000000),Y=(Min=18.000000,Max=38.000000),Z=(Min=18.000000,Max=38.000000))
         Texture=Texture'BallisticEffects.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.150000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.IE_HMCLase.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.400000,Max=0.400000))
         FadeOutStartTime=0.021000
         CoordinateSystem=PTCS_Relative
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.600000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         Texture=Texture'BallisticEffects.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=150.000000,Max=150.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.IE_HMCLase.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=-600.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.482143,Color=(B=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=0.100000))
         FadeOutStartTime=0.081000
         FadeInEndTime=0.024000
         MaxParticles=30
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.700000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=12.000000),Y=(Min=8.000000,Max=12.000000),Z=(Min=8.000000,Max=12.000000))
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=100.000000,Max=600.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=200.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPRecolorsPro.IE_HMCLase.SpriteEmitter3'

     Begin Object Class=BeamEmitter Name=BeamEmitter3
         BeamDistanceRange=(Min=2.000000,Max=2.000000)
         DetermineEndPointBy=PTEP_Distance
         HighFrequencyNoiseRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         FadeIn=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.200000),Y=(Min=0.500000,Max=0.500000))
         Opacity=0.270000
         FadeOutStartTime=0.201000
         FadeInEndTime=0.201000
         MaxParticles=8
         StartSizeRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         Texture=Texture'BWBP2-FX.Particles.LightningBoltCut2'
         LifetimeRange=(Min=0.201000,Max=0.201000)
         StartVelocityRange=(X=(Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(3)=BeamEmitter'BWBPRecolorsPro.IE_HMCLase.BeamEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.600000
         FadeOutStartTime=1.890000
         FadeInEndTime=0.030000
         MaxParticles=20
         StartLocationOffset=(Z=10.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=0.810000,RelativeSize=1.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(Z=(Min=20.000000,Max=20.000000))
         VelocityLossRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
     End Object
     Emitters(4)=SpriteEmitter'BWBPRecolorsPro.IE_HMCLase.SpriteEmitter5'

     AutoDestroy=True
     bHidden=True
}
