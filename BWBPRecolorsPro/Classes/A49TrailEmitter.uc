//=============================================================================
// A49TrailEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class A49TrailEmitter extends BallisticEmitter;
/*
    Begin Object Class=MeshEmitter Name=MeshEmitter0
        StaticMesh=StaticMesh'BallisticHardware2.A42.A42MuzzleFlash'
        UseMeshBlendMode=False
        RenderTwoSided=True
        UseParticleColor=True
        UseColorScale=True
        FadeOut=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.235714,Color=(B=255,G=192,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,A=255))
        FadeOutStartTime=0.032500
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Start"
        SpinsPerSecondRange=(Z=(Min=2.000000,Max=2.000000))
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=0.200000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
        InitialParticlesPerSecond=5000.000000
        LifetimeRange=(Min=0.250000,Max=0.250000)
        StartVelocityRange=(X=(Min=-5000.000000,Max=-5000.000000))
        SecondsBeforeInactive=0.000000
    End Object
    Emitters(2)=MeshEmitter'A42TrailEmitter.MeshEmitter0'
*/

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         UniformSize=True
         ColorScale(0)=(Color=(B=192,G=128,R=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=255,G=192,R=160,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=192,G=255,R=128))
         ColorMultiplierRange=(X=(Min=0.600000),Y=(Min=0.800000),Z=(Min=0.600000))
         Opacity=0.550000
         FadeOutStartTime=0.300000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartLocationOffset=(X=50.000000)
         StartSizeRange=(X=(Min=30.000000,Max=40.000000))
         InitialParticlesPerSecond=40000.000000
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.300000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.A49TrailEmitter.SpriteEmitter0'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=130
         DistanceThreshold=100.000000
         UseCrossedSheets=True
         PointLifeTime=0.750000
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.600000),Y=(Min=0.500000,Max=0.800000),Z=(Min=0.600000))
         Opacity=0.700000
         MaxParticles=1
         StartSizeRange=(X=(Min=2.500000,Max=3.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(1)=TrailEmitter'BWBPRecolorsPro.A49TrailEmitter.TrailEmitter0'

}
