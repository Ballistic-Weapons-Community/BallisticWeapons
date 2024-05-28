//=============================================================================
// PumaGlowFXDamaged.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20GlowFXDamaged extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.000000
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         DrawStyle=PTDS_Modulated
         Texture=Texture'BW_Core_WeaponTex.Particles.NewSmoke1f'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.XM20GlowFXDamaged.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseDirectionAs=PTDU_Forward
         FadeOut=True
         UniformSize=True
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-1500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.400000),Y=(Min=0.000000,Max=0.400000))
         FadeOutStartTime=0.006160
         MaxParticles=5
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=45.000000)
         StartSizeRange=(X=(Min=10.000000,Max=18.000000),Y=(Min=10.000000,Max=18.000000),Z=(Min=10.000000,Max=18.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.011000,Max=0.031000)
         StartVelocityRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.XM20GlowFXDamaged.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         UniformSize=True
         Acceleration=(Z=-1500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.920000
         MaxParticles=5
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=25.000000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         Texture=Texture'BW_Core_WeaponTex.GunFire.A73MuzzleFlash'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SubdivisionStart=1
         SubdivisionEnd=1
         LifetimeRange=(Min=0.401000,Max=0.401000)
         StartVelocityRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.XM20GlowFXDamaged.SpriteEmitter5'

     bNoDelete=False
}
