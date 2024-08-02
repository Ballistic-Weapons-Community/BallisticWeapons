//===============================
//Butts
//
//================================
class IE_WillyPete extends DGVEmitterOversize
	placeable;

simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_SuperHigh)
		Emitters[2].Disabled=true;
	if (Level.DetailMode < DM_High)
		Emitters[1].Disabled=true;
	Super.PreBeginPlay();
}

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	bDynamicLight = true;
	SetTimer(0.2, false);
}

simulated event Timer()
{
	Super.Timer();
	bDynamicLight = false;
}


defaultproperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter79
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=50.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=1.200000
        FadeInEndTime=0.680000
        MaxParticles=15
      
        DetailMode=DM_High
        StartLocationRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000))
        SpinsPerSecondRange=(X=(Max=0.100000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.200000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
        InitialParticlesPerSecond=20000.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'BW_Core_WeaponTex.Particles.Smoke5'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=6.000000,Max=7.000000)
        StartVelocityRange=(X=(Min=-125.000000,Max=125.000000),Y=(Min=-125.000000,Max=125.000000),Z=(Min=200.000000,Max=500.000000))
        VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=2.000000,Max=3.000000))
    End Object
    Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.IE_WillyPete.SpriteEmitter79'

    Begin Object Class=TrailEmitter Name=TrailEmitter2
        TrailShadeType=PTTST_PointLife
        MaxPointsPerTrail=100
        DistanceThreshold=10.000000
        PointLifeTime=3.500000
        FadeOut=True
        RespawnDeadParticles=False
        AutomaticInitialSpawning=False
        Acceleration=(Z=-450.000000)
        FadeOutStartTime=1.000000
        FadeInEndTime=1.000000
        MaxParticles=15
      
        AddLocationFromOtherEmitter=3
        StartSizeRange=(X=(Min=8.000000,Max=9.000000))
        InitialParticlesPerSecond=50000.000000
        DrawStyle=PTDS_Darken
        Texture=Texture'BW_Core_WeaponTex.Particles.Smoke2'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=3.500000,Max=3.500000)
        VelocityLossRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000))
        AddVelocityFromOtherEmitter=3
    End Object
    Emitters(1)=TrailEmitter'BWBP_SKC_Pro.IE_WillyPete.TrailEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter82
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        Acceleration=(Z=-400.000000)
        ExtentMultiplier=(X=0.700000,Y=0.700000,Z=0.700000)
        DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.600000,Max=0.800000),Z=(Min=0.400000,Max=0.600000))
        FadeOutStartTime=1.000000
        MaxParticles=75
      
        DetailMode=DM_SuperHigh
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=10.000000,Max=20.000000)
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=5.000000,Max=8.000000))
        InitialParticlesPerSecond=1000.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        SubdivisionEnd=15
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.500000,Max=1.500000)
        StartVelocityRadialRange=(Min=-500.000000,Max=-800.000000)
        VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=4.000000,Max=4.000000))
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.IE_WillyPete.SpriteEmitter82'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter83
        UseCollision=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        Acceleration=(Z=-450.000000)
        DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.500000,Max=0.750000),Z=(Min=0.250000,Max=0.550000))
        FadeOutStartTime=2.280000
        FadeInEndTime=0.090000
        MaxParticles=50
      
        AlphaRef=200
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
        InitialParticlesPerSecond=99999.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
        TextureUSubdivisions=4
        TextureVSubdivisions=2
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=2.500000,Max=3.000000)
        StartVelocityRange=(X=(Min=-650.000000,Max=650.000000),Y=(Min=-650.000000,Max=650.000000),Z=(Min=-100.000000,Max=400.000000))
        VelocityLossRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000))
    End Object
    Emitters(3)=SpriteEmitter'BWBP_SKC_Pro.IE_WillyPete.SpriteEmitter83'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter94
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=100.000000)
        ColorScale(0)=(Color=(B=128,G=192,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(G=64,R=192,A=255))
        FadeOutStartTime=0.472000
        MaxParticles=1100
      
        AddLocationFromOtherEmitter=3
        SpinsPerSecondRange=(X=(Max=0.500000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.750000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
        InitialParticlesPerSecond=500.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.500000,Max=0.800000)
        StartVelocityRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
        AddVelocityFromOtherEmitter=3
        AddVelocityMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
    End Object
    Emitters(4)=SpriteEmitter'BWBP_SKC_Pro.IE_WillyPete.SpriteEmitter94'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter95
        FadeOut=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.600000,Max=0.800000),Z=(Min=0.500000,Max=0.600000))
        MaxParticles=1
      
        DetailMode=DM_High
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=300.000000,Max=300.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.Shockwave'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.700000,Max=0.700000)
    End Object
    Emitters(5)=SpriteEmitter'BWBP_SKC_Pro.IE_WillyPete.SpriteEmitter95'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter96
        UseDirectionAs=PTDU_Normal
        FadeOut=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.600000,Max=0.800000),Z=(Min=0.500000,Max=0.600000))
        MaxParticles=1
      
        DetailMode=DM_SuperHigh
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=300.000000,Max=300.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.Shockwave'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.700000,Max=0.700000)
    End Object
    Emitters(6)=SpriteEmitter'BWBP_SKC_Pro.IE_WillyPete.SpriteEmitter96'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter98
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255))
        ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Max=1.500000))
        FadeOutStartTime=0.200000
        MaxParticles=2
      
        AlphaRef=128
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.500000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.100000)
        StartSizeRange=(X=(Min=200.000000,Max=300.000000))
        InitialParticlesPerSecond=20.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.800000,Max=0.800000)
        StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000))
    End Object
    Emitters(7)=SpriteEmitter'BWBP_SKC_Pro.IE_WillyPete.SpriteEmitter98'

 /*   Begin Object Class=SpriteEmitter Name=SpriteEmitter99
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.230000
        FadeInEndTime=0.050000
        MaxParticles=8
      
        CoordinateSystem=PTCS_Relative
        StartSpinRange=(X=(Min=0.300000,Max=0.700000))
        SizeScale(0)=(RelativeTime=0.140000,RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=0.550000,RelativeSize=4.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=4.500000)
        InitialParticlesPerSecond=5000.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'AW-2004Particles.Dirt.BlastSpray2a'
        LifetimeRange=(Min=1.500000,Max=1.500000)
    End Object
    Emitters(8)=SpriteEmitter'BWBP_SKC_Pro.IE_WillyPete.SpriteEmitter99' */

    Begin Object Class=SpriteEmitter Name=SpriteEmitter99
    UseDirectionAs=PTDU_Up
    ProjectionNormal=(Y=-2.000000)
    FadeOut=True
    FadeIn=True
    RespawnDeadParticles=False
    SpinParticles=True
    UseSizeScale=True
    UseRegularSizeScale=False
    UniformSize=True
    AutomaticInitialSpawning=False
    ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
    ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
    FadeOutStartTime=0.230000
    FadeInEndTime=0.050000
    MaxParticles=8
    Name="SpriteEmitter7"
    StartSpinRange=(X=(Min=-0.300000,Max=0.300000))
    SizeScale(0)=(RelativeTime=0.140000,RelativeSize=3.000000)
    SizeScale(1)=(RelativeTime=0.550000,RelativeSize=4.000000)
    SizeScale(2)=(RelativeTime=1.000000,RelativeSize=4.500000)
    InitialParticlesPerSecond=5000.000000
    DrawStyle=PTDS_AlphaBlend
    Texture=Texture'AW-2004Particles.Dirt.BlastSpray2a'
    LifetimeRange=(Min=1.500000,Max=1.500000)
    StartVelocityRange=(X=(Min=1.000000,Max=5.000000))
    End Object
    Emitters(8)=SpriteEmitter'BWBP_SKC_Pro.IE_WillyPete.SpriteEmitter99'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter100
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.600000
        FadeOutStartTime=5.320000
        FadeInEndTime=0.560000
      
        StartLocationRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Max=150.000000))
        SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeTime=0.170000,RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=0.500000,RelativeSize=3.400000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.500000)
        SizeScale(3)=(RelativeTime=0.310000,RelativeSize=3.200000)
        SizeScale(4)=(RelativeTime=0.250000,RelativeSize=2.700000)
        StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
        InitialParticlesPerSecond=5000.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'BW_Core_WeaponTex.Particles.Smoke3'
        LifetimeRange=(Min=6.000000,Max=7.000000)
        StartVelocityRange=(Z=(Min=20.000000,Max=20.000000))
    End Object
    Emitters(9)=SpriteEmitter'BWBP_SKC_Pro.IE_WillyPete.SpriteEmitter100'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter101
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.100000
        MaxParticles=1
      
        SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        StartSizeRange=(X=(Min=400.000000,Max=400.000000),Y=(Min=400.000000,Max=400.000000),Z=(Min=400.000000,Max=400.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'BW_Core_WeaponTex.Specularity.BWSpecularity'
        LifetimeRange=(Min=0.200000,Max=0.200000)
    End Object
    Emitters(10)=SpriteEmitter'BWBP_SKC_Pro.IE_WillyPete.SpriteEmitter101'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter102
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.600000
        FadeOutStartTime=0.100000
        MaxParticles=2
      
        SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeTime=1.000000,RelativeSize=6.000000)
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'ONSBPTextures.fX.ExploTrans'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.900000,Max=0.900000)
    End Object
    Emitters(11)=SpriteEmitter'BWBP_SKC_Pro.IE_WillyPete.SpriteEmitter102'

   
   

     AutoDestroy=True
     bDirectional=true
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
     bNoDelete=False
}