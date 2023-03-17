//=============================================================================
// HVCMk9RedMuzzleFlash.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class N3XBladeEffect extends BallisticEmitter;

simulated function Destroyed()
{
	if (bDynamicLight)
		bDynamicLight=False;
	super.Destroyed();
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter3
        BeamEndPoints(0)=(offset=(Z=(Min=160.000000,Max=160.000000)))
        DetermineEndPointBy=PTEP_Offset
        BeamTextureUScale=4.000000
        HighFrequencyNoiseRange=(X=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
        HighFrequencyPoints=4
        FadeOut=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.000000,Max=0.500000),Y=(Min=0.000000,Max=0.700000))
        FadeOutStartTime=0.084000
        CoordinateSystem=PTCS_Relative
        MaxParticles=4
      
        StartLocationRange=(X=(Min=-2.000000,Max=2.000000))
        StartSizeRange=(X=(Min=0.000000,Max=4.000000),Y=(Min=0.000000,Max=4.000000),Z=(Min=0.000000,Max=4.000000))
        Texture=Texture'EpicParticles.Beams.HotBolt03aw'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.001000,Max=0.200000)
     End Object
     Emitters(0)=BeamEmitter'BWBP_SKC_Pro.N3XBladeEffect.BeamEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
        FadeOut=True
        FadeIn=True
        UniformSize=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=0.800000))
        Opacity=0.110000
        FadeOutStartTime=0.030000
        FadeInEndTime=0.030000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
      
        StartLocationOffset=(Z=100.000000)
        StartLocationRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-8.000000,Max=8.000000))
        StartSizeRange=(X=(Min=20.000000,Max=120.000000),Y=(Min=20.000000,Max=120.000000),Z=(Min=20.000000,Max=120.000000))
        Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
        LifetimeRange=(Min=0.100000,Max=0.200000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.N3XBladeEffect.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        FadeOut=True
        FadeIn=True
        UniformSize=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Z=(Min=0.800000,Max=0.900000))
        Opacity=0.890000
        FadeOutStartTime=0.058000
        FadeInEndTime=0.029000
        CoordinateSystem=PTCS_Relative
      
        StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.500000,Max=1.500000),Z=(Min=-1.500000,Max=1.500000))
        StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
        Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
        LifetimeRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(X=(Min=80.000000,Max=80.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.N3XBladeEffect.SpriteEmitter10'

     Begin Object Class=SparkEmitter Name=SparkEmitter2
        LineSegmentsRange=(Min=1.000000,Max=1.000000)
        TimeBetweenSegmentsRange=(Min=0.100000,Max=0.300000)
        FadeOut=True
        Acceleration=(Z=-200.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.700000,Max=0.800000),Y=(Min=0.800000))
        FadeOutStartTime=0.216000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
      
        StartLocationOffset=(Z=180.000000)
        StartLocationRange=(Y=(Min=-8.000000,Max=8.000000))
        Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
        LifetimeRange=(Min=0.600000,Max=0.600000)
        StartVelocityRange=(X=(Min=80.000000,Max=300.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(3)=SparkEmitter'BWBP_SKC_Pro.N3XBladeEffect.SparkEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        FadeOut=True
        FadeIn=True
        Backup_Disabled=True
        UniformSize=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000))
        Opacity=0.830000
        FadeOutStartTime=0.058000
        FadeInEndTime=0.029000
        CoordinateSystem=PTCS_Relative
      
        StartLocationOffset=(Y=1.000000,Z=200.000000)
        StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.500000,Max=1.500000),Z=(Min=-1.500000,Max=1.500000))
        StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
        Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
        LifetimeRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(X=(Min=80.000000,Max=80.000000))
     End Object
     Emitters(4)=SpriteEmitter'BWBP_SKC_Pro.N3XBladeEffect.SpriteEmitter4'


     Begin Object Class=SparkEmitter Name=SparkEmitter3
        LineSegmentsRange=(Min=1.000000,Max=1.000000)
        TimeBetweenSegmentsRange=(Min=0.100000,Max=0.300000)
        FadeOut=True
        Acceleration=(Z=-200.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.700000,Max=0.800000),Y=(Min=0.800000))
        FadeOutStartTime=0.216000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
      
        StartLocationRange=(Y=(Min=-8.000000,Max=8.000000))
        Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
        LifetimeRange=(Min=0.600000,Max=0.600000)
        StartVelocityRange=(X=(Min=80.000000,Max=300.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(5)=SparkEmitter'BWBP_SKC_Pro.N3XBladeEffect.SparkEmitter3'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=160
     LightSaturation=64
     LightBrightness=96.000000
     LightRadius=20.000000
     bDynamicLight=True	 
     bNoDelete=False
     bHardAttach=True
}