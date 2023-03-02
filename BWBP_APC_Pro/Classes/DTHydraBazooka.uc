//=============================================================================
// DTHydraBazooka.
//
// DamageType for the Hydra Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHydraBazooka extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o thought they could avoid one rocket, but they couldn't avoid %k's six rocket storm."
     DeathStrings(1)="%k's Multi-barreled Hydra slayed the warrior %o with an explosive barrage."
     DeathStrings(2)="%o found out that %k's launcher Hydra is versatile in exploding enemies in many ways."
     DeathStrings(3)="%k might’ve missed with one rocket, but a couple more reduced %o into a light mist."
	 DeathStrings(4)="%o was the willing assistant, disappearing in a cloud because of %k's explosive magic show."
	 DeathStrings(5)="%k brought down multiple rockets unto %o, who couldn't accept them all."
	 InvasionDamageScaling=3.000000
     DamageIdent="Ordnance"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=100
     AimDisplacementDuration=0.700000
     WeaponClass=Class'BWBP_APC_Pro.HydraBazooka'
     DeathString="%o was blown to pieces by %k's Hydra."
     FemaleSuicide="%o splattered the walls with her gibs using a Hydra."
     MaleSuicide="%o splattered the walls with his gibs using a Hydra."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     VehicleMomentumScaling=1.500000
}
