//=============================================================================
// DTHydraBazookaRadius.
//
// DamageType for the Hydra Bazooka radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHydraBazookaRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o almost escaped %k's Hydra rocket."
     DeathStrings(1)="%o was blown in half by %k's Hydra rocket."
     DeathStrings(2)="%k completely vaporized %o with a Hydra rocket."
     DeathStrings(3)="%k's Hydra rocket turned %o into tomato soup."
     FemaleSuicides(0)="%o splattered the walls with her gibs using a Hydra."
     FemaleSuicides(1)="%o blasted herself across the map with a Hydra."
     FemaleSuicides(2)="%o blew herself into a chunky haze with the Hydra."
     MaleSuicides(0)="%o splattered the walls with his gibs using a Hydra."
     MaleSuicides(1)="%o blasted himself across the map with a Hydra."
     MaleSuicides(2)="%o blew himself into a chunky haze with the Hydra."
     InvasionDamageScaling=3.000000
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBP_APC_Pro.HydraBazooka'
     DeathString="%o almost escaped %k's Hydra rocket."
     FemaleSuicide="%o splattered the walls with her gibs using a Hydra."
     MaleSuicide="%o splattered the walls with his gibs using a Hydra."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     VehicleMomentumScaling=1.500000
}
