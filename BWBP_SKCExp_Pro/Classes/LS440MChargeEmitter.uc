//=============================================================================
// LS440MChargeEmitter. Effects for the laser's charging state.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LS440MChargeEmitter extends BallisticEmitter;

defaultproperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
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
    Emitters(0)=SpriteEmitter'BWBP_SKCExp_Pro.LS440MChargeEmitter.SpriteEmitter4'

    Begin Object Class=SparkEmitter Name=SparkEmitter2
        LineSegmentsRange=(Min=1.000000,Max=1.000000)
        TimeBetweenSegmentsRange=(Min=0.100000,Max=0.100000)
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        AutomaticInitialSpawning=False
        Acceleration=(Z=-200.000000)
        ColorScale(0)=(Color=(B=64,G=192,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.764286,Color=(R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.800000))
        FadeOutStartTime=0.530000
        CoordinateSystem=PTCS_Relative
        MaxParticles=25
      
        DetailMode=DM_SuperHigh
        InitialParticlesPerSecond=50.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=50.000000,Max=1000.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
        StartVelocityRadialRange=(Max=1.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(1)=SparkEmitter'BWBP_SKCExp_Pro.LS440MChargeEmitter.SparkEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=1.000000,Z=0.000000)
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=128,G=128,R=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=255))
        MaxParticles=2
      
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=50.000000))
        InitialParticlesPerSecond=20.000000
        Texture=Texture'AW-2004Particles.Weapons.PlasmaStar2'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        InitialDelayRange=(Min=0.500000,Max=0.500000)
    End Object
    Emitters(2)=SpriteEmitter'BWBP_SKCExp_Pro.LS440MChargeEmitter.SpriteEmitter6'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        UseColorScale=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        Acceleration=(X=15.000000,Y=15.000000,Z=15.000000)
        ColorScale(0)=(Color=(B=128,G=128,R=255))
        ColorScale(1)=(RelativeTime=0.646429,Color=(G=23,R=132))
        ColorScale(2)=(RelativeTime=1.000000)
        ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000))
        MaxParticles=8
      
        StartLocationOffset=(X=16.000000)
        StartLocationRange=(X=(Max=64.000000),Z=(Max=2.000000))
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
        StartVelocityRange=(X=(Min=-15.000000,Max=15.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=15.000000))
        WarmupTicksPerSecond=1.000000
        RelativeWarmupTime=0.200000
    End Object
    Emitters(3)=SpriteEmitter'BWBP_SKCExp_Pro.LS440MChargeEmitter.SpriteEmitter7'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter8
        UseColorScale=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=32,G=32,R=255))
        ColorScale(1)=(RelativeTime=0.100000,Color=(B=32,G=32,R=255))
        ColorScale(2)=(RelativeTime=0.800000,Color=(B=64,G=64,R=255))
        ColorScale(3)=(RelativeTime=1.000000)
        ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000))
        MaxParticles=3
      
        StartLocationOffset=(X=10.000000)
        StartLocationRange=(X=(Max=20.000000))
        UseRotationFrom=PTRS_Actor
        SizeScale(0)=(RelativeSize=0.100000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=40.000000,Max=60.000000))
        InitialParticlesPerSecond=2000.000000
        Texture=Texture'BWBP_SKC_Tex.BFG.PlasmaSubdivide'
        TextureUSubdivisions=4
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.200000)
    End Object
    Emitters(4)=SpriteEmitter'BWBP_SKCExp_Pro.LS440MChargeEmitter.SpriteEmitter8'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=1.000000,Z=0.000000)
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=128,G=128,R=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=255))
        Opacity=0.280000
        MaxParticles=2
      
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
        SizeScale(2)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=50.000000))
        InitialParticlesPerSecond=20.000000
        Texture=Texture'BWBP_SKC_Tex.A48.A48MuzzleFlash'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        SubdivisionStart=1
        SubdivisionEnd=1
        LifetimeRange=(Min=0.501000,Max=0.501000)
    End Object
    Emitters(5)=SpriteEmitter'BWBP_SKCExp_Pro.LS440MChargeEmitter.SpriteEmitter9'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=1.000000,Z=0.000000)
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=128,G=128,R=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=255))
        MaxParticles=2
      
        UseRotationFrom=PTRS_Actor
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=50.000000))
        InitialParticlesPerSecond=20.000000
        Texture=Texture'BWBP_SKC_Tex.A73b.FlareB1'
        TextureUSubdivisions=1
        TextureVSubdivisions=1
        LifetimeRange=(Min=0.501000,Max=0.501000)
    End Object
    Emitters(6)=SpriteEmitter'BWBP_SKCExp_Pro.LS440MChargeEmitter.SpriteEmitter10'


     bNoDelete=False
     bHardAttach=True

}
