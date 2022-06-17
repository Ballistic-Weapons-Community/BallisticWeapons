//=============================================================================
// A73BPOWAHTrail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_PhotonTrail extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
      UseColorScale=True
        UniformSize=True
        ColorScale(0)=(Color=(B=128,R=255))
        ColorScale(1)=(RelativeTime=0.300000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=0.657143,Color=(G=255,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=64,R=255))
        ColorMultiplierRange=(Y=(Min=0.000000,Max=0.500000))
        Opacity=0.700000
        FadeOutStartTime=0.200000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
      
        StartSizeRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BWBP_SKC_Tex.LS14.EMPProj'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.150000,Max=0.200000)
    End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.Supercharger_PhotonTrail.SpriteEmitter1'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
        BeamDistanceRange=(Min=150.000000,Max=150.000000)
        DetermineEndPointBy=PTEP_Distance
        LowFrequencyNoiseRange=(Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
        HighFrequencyNoiseRange=(Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
        UseColorScale=True
        FadeOut=True
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=64,R=64,A=64))
        ColorScale(1)=(RelativeTime=0.300000,Color=(B=255,G=255,R=255,A=64))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=64))
        ColorMultiplierRange=(X=(Min=0.000000,Max=0.100000),Y=(Min=0.000000,Max=0.500000))
        FadeOutStartTime=0.416000
        CoordinateSystem=PTCS_Relative
        MaxParticles=5
      
        DetailMode=DM_High
        SizeScale(0)=(RelativeSize=1.500000)
        SizeScale(1)=(RelativeTime=0.550000,RelativeSize=2.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        InitialParticlesPerSecond=10.000000
        Texture=Texture'EpicParticles.Beams.HotBolt04aw'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.200000,Max=0.300000)
        StartVelocityRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
    End Object
     Emitters(1)=BeamEmitter'BWBP_SKC_Pro.Supercharger_PhotonTrail.BeamEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseColorScale=True
        UniformSize=True
        ColorScale(0)=(Color=(B=128,R=255))
        ColorScale(1)=(RelativeTime=0.300000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=0.657143,Color=(G=255,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=64,R=255))
        ColorMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.000000,Max=0.500000),Z=(Min=0.000000,Max=0.500000))
        Opacity=0.700000
        FadeOutStartTime=0.200000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
      
        StartLocationOffset=(X=20.000000)
        StartSizeRange=(X=(Min=15.000000,Max=30.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BWBP_SKC_Tex.LS14.EMPProj'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.150000,Max=0.200000)
    End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.Supercharger_PhotonTrail.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=64,R=255))
        ColorMultiplierRange=(X=(Min=0.100000,Max=0.410000),Y=(Min=0.000000))
        Opacity=0.700000
        FadeOutStartTime=0.400000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
      
        SizeScale(0)=(RelativeTime=0.500000,RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BallisticEffects.GunFire.A42Projectile2'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.000000,Max=1.000000)
    End Object
     Emitters(3)=SpriteEmitter'BWBP_SKC_Pro.Supercharger_PhotonTrail.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        UseCollision=True
        UseColorScale=True
        FadeOut=True
        UniformSize=True
        TriggerDisabled=False
        Acceleration=(Z=-600.000000)
        DampingFactorRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
        ColorScale(0)=(Color=(B=255,G=255,R=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=64,R=64))
        FadeOutStartTime=1.000000
        MaxParticles=5
      
        DetailMode=DM_High
        StartLocationRange=(Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
        StartSizeRange=(X=(Min=12.000000,Max=20.000000))
        Texture=Texture'BallisticEffects.Particles.FlareA1'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=2.000000,Max=2.000000)
        SpawnOnTriggerRange=(Min=2.000000,Max=5.000000)
        SpawnOnTriggerPPS=500000.000000
        StartVelocityRange=(X=(Min=-400.000000,Max=400.000000),Y=(Min=-800.000000,Max=400.000000),Z=(Min=-400.000000,Max=400.000000))
    End Object
     Emitters(4)=SpriteEmitter'BWBP_SKC_Pro.Supercharger_PhotonTrail.SpriteEmitter4'

     bNoDelete=False
}
