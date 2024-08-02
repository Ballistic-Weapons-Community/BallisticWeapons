//=============================================================================
// TraceEmitter_XM20LaserLaser. Effects for the laser carbine.
//
// by SK
// based on code by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_XM20Laser extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
	Power = Power/255;
	BeamEmitter(Emitters[0]).BeamDistanceRange.Min = FMax(0, Distance-100);
	BeamEmitter(Emitters[0]).BeamDistanceRange.Max = FMax(0, Distance-100);
//	Emitters[0].Opacity = Emitters[0].default.Opacity * Power;
//	Emitters[1].Opacity = Emitters[1].default.Opacity * Power;
//	Emitters[3].Opacity = Emitters[3].default.Opacity * Power;
	BeamEmitter(Emitters[1]).BeamDistanceRange.Min = Distance;
	BeamEmitter(Emitters[1]).BeamDistanceRange.Max = Distance;
	BeamEmitter(Emitters[4]).BeamDistanceRange.Min = Distance;
	BeamEmitter(Emitters[4]).BeamDistanceRange.Max = Distance;
	Emitters[5].LifeTimeRange.Min = Distance / 8000;
	Emitters[5].LifeTimeRange.Max = Distance / 8000;
}

defaultproperties
{
    Begin Object Class=BeamEmitter Name=BeamEmitter0
        BeamDistanceRange=(Min=5000.000000,Max=5000.000000)
        DetermineEndPointBy=PTEP_Distance
        BeamTextureUScale=8.000000
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
        FadeOutStartTime=0.025000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
      
        DetailMode=DM_SuperHigh
        StartLocationOffset=(X=700.000000)
        SizeScale(1)=(RelativeTime=0.680000,RelativeSize=0.300000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BW_Core_WeaponTex.GunFire.RailCoreWave'
        LifetimeRange=(Min=0.350000,Max=0.350000)
        StartVelocityRange=(X=(Min=0.010000,Max=0.010000))
    End Object
     Emitters(0)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser.BeamEmitter0'

    Begin Object Class=BeamEmitter Name=BeamEmitter1
        BeamDistanceRange=(Min=5000.000000,Max=5000.000000)
        DetermineEndPointBy=PTEP_Distance
        BeamTextureUScale=8.000000
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=3,G=32,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.275000,Color=(B=9,G=137,R=232,A=255))
        ColorScale(2)=(RelativeTime=0.521429,Color=(R=255,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=27,G=24,R=122,A=255))
        ColorMultiplierRange=(X=(Min=0.800000,Max=0.900000),Y=(Min=0.900000))
        FadeOutStartTime=0.192000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
      
    	StartLocationOffset=(X=-30.000000)
        SizeScale(0)=(RelativeSize=0.200000)
        SizeScale(1)=(RelativeTime=0.280000,RelativeSize=0.800000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BWBP_SKC_Tex.BeamCannon.HMCSmokeCore2'
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
    End Object
     Emitters(1)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser.BeamEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
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

    	StartLocationOffset=(X=-30.000000)      
        DetailMode=DM_High
        StartLocationRange=(X=(Min=-15.000000,Max=10.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.300000)
        SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.400000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.600000)
        StartSizeRange=(X=(Min=5.000000,Max=20.000000),Y=(Min=5.000000,Max=20.000000),Z=(Min=5.000000,Max=20.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BWBP_SKC_Tex.BFG.PlasmaSubdivide'
        TextureUSubdivisions=4
        TextureVSubdivisions=2
        LifetimeRange=(Min=1.500000,Max=1.500000)
        StartVelocityRange=(X=(Max=5.000000))
    End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser.SpriteEmitter2'

    Begin Object Class=BeamEmitter Name=BeamEmitter3
        BeamDistanceRange=(Min=100.000000,Max=100.000000)
        DetermineEndPointBy=PTEP_Distance
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=129,G=128,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        FadeOutStartTime=0.025000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
    	StartLocationOffset=(X=-30.000000)
      
        DetailMode=DM_SuperHigh
        SizeScale(1)=(RelativeTime=0.680000,RelativeSize=0.300000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BW_Core_WeaponTex.GunFire.RailCoreWaveCap'
        LifetimeRange=(Min=0.350000,Max=0.350000)
        StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
    End Object
     Emitters(3)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser.BeamEmitter3'

    Begin Object Class=BeamEmitter Name=BeamEmitter4
        BeamDistanceRange=(Min=5000.000000,Max=5000.000000)
        DetermineEndPointBy=PTEP_Distance
        BeamTextureUScale=16.000000
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=64,G=192,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.114286,Color=(R=255,A=255))
        ColorScale(2)=(RelativeTime=0.257143,Color=(B=4,G=99,R=227,A=255))
        ColorScale(3)=(RelativeTime=0.889286,Color=(B=78,G=17,R=238,A=255))
        ColorScale(4)=(RelativeTime=1.000000,Color=(R=200,A=255))
        ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.800000,Max=0.900000),Y=(Min=0.900000))
        FadeOutStartTime=0.180000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
    	StartLocationOffset=(X=-30.000000)
      
        SizeScale(0)=(RelativeSize=0.300000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
        InitialParticlesPerSecond=50000.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'BWBP_SKC_Tex.BeamCannon.HMCSmokeCore2'
        LifetimeRange=(Min=0.300000,Max=0.400000)
        StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
    End Object
     Emitters(4)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser.BeamEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000))
        Opacity=0.730000
        FadeOutStartTime=0.525000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
    	StartLocationOffset=(X=-30.000000)
      
        SpinsPerSecondRange=(X=(Max=4.000000))
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=1.000000,Max=1.500000),Y=(Min=1.000000,Max=1.500000),Z=(Min=1.000000,Max=1.500000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'BWBP_SKC_Tex.A48.A48MuzzleFlash'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        SubdivisionStart=1
        SubdivisionEnd=1
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.325000,Max=0.325000)
        StartVelocityRange=(X=(Min=-40.000000,Max=40.000000),Y=(Min=-40.000000,Max=40.000000),Z=(Min=-40.000000,Max=40.000000))
    End Object
     Emitters(5)=SpriteEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser.SpriteEmitter5'

}
