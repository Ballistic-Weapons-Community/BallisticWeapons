//=============================================================================
// DTG5Bazooka.
//
// DamageType for the RGK-350 HV Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRGPXBazooka extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k got a bullseye on %o, and was rewarded with chunks of gibs."
     DeathStrings(1)="%o was in the wrong place at the wrong time, getting tagged by %k's bazooka."
     DeathStrings(2)="%k managed to drill %o in the groin before they went boom."
	 DeathStrings(3)="%o caught %k's red hot potato just mere seconds before exploding into a modern art piece."
	 DeathStrings(4)="%k lodged a rocket into %o's exhaust pipe, exploding them to pieces."
	 DeathStrings(5)="%o used to be an adventurer before taking %k's rocket to the knee caps."
     InvasionDamageScaling=3.000000
     DamageIdent="Ordnance"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=100
     AimDisplacementDuration=0.700000
     WeaponClass=Class'BWBP_JCF_Pro.RGPXBazooka'
     DeathString="%o was blown to pieces by %k's Bazooka."
     FemaleSuicide="%o splattered the walls with her gibs using a Bazooka."
     MaleSuicide="%o splattered the walls with his gibs using a Bazooka."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     VehicleMomentumScaling=1.500000
}
