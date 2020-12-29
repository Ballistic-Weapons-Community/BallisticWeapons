//=============================================================================
// RSNovaCoverGlow.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class XOXOCoverGlow extends BallisticEmitter;

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
     Begin Object Class=SpriteEmitter Name=XOXOCoverFlare
         FadeOut=True
         FadeIn=True
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
         StartSizeRange=(X=(Min=35.000000,Max=35.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=50.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.XOXOCoverGlow.XOXOCoverFlare'

     Begin Object Class=SpriteEmitter Name=XOXOCoverFlare2
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
         StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=6.000000,Max=6.000000))
         MeshSpawningStaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkDiamond'
         MeshSpawning=PTMS_Linear
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.400000,Max=1.000000),Y=(Min=0.400000,Max=1.000000),Z=(Min=0.400000,Max=1.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         LifetimeRange=(Min=0.400000,Max=0.600000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPOtherPackPro.XOXOCoverGlow.XOXOCoverFlare2'

     bHardAttach=True
}
