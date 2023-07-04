//=============================================================================
// DTAY90Skrith_BoltDirect.
//
// Damage type for the AY90 sticky bombs before they explode
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAY90Skrith_BoltDirect extends DT_BWMiscDamage;

defaultproperties
{
	DeathStrings(0)="%k pricked %o with a Wyvern plasma bolt."
	DeathStrings(1)="%o got stuck by %k's Wyvern and didn't even make it to the blast."
	DeathStrings(2)="%k finished off a wounded %o, giving %km more meat for the Wyvern."
	DeathStrings(3)="%k's Wyvern stuck %o where the sun doesn't shine."
	DeathStrings(4)="%o's adventure was cut short by %k's explosive bolt to the knee."
    BloodManagerName="BallisticProV55.BloodMan_A73Burn"
	SimpleKillString="AY90 Sticky Impact"
	bIgniteFires=True
	bOnlySeverLimbs=True
	DamageDescription=",Flame,Plasma,"
	WeaponClass=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'
	DeathString="%k pricked %o with a Wyvern plasma bolt."
	FemaleSuicide="%o caught her own AY90 sticky bomb."
	MaleSuicide="%o caught his own AY90 sticky bomb."
	GibModifier=2.000000
	GibPerterbation=0.200000
	KDamageImpulse=1000.000000
	VehicleDamageScaling=0.900000
     bDelayedDamage=True
}
