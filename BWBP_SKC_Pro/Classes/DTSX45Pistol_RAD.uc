//=============================================================================
// DTGRSXXPistol.
//
// Damage type for the Colt M1911 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSX45Pistol_RAD extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k turned %o into a glowstick made out of radiation."
     DeathStrings(1)="%o's veins are glowing green thanks to %k's radioactive handgun."
     DeathStrings(2)="%k turned %o's DNA strands into a soupy mess."
	 DeathStrings(3)="%o's bleeding neon green now due to %k's combat pistol."
     WeaponClass=Class'BWBP_SKC_Pro.SX45Pistol'
     DeathString="%k shot down %o in %vh prime with his SX45K."
     FemaleSuicide="%o somehow shot herself."
     MaleSuicide="%o managed to shoot himself."
     VehicleDamageScaling=0.500000

	TagMultiplier=0.7
	TagDuration=0.1
}
