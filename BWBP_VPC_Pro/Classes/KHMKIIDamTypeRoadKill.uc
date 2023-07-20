//=============================================================================
//The Ramming damage type for the KH MarkII Cobra.
//

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//=============================================================================
class KHMKIIDamTypeRoadKill extends BE_VDT_Manager
	abstract;

defaultproperties
{
     DeathStrings(0)="%o lept into %k's rotor blades."
     DeathStrings(1)="%k's rotor blades satisfied %o's craving for sushi."
     DeathStrings(2)="%k's landing bars caught a foreign object called %o."
     DeathStrings(3)="%o should have checked both sides of the road for %k's Cobra."
     FemaleSuicides(0)="%o made sushi of herself."
     FemaleSuicides(1)="%o forget to put her Cobra's handbrake on."
     MaleSuicides(0)="%o made sushi of himself."
     MaleSuicides(1)="%o forget to put his Cobra's handbrake on."
     bLocationalHit=False
     bNeverSevers=True
     bVehicleHit=True
     GibModifier=2.000000
     GibPerterbation=0.500000
}
