//=============================================================================
// BX5TeamLight.
//
// A light flare in blue or red, depending on the team it is for.
// Used to show that a BX5 Mine was planted by a teammate
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BX5TeamLight extends BallisticEmitter
	placeable;
	
simulated event BaseChange()
{
	if (Base == None)
		Destroy();
}

simulated function SetTeamColor(int Team)
{
	switch (Team)
	{
	case 0:
  	     Emitters[0].ColorMultiplierRange.Z.Min=0.000000;
   	     Emitters[0].ColorMultiplierRange.Z.Max=0.000000;
   	     Emitters[0].ColorMultiplierRange.Y.Min=0.000000;
   	     Emitters[0].ColorMultiplierRange.Y.Max=0.000000;
	break;

	case 1:
		Emitters[0].ColorMultiplierRange.X.Min=0.000000;
		Emitters[0].ColorMultiplierRange.X.Max=0.000000;
		Emitters[0].ColorMultiplierRange.Y.Min=0.000000;
		Emitters[0].ColorMultiplierRange.Y.Max=0.000000;
	break;
	
	case 2: //makes green mines for 4-team gametypes - also used for own mines in standard gametypes
		Emitters[0].ColorMultiplierRange.X.Min=0.000000;
		Emitters[0].ColorMultiplierRange.X.Max=0.000000;
		Emitters[0].ColorMultiplierRange.Z.Min=0.000000;
		Emitters[0].ColorMultiplierRange.Z.Max=0.000000;
	break;

	case 3: //makes yellow mines for 4-team gametypes and DM
		Emitters[0].ColorMultiplierRange.Z.Min=0.000000;
		Emitters[0].ColorMultiplierRange.Z.Max=0.000000;
	break;

	case 255: //makes yellow mines for 4-team gametypes and DM
		Emitters[0].ColorMultiplierRange.Z.Min=0.000000;
		Emitters[0].ColorMultiplierRange.Z.Max=0.000000;
	break;
	}	
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.400000
         FadeOutStartTime=1.300000
         FadeInEndTime=1.300000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=9.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BX5TeamLight.SpriteEmitter0'

     CullDistance=3072.000000
     bHardAttach=True
}
