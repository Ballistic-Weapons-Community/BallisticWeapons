//=============================================================================
// DT_CYLOFirestormShotgun.
//
// Damage type for CYLO Firestorm alt fire shotgun of fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_CYLOFirestormShotgun extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o was cooked into burnt BBQ by %k's CYLO Firestorm."
     DeathStrings(1)="%k roasted %o with %kh CYLO's incendiary shells."
     DeathStrings(2)="%o got a tasty sear from %k's CYLO Firestorm shotgun."
     DeathStrings(3)="%k's CYLO Firestorm likes %o extra crispy."
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_SKC_Pro.CYLOUAW'
     DeathString="%o was cooked into burnt BBQ by %k's CYLO Firestorm."
     FemaleSuicide="%o nailed herself with the CYLO."
     MaleSuicide="%o nailed himself with the CYLO."
	 bIgniteFires=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=25000.000000
     VehicleMomentumScaling=0.200000
}
