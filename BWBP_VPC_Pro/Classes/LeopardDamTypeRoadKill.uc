//=============================================================================
//The Ramming damage type for the TMV Leopard.
//

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//=============================================================================

class LeopardDamTypeRoadKill extends BE_VDT_Manager
	abstract;

defaultproperties
{
     DeathStrings(0)="%o was tenderized by %k's TMV Tracks."
     DeathStrings(1)="%k's TMV tracks caught %o in a lock."
     DeathStrings(2)="%k's TMV tracks ground %o's twig like bones."
     DeathStrings(3)="%k's TMV tracks proved why children like %o shouldn't walk off road."
     DeathStrings(4)="%o couldn't run from %k's scary TMV tracks."
     DeathStrings(5)="%o's boney little arms got stuck in %k's TMV engine cogs."
     DeathStrings(6)="%o got aquainted with %k's TMV tracks."
     FemaleSuicides(0)="%o made one fine peice of tenderized steak out of herself."
     FemaleSuicides(1)="%o forget to put her TMV's handbrake on."
     MaleSuicides(0)="%o made one fine peice of tenderized steak out of himself."
     MaleSuicides(1)="%o forget to put his TMV's handbrake on."
     NumMessages=6
     bLocationalHit=False
     bNeverSevers=True
     bVehicleHit=True
     GibModifier=2.000000
     GibPerterbation=0.500000
}
