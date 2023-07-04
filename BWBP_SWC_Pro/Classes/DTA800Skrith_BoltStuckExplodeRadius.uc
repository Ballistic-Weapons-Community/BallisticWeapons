//=============================================================================
// DTA800Skrith_BoltStuckExplodeRadius.
//
// Damage type for when the guy you shot with a hyperblaster lives, but then explodes
// and the dude next to him dies, and we want a humorous anecdote, and this has a
// long class name
//
// by SK and SX
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA800Skrith_BoltStuckExplodeRadius extends DT_BWMiscDamage;

defaultproperties
{
	DeathStrings(0)="%k's original hyperblaster target spread the fun to %o."
	DeathStrings(1)="%o should have run away from the soldier covered in %k's homing bombs."
	DeathStrings(2)="%k's hyperblaster got a free kill off of %o."
	DeathStrings(3)="%o was just another number to %k's hyperblaster."
	SimpleKillString="Hyperblaster Sticky Bonus"
	BloodManagerName="BallisticProV55.BloodMan_A73Burn"
	bIgniteFires=True
	bOnlySeverLimbs=True
	DamageDescription=",Flame,Plasma,"
	WeaponClass=Class'BWBP_SWC_Pro.A800SkrithMinigun'
	DeathString="%o was just another number to %k's hyperblaster."
	FemaleSuicide="%o's stuck target came back to haunt her."
	MaleSuicide="%o's stuck target came back to haunt him."
	GibModifier=2.000000
	GibPerterbation=0.200000
	KDamageImpulse=1000.000000
	VehicleDamageScaling=0.900000
     bDelayedDamage=True
}
