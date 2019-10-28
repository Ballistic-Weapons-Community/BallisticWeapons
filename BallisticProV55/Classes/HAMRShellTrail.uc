//=============================================================================
// HAMRShellTrail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class HAMRShellTrail extends DGVEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BallisticHardware2.M806.PistolMuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.059000
         FadeInEndTime=0.012000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartSpinRange=(Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.060000,Max=0.080000),Y=(Min=0.040000,Max=0.040000),Z=(Min=0.040000,Max=0.040000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.HAMRShellTrail.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=25.000000)
         ColorScale(0)=(Color=(B=128,G=128,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64,A=255))
         Opacity=0.750000
         FadeOutStartTime=0.920000
         FadeInEndTime=0.560000
         MaxParticles=250
         StartLocationOffset=(X=10.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.NewSmoke1f'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=15.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.HAMRShellTrail.SpriteEmitter2'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=350
         DistanceThreshold=30.000000
         PointLifeTime=1.500000
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(Y=(Min=0.750000),Z=(Min=0.500000,Max=0.600000))
         MaxParticles=1
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=99.000000,Max=99.000000)
     End Object
     Emitters(2)=TrailEmitter'BallisticProV55.HAMRShellTrail.TrailEmitter1'

     AutoDestroy=True
     bHardAttach=True
}
