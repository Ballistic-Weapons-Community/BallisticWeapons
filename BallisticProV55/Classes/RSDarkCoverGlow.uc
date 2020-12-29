//=============================================================================
// RSNovaCoverGlow.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkCoverGlow extends BallisticEmitter;

function InvertY()
{
	local int i;
	for (i=0;i<Emitters.length;i++)
	{
		Emitters[i].StartLocationOffset.Y *= -1;
	}
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkDiamond'
         UseMeshBlendMode=False
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.250000,Max=0.250000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.700000
         FadeOutFactor=(X=0.750000,Y=0.750000,Z=0.750000)
         FadeOutStartTime=1.200000
         FadeInFactor=(X=0.750000,Y=0.750000,Z=0.750000)
         FadeInEndTime=0.800000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         InitialParticlesPerSecond=50.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.RSDarkCoverGlow.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         FadeOut=True
         FadeIn=True
         ZTest=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.100000,Max=0.100000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.590000
         FadeOutFactor=(X=0.500000,Y=0.500000,Z=0.500000)
         FadeOutStartTime=1.200000
         FadeInFactor=(X=0.500000,Y=0.500000,Z=0.500000)
         FadeInEndTime=0.800000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(Z=-2.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=50.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSDarkCoverGlow.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter16
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=192,G=224,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         Opacity=0.630000
         FadeOutStartTime=0.246000
         FadeInEndTime=0.078000
         CoordinateSystem=PTCS_Relative
         MaxParticles=8
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=-0.250000,Max=0.250000),Y=(Min=-0.250000,Max=0.250000),Z=(Min=-0.250000,Max=0.250000))
         MeshSpawningStaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkDiamond'
         MeshSpawning=PTMS_Linear
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.400000,Max=1.000000),Y=(Min=0.400000,Max=1.000000),Z=(Min=0.400000,Max=1.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         LifetimeRange=(Min=0.400000,Max=0.600000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSDarkCoverGlow.SpriteEmitter16'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
         FadeOut=True
         FadeIn=True
         ZTest=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.550000
         FadeOutStartTime=1.170000
         FadeInEndTime=0.990000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         DetailMode=DM_SuperHigh
         StartLocationOffset=(Z=-2.000000)
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=4.000000,Max=6.000000),Y=(Min=4.000000,Max=6.000000),Z=(Min=4.000000,Max=6.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSDarkCoverGlow.SpriteEmitter17'

     bHardAttach=True
}
