//=============================================================================
// DTAY90Skrith_BoltStuckExplode.
//
// Damage type for when the skrithbow bolt explodes on a dude
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAY90Skrith_BoltStuckExplode extends DT_BWMiscDamage;

defaultproperties
{
	DeathStrings(0)="%k marked %o for death with an skrithbow sticky bolt."
	DeathStrings(1)="%o ran around screaming with %k's plasma bolt stuck in %vh ribcage."
	DeathStrings(2)="%k's explosive bolt stuck and roasted %o like a pig."
	DeathStrings(3)="%o couldn't shake off %k's explosive plasma bolt."
	DeathStrings(4)="%k silently stuck %o with a skrith sticky bomb."
	DeathStrings(5)="%o got tagged in the butt by %k's skrithbow."
	BloodManagerName="BallisticProV55.BloodMan_A73Burn"
	SimpleKillString="AY90 Sticky"
	bIgniteFires=True
	bOnlySeverLimbs=True
	DamageDescription=",Flame,Plasma,"
	WeaponClass=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'
	DeathString="%k marked %o for death with an skrithbow sticky bolt."
	FemaleSuicide="%o masterfully stuck herself."
	MaleSuicide="%o masterfully stuck himself."
	GibModifier=2.000000
	GibPerterbation=0.200000
	KDamageImpulse=1000.000000
	VehicleDamageScaling=1.900000
     bDelayedDamage=True
}
