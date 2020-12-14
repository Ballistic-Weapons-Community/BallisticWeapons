//=============================================================================
// A500AltProjectileTrail.
//
// Trail for A500 Blob Projectiles
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500AltProjectileTrail extends DGVEmitter;

simulated function ScaleAcidTrail()
{

}

defaultproperties
{
     bAutoAlignVelocity=True
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Reptile.Reptile_MuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         UseRevolution=True
         SpinParticles=True
         UseRegularSizeScale=False
         ColorScale(1)=(RelativeTime=0.300000,Color=(G=255,R=96))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorMultiplierRange=(Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(Z=(Min=0.100000,Max=1.000000))
         StartSpinRange=(Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.150000,Max=0.150000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.A500AltProjectileTrail.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseRandomSubdivision=True
         Acceleration=(Z=-250.000000)
         ColorScale(0)=(Color=(G=255,R=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,R=96))
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
     Emitters(1)=SpriteEmitter'BallisticProV55.A500AltProjectileTrail.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter54
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.324000
         FadeInEndTime=0.036000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=0.250000,Max=1.000000))
         StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
         Texture=Texture'BallisticBloodPro.Alien.Alien-BloodPool1'
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.A500AltProjectileTrail.SpriteEmitter54'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter55
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(G=255,R=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,R=96))
         FadeOutStartTime=0.299000
         FadeInEndTime=0.097500
         MaxParticles=55
         SpinsPerSecondRange=(X=(Max=0.500000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=5.000000,Max=8.000000),Y=(Min=8.000000,Max=16.000000),Z=(Min=5.000000,Max=8.000000))
         Texture=Texture'BallisticBloodPro.DeRez.Wisp2'
         LifetimeRange=(Min=0.550000,Max=0.650000)
         StartVelocityRange=(Y=(Min=-65.000000,Max=65.000000),Z=(Min=-50.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.A500AltProjectileTrail.SpriteEmitter55'

     AutoDestroy=True
     DrawScale=0.300000
     bHardAttach=True
}
