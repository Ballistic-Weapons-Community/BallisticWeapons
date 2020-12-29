//=============================================================================
// ShotgunBrassTrail.
//
// Trail for Shotgun shells
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ShotgunBrassTrail extends DGVEmitter;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

	SetTimer(1.0 + 1.5 * FRand(), false);
}


simulated function Timer()
{
	Kill();
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter30
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=40.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.500000
         FadeOutStartTime=0.220000
         MaxParticles=40
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticWeapons2.Effects.Smoke7'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Max=20.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.ShotgunBrassTrail.SpriteEmitter30'

     bHardAttach=True
}
