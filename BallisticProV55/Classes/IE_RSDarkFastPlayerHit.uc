//=============================================================================
// IE_RSDarkFastPlayerHit.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_RSDarkFastPlayerHit extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter27
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.500000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=70.000000,Max=80.000000),Y=(Min=70.000000,Max=80.000000),Z=(Min=70.000000,Max=80.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.WaterRing1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_RSDarkFastPlayerHit.SpriteEmitter27'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter28
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.332143,Color=(G=64,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.600000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=1.180000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=20.000000,Max=30.000000),Z=(Min=20.000000,Max=30.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_RSDarkFastPlayerHit.SpriteEmitter28'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter29
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.320000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=7.000000,Max=7.000000),Y=(Min=7.000000,Max=7.000000),Z=(Min=7.000000,Max=7.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.DarkStar.HotFlareA2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_RSDarkFastPlayerHit.SpriteEmitter29'

     AutoDestroy=True
}
