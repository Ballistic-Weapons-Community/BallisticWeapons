//=============================================================================
// A500EProjectileTrail.
//
// Trail for A500E Projectiles
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500EProjectileTrail extends DGVEmitter;

defaultproperties
{
     bAutoAlignVelocity=True
     Begin Object Class=MeshEmitter Name=MeshEmitter5
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Reptile.Reptile_MuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         UseRevolution=True
         SpinParticles=True
         UseRegularSizeScale=False
         ColorScale(1)=(RelativeTime=0.300000,Color=(G=96,R=255))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorMultiplierRange=(Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(Z=(Min=0.100000,Max=1.000000))
         StartSpinRange=(Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.150000,Max=0.250000),Y=(Min=0.075000,Max=0.150000),Z=(Min=0.075000,Max=0.150000))
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.A500EProjectileTrail.MeshEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter53
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseRandomSubdivision=True
         Acceleration=(Z=-250.000000)
         ColorScale(0)=(Color=(G=128,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=96,R=255))
         FadeOutStartTime=0.450000
         FadeInEndTime=0.100000
         MaxParticles=55
         StartLocationRange=(X=(Max=45.000000))
         StartSpinRange=(X=(Min=-16384.000000,Max=-16384.000000))
         StartSizeRange=(X=(Min=5.000000,Max=8.000000),Y=(Min=8.000000,Max=16.000000),Z=(Min=5.000000,Max=8.000000))
         Texture=Texture'BW_Core_WeaponTex.Reptile.AcidDrops01'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.550000,Max=0.650000)
         StartVelocityRange=(X=(Max=-100.000000),Y=(Min=-75.000000,Max=75.000000),Z=(Min=-50.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.A500EProjectileTrail.SpriteEmitter53'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseRandomSubdivision=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(G=255,R=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=96,R=255))
         FadeOutStartTime=0.450000
         FadeInEndTime=0.100000
         MaxParticles=35
         StartLocationRange=(X=(Max=45.000000))
         StartSpinRange=(X=(Min=-16384.000000,Max=-16384.000000))
         StartSizeRange=(X=(Min=4.000000,Max=6.000000),Y=(Min=12.000000,Max=25.000000),Z=(Min=4.000000,Max=6.000000))
         InitialParticlesPerSecond=10.000000
         Texture=Texture'BW_Core_WeaponTex.Reptile.AcidDrops01'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.300000,Max=0.350000)
         StartVelocityRange=(X=(Min=-250.000000,Max=-50.000000),Y=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.A500EProjectileTrail.SpriteEmitter11'

     AutoDestroy=True
     bHardAttach=True
}
