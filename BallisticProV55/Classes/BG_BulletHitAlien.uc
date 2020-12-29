//=============================================================================
// BG_BulletHitAlien.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_BulletHitAlien extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(1)=1
     DisableDGV(2)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.200000),Y=(Min=0.400000,Max=0.700000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.870000
         FadeOutStartTime=0.190000
         MaxParticles=3
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=-75.000000),Y=(Min=-40.000000,Max=40.000000),Z=(Max=20.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BG_BulletHitAlien.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.400000),Y=(Min=0.600000,Max=0.800000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.650000
         FadeOutStartTime=0.150000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.250000)
         StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=15.000000,Max=20.000000),Z=(Min=15.000000,Max=20.000000))
         InitialParticlesPerSecond=4000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.WaterSpray1Alpha'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=-30.000000,Max=-30.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.BG_BulletHitAlien.SpriteEmitter10'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.BloodVolumetric'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.300000),Y=(Min=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.035000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=16.000000)
         SpinsPerSecondRange=(Z=(Max=1.000000))
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=0.400000,Max=0.800000),Z=(Min=0.400000,Max=0.800000))
         InitialParticlesPerSecond=4000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=15.000000,Max=15.000000))
     End Object
     Emitters(2)=MeshEmitter'BallisticProV55.BG_BulletHitAlien.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.600000,Max=0.700000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.196000
         MaxParticles=8
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=50.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1Alpha'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=-200.000000,Max=-20.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-60.000000,Max=100.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.BG_BulletHitAlien.SpriteEmitter11'

     AutoDestroy=True
}
