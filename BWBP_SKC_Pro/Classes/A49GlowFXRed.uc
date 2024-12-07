//=============================================================================
// A49GlowFXRed.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class A49GlowFXRed extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[0].ZTest = true;
}

simulated function SetSize(float Alpha)
{
	Emitters[0].StartSizeRange.X.Min = Lerp(Alpha, 5, 20); 	Emitters[0].StartSizeRange.X.Max = Emitters[0].StartSizeRange.X.Min;
	Emitters[0].StartSizeRange.Y.Min = Lerp(Alpha, 5, 20); 	Emitters[0].StartSizeRange.Y.Max = Emitters[0].StartSizeRange.Y.Min;
	Emitters[0].StartSizeRange.Z.Min = Lerp(Alpha, 5, 20); 	Emitters[0].StartSizeRange.Z.Max = Emitters[0].StartSizeRange.Z.Min;
}


defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         ZTest=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-45.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.A49GlowFXRed.SpriteEmitter2'

}
