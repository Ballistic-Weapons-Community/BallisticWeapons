//=============================================================================
// BG_A73StumpFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_A73BStumpFire extends BallisticEmitter;

simulated event PostbeginPlay()
{
	super.PostbeginPlay();
	SetTimer(0.2, true);
}
simulated function Timer()
{
	if (Owner == None)
	{
		SetTimer(0.0, false);
		Kill();
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=30.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.164286,Color=(B=255,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.350000,Color=(B=255,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=3.500000,Max=0.600000),Z=(Min=0.300000,Max=0.400000))
         FadeOutStartTime=0.470000
         FadeInEndTime=0.160000
         MaxParticles=6
         StartLocationOffset=(Z=5.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Min=0.450000,Max=0.550000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=12.000000,Max=16.000000),Y=(Min=12.000000,Max=16.000000),Z=(Min=12.000000,Max=16.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.BG_A73BStumpFire.SpriteEmitter4'

     AutoDestroy=True
}
