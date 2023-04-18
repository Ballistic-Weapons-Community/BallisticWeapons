//=============================================================================
// DTAY90Skrith_BoltStuckExplodeRadius.
//
// Damage type for when the guy you shot with a skrithbow lives, but then explodes
// and the dude next to him dies, and we want a humorous anecdote, and this has a
// long class name
//
// by SK and SX
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAY90Skrith_BoltStuckExplodeRadius extends DT_BWMiscDamage;

defaultproperties
{
	DeathStrings(0)="%k got one victim plus an oblivious %o for free with a sticky explosive bolt."
	DeathStrings(1)="%o found out why %ve should stay 6 feet from %k's Wyvern victim."
	DeathStrings(2)="%k's Wyvern took %o alongside its intended target."
	DeathStrings(3)="%o was just another number to %k's boltcaster."
	SimpleKillString="AY90 Sticky Bonus"
	BloodManagerName="BallisticProV55.BloodMan_A73Burn"
	bIgniteFires=True
	bOnlySeverLimbs=True
	DamageDescription=",Flame,Plasma,"
	WeaponClass=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'
	DeathString="%k got one victim plus an oblivious %o for free with a sticky explosive bolt."
	FemaleSuicide="%o's stuck target came back to haunt her."
	MaleSuicide="%o's stuck target came back to haunt him."
	GibModifier=2.000000
	GibPerterbation=0.200000
	KDamageImpulse=1000.000000
	VehicleDamageScaling=0.900000
     bDelayedDamage=True
}
