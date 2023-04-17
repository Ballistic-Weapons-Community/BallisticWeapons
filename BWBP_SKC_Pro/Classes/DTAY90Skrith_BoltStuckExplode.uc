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
	DeathStrings(0)="%k tagged %o with a sticky bolt, %ve didn't notice it until %ve went boom."
	DeathStrings(1)="%o ran around screaming with %k's plasma bolt stuck in %vh ribcage."
	DeathStrings(2)="%k stuck %o like a pig, even roasted %vm like one after the bolt exploded."
	DeathStrings(3)="%o couldn't shake off %k's plasma bolt before %ve exploded into fiery giblets."
	DeathStrings(4)="%k managed to silently stick %o with a sticky bolt without %vm ever knowing."
	DeathStrings(5)="%o got tagged in the butt before going ka-boom by %k."
	BloodManagerName="BallisticProV55.BloodMan_A73Burn"
	SimpleKillString="AY90 Sticky"
	bIgniteFires=True
	bOnlySeverLimbs=True
	DamageDescription=",Flame,Plasma,"
	WeaponClass=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'
	DeathString="%k fused parts of %o with the AY90."
	FemaleSuicide="%o masterfully stuck herself."
	MaleSuicide="%o masterfully stuck himself."
	GibModifier=2.000000
	GibPerterbation=0.200000
	KDamageImpulse=1000.000000
	VehicleDamageScaling=1.900000
     bDelayedDamage=True
}
