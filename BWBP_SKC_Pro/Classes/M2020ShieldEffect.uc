//=============================================================================
// M2020ShieldEffect.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M2020ShieldEffect extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=255,G=255,R=255))
         ColorScale(3)=(RelativeTime=1.000000)
         ColorMultiplierRange=(X=(Min=0.000000),Y=(Min=0.000000))
         Opacity=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         Texture=Texture'AW-2004Particles.Energy.AirBlast'
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.M2020ShieldEffect.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter16
         UseRevolution=True
         UniformSize=True
         Acceleration=(X=1.000000,Y=50.000000,Z=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.200000),Y=(Min=0.000000,Max=0.200000),Z=(Min=0.000000,Max=0.200000))
         Opacity=0.730000
         CoordinateSystem=PTCS_Relative
         MaxParticles=40
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000))
         SphereRadiusRange=(Min=50.000000,Max=50.000000)
         StartLocationPolarRange=(X=(Max=65536.000000),Y=(Min=16384.000000,Max=16384.000000),Z=(Min=100.000000,Max=100.000000))
         RevolutionsPerSecondRange=(X=(Min=-0.200000,Max=0.200000),Y=(Min=-0.200000,Max=0.200000),Z=(Min=-0.200000,Max=0.200000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=21.000000,Max=21.000000))
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.M2020ShieldEffect.SpriteEmitter16'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.200000),Y=(Min=0.000000,Max=0.208000),Z=(Min=0.000000))
         Opacity=0.500000
         MaxParticles=6
         AutoResetTimeRange=(Min=0.500000,Max=0.500000)
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=3.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=30.000000),Y=(Min=75.000000,Max=75.000000),Z=(Min=75.000000,Max=75.000000))
         Texture=Texture'AW-2004Particles.Energy.ElecPanels'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.M2020ShieldEffect.SpriteEmitter17'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.200000,Max=0.200000))
         Opacity=0.360000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         Texture=Texture'EpicParticles.Flares.FlickerFlare'
         LifetimeRange=(Min=0.010000,Max=0.010000)
     End Object
     Emitters(3)=SpriteEmitter'BWBP_SKC_Pro.M2020ShieldEffect.SpriteEmitter18'

}
