//=============================================================================
// RSNovaCoverGlow.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaCoverGlow extends BallisticEmitter;

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
         StaticMesh=StaticMesh'BWBP4-Hardware.NovaStaff.NovaGemGlow'
         UseMeshBlendMode=False
         UseParticleColor=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000))
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.RSNovaCoverGlow.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.150000,Max=0.150000),Y=(Min=0.150000,Max=0.150000),Z=(Min=0.500000))
         FadeOutStartTime=1.340000
         FadeInEndTime=0.620000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationOffset=(X=-52.000000,Z=7.000000)
         StartLocationRange=(X=(Max=16.000000))
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSNovaCoverGlow.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         FadeIn=True
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000))
         FadeOutStartTime=0.560000
         FadeInEndTime=0.270000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         DetailMode=DM_SuperHigh
         MeshSpawningStaticMesh=StaticMesh'BWBP4-Hardware.NovaStaff.NovaGemGlow'
         MeshSpawning=PTMS_Random
         StartSizeRange=(X=(Min=1.000000,Max=4.000000),Y=(Min=1.000000,Max=4.000000),Z=(Min=1.000000,Max=4.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSNovaCoverGlow.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000))
         Opacity=0.630000
         FadeOutStartTime=1.020000
         FadeInEndTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-50.000000,Z=8.000000)
         StartLocationRange=(X=(Max=5.000000))
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
         Texture=Texture'BallisticEffects.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=3.000000,Max=6.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSNovaCoverGlow.SpriteEmitter6'

     bHardAttach=True
}
