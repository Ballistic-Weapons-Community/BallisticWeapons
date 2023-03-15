//=============================================================================
// LS440MChargeEmitterHeld. Effects for the laser's charged state.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LS440MChargeEmitterHeld extends BallisticEmitter;

defaultproperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        FadeOut=True
        FadeIn=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        UseRandomSubdivision=True
        Acceleration=(Z=2.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.400000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        Opacity=0.350000
        FadeOutStartTime=1.034000
        FadeInEndTime=0.396000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
      
        DetailMode=DM_High
        StartLocationRange=(X=(Min=-15.000000,Max=10.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.300000)
        SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.800000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.200000)
        StartSizeRange=(X=(Min=5.000000,Max=20.000000),Y=(Min=5.000000,Max=20.000000),Z=(Min=5.000000,Max=20.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BWBP_SKC_Tex.BFG.PlasmaSubdivide'
        TextureUSubdivisions=4
        TextureVSubdivisions=2
        LifetimeRange=(Min=1.500000,Max=1.500000)
        StartVelocityRange=(X=(Max=5.000000))
    End Object
    Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.LS440MChargeEmitterHeld.SpriteEmitter7'

    Begin Object Class=SparkEmitter Name=SparkEmitter0
        LineSegmentsRange=(Min=1.000000,Max=1.000000)
        TimeBetweenSegmentsRange=(Min=0.100000,Max=0.100000)
        UseColorScale=True
        FadeOut=True
        Acceleration=(Z=-200.000000)
        ColorScale(0)=(Color=(B=64,G=192,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.764286,Color=(R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.800000))
        FadeOutStartTime=0.530000
        CoordinateSystem=PTCS_Relative
      
        DetailMode=DM_SuperHigh
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=50.000000,Max=1000.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
    End Object
    Emitters(1)=SparkEmitter'BWBP_SKC_Pro.LS440MChargeEmitterHeld.SparkEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=1.000000,Z=0.000000)
        UseColorScale=True
        FadeOut=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        ColorScale(0)=(Color=(R=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(R=255))
        FadeOutStartTime=0.092000
        MaxParticles=4
      
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=5.000000,Max=50.000000))
        InitialParticlesPerSecond=20.000000
        Texture=Texture'AW-2004Particles.Weapons.PlasmaStar2'
        LifetimeRange=(Min=0.300000,Max=0.300000)
    End Object
    Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.LS440MChargeEmitterHeld.SpriteEmitter9'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        UseColorScale=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        Acceleration=(X=15.000000,Y=15.000000,Z=15.000000)
        ColorScale(0)=(Color=(B=128,G=128,R=255))
        ColorScale(1)=(RelativeTime=0.646429,Color=(G=23,R=132))
        ColorScale(2)=(RelativeTime=1.000000)
        ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000))
        MaxParticles=1
      
        StartLocationOffset=(X=16.000000)
        StartLocationRange=(X=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=0.025000))
        SizeScale(0)=(RelativeSize=0.250000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=20.000000,Max=50.000000))
        InitialParticlesPerSecond=900.000000
        Texture=Texture'BWBP_SKC_Tex.BFG.PlasmaSubdivide'
        TextureUSubdivisions=4
        TextureVSubdivisions=2
        LifetimeRange=(Min=1.000000,Max=1.000000)
        WarmupTicksPerSecond=1.000000
        RelativeWarmupTime=0.200000
    End Object
    Emitters(3)=SpriteEmitter'BWBP_SKC_Pro.LS440MChargeEmitterHeld.SpriteEmitter10'



}
