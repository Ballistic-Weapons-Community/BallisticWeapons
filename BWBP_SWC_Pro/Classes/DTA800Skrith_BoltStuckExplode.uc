//=============================================================================
// DTA800Skrith_BoltStuckExplode.
//
// Damage type for when the hyperblaster bolt explodes on a dude
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA800Skrith_BoltStuckExplode extends DT_BWMiscDamage;

defaultproperties
{
	DeathStrings(0)="%k fused a sticky bomb to a screaming %o."
	DeathStrings(1)="%o couldn't pull off %k's hyperblaster sticky bombs."
	DeathStrings(2)="%o's limbs were exploded by %k's hyperblaster barrage."
	DeathStrings(3)="%k's seeking hyperblaster bolts hunted down %o."
	DeathStrings(4)="%k tagged a terrified %o with a sticky bomb barrage."
	DeathStrings(5)="%o happily caught several of %k's hyperblaster bombs."
	BloodManagerName="BallisticProV55.BloodMan_A73Burn"
	SimpleKillString="A800 Sticky"
	bIgniteFires=True
	bOnlySeverLimbs=True
	DamageDescription=",Flame,Plasma,"
	WeaponClass=Class'BWBP_SWC_Pro.A800SkrithMinigun'
	DeathString="%k fused parts of %o with the AY90."
	FemaleSuicide="%o masterfully stuck herself."
	MaleSuicide="%o masterfully stuck himself."
	GibModifier=2.000000
	GibPerterbation=0.200000
	KDamageImpulse=1000.000000
	VehicleDamageScaling=1.900000
     bDelayedDamage=True
}
