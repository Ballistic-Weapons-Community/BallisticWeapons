//=============================================================================
// HVCMk9RedMuzzleFlash.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVPCMk66GreenGlow extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[0].ZTest = true;
}


simulated function SetColorShift(float Alpha)
{
	Emitters[0].ColorMultiplierRange.X.Min = Lerp(Alpha, 0.4, 1.0); 	Emitters[0].ColorMultiplierRange.X.Max = Emitters[0].ColorMultiplierRange.X.Min;
//	Emitters[0].ColorMultiplierRange.Y.Min = Lerp(Alpha, 0.4, 0.4); 	Emitters[0].ColorMultiplierRange.Y.Max = Emitters[0].ColorMultiplierRange.Y.Min;
	Emitters[0].ColorMultiplierRange.Z.Min = Lerp(Alpha, 0.4, 0.0); 	Emitters[0].ColorMultiplierRange.Z.Max = Emitters[0].ColorMultiplierRange.Z.Min;

//	Emitters[1].ColorMultiplierRange.X.Min = Lerp(Alpha, 1.0, 1.0); 	Emitters[1].ColorMultiplierRange.X.Max = Emitters[1].ColorMultiplierRange.X.Min;
	Emitters[1].ColorMultiplierRange.Y.Min = Lerp(Alpha, 1.0, 0.8); 	Emitters[1].ColorMultiplierRange.Y.Max = Emitters[1].ColorMultiplierRange.Y.Min;
	Emitters[1].ColorMultiplierRange.Z.Min = Lerp(Alpha, 1.0, 0.7); 	Emitters[1].ColorMultiplierRange.Z.Max = Emitters[1].ColorMultiplierRange.Z.Min;

	Emitters[2].ColorMultiplierRange.X.Min = Lerp(Alpha, 0.1, 1.0); 	Emitters[2].ColorMultiplierRange.X.Max = Emitters[2].ColorMultiplierRange.X.Min;
	Emitters[2].ColorMultiplierRange.Y.Min = Lerp(Alpha, 0.2, 0.1); 	Emitters[2].ColorMultiplierRange.Y.Max = Emitters[2].ColorMultiplierRange.Y.Min;
	Emitters[2].ColorMultiplierRange.Z.Min = Lerp(Alpha, 1.0, 0.1); 	Emitters[2].ColorMultiplierRange.Z.Max = Emitters[2].ColorMultiplierRange.Z.Min;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.607143,Color=(G=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,A=255))
         ColorMultiplierRange=(X=(Min=0.230000,Max=0.330000),Y=(Min=0.930000,Max=0.930000),Z=(Min=0.430000,Max=0.630000))
         FadeOutStartTime=0.700000
         FadeInEndTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=7
         DetailMode=DM_High
         StartLocationOffset=(X=-20.000000)
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=60.000000,Max=60.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.HVPCMk66GreenGlow.SpriteEmitter6'

}
