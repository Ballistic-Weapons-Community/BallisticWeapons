//=============================================================================
// DTAY90Skrith_BoltDirect.
//
// Damage type for the AY90 sticky bombs before they explode
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA800Skrith_BoltDirect extends DT_BWMiscDamage;

defaultproperties
{
	DeathStrings(0)="%k's hyperblaster tagged a fleeing %o."
	DeathStrings(1)="%o couldn't escape %k's homing Hyperblaster charge."
	DeathStrings(2)="%o couldn't outrun %k's hyperblaster and %kh homing bolts."
	DeathStrings(3)="%o couldn't hide from $k's hyperblaster homing barrage."
    BloodManagerName="BallisticProV55.BloodMan_A73Burn"
	SimpleKillString="A800 Sticky Impact"
	bIgniteFires=True
	bOnlySeverLimbs=True
	DamageDescription=",Flame,Plasma,"
	WeaponClass=Class'BWBP_SWC_Pro.A800SkrithMinigun'
	DeathString="%k's hyperblaster tagged a fleeing %o."
	FemaleSuicide="%o caught her own A800 sticky bomb."
	MaleSuicide="%o caught his own A800 sticky bomb."
	GibModifier=2.000000
	GibPerterbation=0.200000
	KDamageImpulse=1000.000000
	VehicleDamageScaling=0.900000
     bDelayedDamage=True
}
