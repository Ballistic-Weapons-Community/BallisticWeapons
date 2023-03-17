//=============================================================================
// A73GlowFX.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class A73GlowFXBal extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[0].ZTest = true;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.250000,Max=0.500000))
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-170.000000)
         StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=55000000,Max=55.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.A73GlowFXBal.SpriteEmitter2'

}
