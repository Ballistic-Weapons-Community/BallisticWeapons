//=============================================================================
// DT_AR23HR.
//
// Damage type for the AR23 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AR23HR extends DT_BWBullet;

defaultproperties
{
	DeathStrings(0)="%k mistook %o for a boar, still had to be put down like one."
	DeathStrings(1)="%o was punished for their crimes and was executed by %k's Punisher."
	DeathStrings(2)="%k awarded %o the death penalty, several .50 Beowulfs to the torso."
	DeathStrings(3)="%o was the prize of big game hunter, %k."
	DeathStrings(4)="%k obliterated %o's hooves with the AR23, reducing them to dust."
	DeathStrings(5)="%o found out the history and how potent the Beowulf round is thanks to %k."
	DamageIdent="Heavy Rifle"
	WeaponClass=Class'BWBP_SKC_Pro.AR23HeavyRifle'
	DeathString="%k made a holy man of %o with AR23 rounds."
	FemaleSuicide="%o caught her face in the belt feed of her AR23."
	MaleSuicide="%o caught his face in the belt feed of his AR23."
	bFastInstantHit=True

	TagMultiplier=0.6
	TagDuration=0.2
}
