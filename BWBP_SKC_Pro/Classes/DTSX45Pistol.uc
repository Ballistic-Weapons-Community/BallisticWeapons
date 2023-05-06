//=============================================================================
// DTGRSXXPistol.
//
// Damage type for the Colt M1911 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSX45Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k made %o a religious person with all the holes in his torso."
     DeathStrings(1)="%o got his lungs bursted by %k's .45ACP bullets."
     DeathStrings(2)="%k served a double stacked mag of .45's to %o."
	 DeathStrings(3)="%o crashed into a bloody heap thanks to %k."
     WeaponClass=Class'BWBP_SKC_Pro.SX45Pistol'
     DeathString="%k shot down %o in %vh prime with his SX45K."
     FemaleSuicide="%o somehow shot herself."
     MaleSuicide="%o managed to shoot himself."
     VehicleDamageScaling=0.500000

	TagMultiplier=0.7
	TagDuration=0.1
}
