//=============================================================================
// DTSX45Pistol.
//
// Damage type for the FNX-45 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSX45Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k tactically removed %o with an SX45."
     DeathStrings(1)="%o got perforated by %k's SX45 rounds."
     DeathStrings(2)="%k served a double stacked mag of .45's to %o."
	 DeathStrings(3)="%o's crime spree was stopped by %k's SX45."
     WeaponClass=Class'BWBP_SKC_Pro.SX45Pistol'
     DeathString="%k tactically removed %o with an SX45."
     FemaleSuicide="%o somehow shot herself."
     MaleSuicide="%o managed to shoot himself."
     VehicleDamageScaling=0.500000

	TagMultiplier=0.7
	TagDuration=0.1
}
