//=============================================================================
// DTFM13Shotgun.
//
// Damage type for FM13
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_CoachFire extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="It wasn’t the burn that got %o, it was the impact from %k’s Trenchgun that did them in."
     DeathStrings(1)="%k reduced %o to cinders after shooting them with some good ol’ phosphorus."
     DeathStrings(2)="%o took %k’s phosphorous point blank in the chest, searing the flesh off their ribcage."
     DeathStrings(3)="%k started a fire using their trenchgun and %o as their fleshy tinder."
     DeathStrings(4)="To say %o was overheated by %k’s dragon’s breath would be an understatement."
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_SKC_Pro.CoachGun'
     DeathString="It wasn’t the burn that got %o, it was the impact from %k’s Trenchgun that did them in."
     FemaleSuicide="%o roasted themselves with a dragon’s breath shell."
     MaleSuicide="%o roasted themselves with a dragon’s breath shell."
	 bIgniteFires=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=25000.000000
     VehicleMomentumScaling=0.200000
}
