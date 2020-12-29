//=============================================================================
// TraceEmitter_MRTsix.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_MRTsix extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
}

defaultproperties
{
     Begin Object Class=SparkEmitter Name=SparkEmitter1
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBetweenSegmentsRange=(Min=0.010000,Max=0.050000)
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=128,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=64,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.800000))
         FadeOutStartTime=0.110000
         CoordinateSystem=PTCS_Relative
         MaxParticles=12
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=100.000000,Max=4000.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-100.000000,Max=200.000000))
     End Object
     Emitters(0)=SparkEmitter'BallisticProV55.TraceEmitter_MRTsix.SparkEmitter1'

     Begin Object Class=MeshEmitter Name=MeshEmitter15
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.VBlast'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.700000,Max=0.800000),Z=(Min=0.200000,Max=0.500000))
         Opacity=0.320000
         FadeOutStartTime=0.045000
         FadeInEndTime=0.010000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Y=(Min=-0.250000,Max=-0.250000))
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.500000,Max=1.200000),Y=(Min=0.500000,Max=1.200000),Z=(Min=2.000000,Max=5.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
         StartVelocityRange=(X=(Min=100.000000,Max=300.000000))
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.TraceEmitter_MRTsix.MeshEmitter15'

}
