//=============================================================================
// Supercharger_SparkTrail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_SparkTrail extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        FadeOut=True
        FadeIn=True
        SpinParticles=True
        UniformSize=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000))
        FadeOutStartTime=0.320000
        FadeInEndTime=0.070000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
      
        SpinsPerSecondRange=(X=(Max=0.250000))
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
        Texture=Texture'XEffects.Skins.LBBT'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.500000,Max=0.500000)
    End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.Supercharger_SparkTrail.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        FadeOut=True
        FadeIn=True
        SpinParticles=True
        UniformSize=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.400000),Z=(Min=0.400000))
        Opacity=0.440000
        FadeOutStartTime=0.390000
        FadeInEndTime=0.080000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
      
        SpinsPerSecondRange=(X=(Max=0.050000))
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
        Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.500000,Max=0.500000)
    End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.Supercharger_SparkTrail.SpriteEmitter6'


     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=255,G=64,A=255))
        ColorScale(1)=(RelativeTime=0.360714,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=0.600000,Color=(B=255,G=255,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.800000,Max=0.800000))
        FadeOutStartTime=0.450000
        FadeInEndTime=0.105000
      
        StartLocationOffset=(X=-10.000000)
        SpinsPerSecondRange=(X=(Max=0.200000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.250000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
        Texture=Texture'XEffects.LightningChargeT'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.500000,Max=1.500000)
        StartVelocityRange=(X=(Min=-25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=-50.000000,Max=10.000000))
    End Object
     Emitters(5)=SpriteEmitter'BWBP_SKC_Pro.Supercharger_SparkTrail.SpriteEmitter2'

     bNoDelete=False
}
