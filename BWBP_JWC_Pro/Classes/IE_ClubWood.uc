//=============================================================================
// IE_ClubWood.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_ClubWood extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(2)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-15.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.600000,Max=0.700000))
         Opacity=0.220000
         FadeOutStartTime=1.080000
         FadeInEndTime=0.120000
         MaxParticles=6
         StartLocationRange=(Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.350000)
         StartSizeRange=(X=(Min=12.000000,Max=20.000000),Y=(Min=12.000000,Max=20.000000),Z=(Min=12.000000,Max=20.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=40.000000,Max=50.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=15.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_JWC_Pro.IE_ClubWood.SpriteEmitter21'

     Begin Object Class=MeshEmitter Name=MeshEmitter7
         StaticMesh=StaticMesh'BWBP_JW_Static.Impact.WoodChipA1'
         UseParticleColor=True
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         DampingFactorRange=(X=(Min=0.400000,Max=0.500000),Y=(Min=0.400000,Max=0.500000),Z=(Min=0.400000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.160000
         FadeInEndTime=0.390000
         MaxParticles=15
         StartLocationRange=(Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         SpinsPerSecondRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         RotationDampingFactorRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         InitialParticlesPerSecond=999999.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=250.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=25.000000,Max=100.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
     End Object
     Emitters(1)=MeshEmitter'BWBP_JWC_Pro.IE_ClubWood.MeshEmitter7'

     Begin Object Class=MeshEmitter Name=MeshEmitter8
         StaticMesh=StaticMesh'BWBP_JW_Static.Impact.WoodChipA1'
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.310000
         CoordinateSystem=PTCS_Relative
         MaxParticles=8
         StartLocationRange=(Y=(Min=-8.000000,Max=8.000000),Z=(Min=-8.000000,Max=8.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.100000,Max=0.200000),Y=(Min=0.100000,Max=0.200000),Z=(Min=0.100000,Max=0.200000))
         InitialParticlesPerSecond=500000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
     End Object
     Emitters(2)=MeshEmitter'BWBP_JWC_Pro.IE_ClubWood.MeshEmitter8'

     AutoDestroy=True
}
