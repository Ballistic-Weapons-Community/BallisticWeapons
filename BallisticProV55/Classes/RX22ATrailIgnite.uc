//=============================================================================
// RX22ATrailIgnite.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22ATrailIgnite extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter41
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.317857,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.846429,Color=(B=255,G=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.124000
         FadeInEndTime=0.032000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=32.000000)
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.200000)
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=80.000000,Max=80.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RX22ATrailIgnite.SpriteEmitter41'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter42
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,A=255))
         ColorScale(1)=(RelativeTime=0.792857,Color=(B=64,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=64,G=128,R=255,A=255))
         FadeOutStartTime=0.370000
         FadeInEndTime=0.090000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=32.000000,Z=32.000000)
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=110.000000,Max=110.000000),Y=(Min=110.000000,Max=110.000000),Z=(Min=110.000000,Max=110.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Min=30.000000,Max=30.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RX22ATrailIgnite.SpriteEmitter42'

     AutoDestroy=True
}
