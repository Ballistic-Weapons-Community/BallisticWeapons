//=============================================================================
// SMATRocketTrail.
//
// by SK, based on DC
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SMATRocketTrail extends DGVEmitter;

/*     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=1000
         DistanceThreshold=20.000000
         PointLifeTime=3.500000
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=10.000000)
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.900000),Y=(Min=0.800000,Max=0.900000),Z=(Min=0.825000,Max=0.950000))
         FadeOutStartTime=0.900000
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=20.000000,Max=25.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.500000,Max=3.500000)
     End Object
     Emitters(4)=TrailEmitter'BWBPRecolors5Main.SMATRocketTrail.TrailEmitter0'
*/

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(2)=1
     DisableDGV(4)=1
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.M806.PistolMuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         SpinParticles=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutFactor=(X=0.500000,Y=0.500000,Z=0.500000)
         FadeOutStartTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinCCWorCW=(Z=1.000000)
         SpinsPerSecondRange=(Z=(Min=1.000000,Max=3.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=0.200000,Max=0.300000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.700000)
     End Object
     Emitters(0)=MeshEmitter'BWBP_SKCExp_Pro.SMATRocketTrail.MeshEmitter0'

     Begin Object Class=SparkEmitter Name=SparkEmitter0
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBeforeVisibleRange=(Min=5.000000,Max=5.000000)
         TimeBetweenSegmentsRange=(Min=0.100000,Max=0.200000)
         UseColorScale=True
         FadeOut=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=192,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255))
         FadeOutFactor=(X=0.500000,Y=0.500000,Z=0.500000)
         FadeOutStartTime=0.300000
         MaxParticles=200
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-20.000000)
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=1.000000)
         StartVelocityRange=(X=(Min=-100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(1)=SparkEmitter'BWBP_SKCExp_Pro.SMATRocketTrail.SparkEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=128,G=192,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255))
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartLocationOffset=(X=-15.000000)
         StartSizeRange=(X=(Min=50.000000,Max=90.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKCExp_Pro.SMATRocketTrail.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=10.000000)
         ColorScale(0)=(Color=(B=192,G=128,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.400000
         FadeOutStartTime=0.990000
         FadeInEndTime=0.660000
         MaxParticles=2500
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.750000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.750000)
         StartSizeRange=(X=(Min=10.000000,Max=15.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=4.500000,Max=9.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_SKCExp_Pro.SMATRocketTrail.SpriteEmitter5'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=350
         DistanceThreshold=500.000000
         PointLifeTime=1.500000
         AutomaticInitialSpawning=False
         MaxParticles=1
         StartSizeRange=(X=(Min=15.000000,Max=18.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(4)=TrailEmitter'BWBP_SKCExp_Pro.SMATRocketTrail.TrailEmitter0'

     Physics=PHYS_Trailer
     bHardAttach=True
}
