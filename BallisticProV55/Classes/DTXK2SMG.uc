//=============================================================================
// DTXK2SMG.
//
// Damage type for the XK2 SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXK2SMG extends DT_BWBullet;

defaultproperties
{
	DeathStrings(0)="%o was put out by %k's XK2."
	DeathStrings(1)="%k dispelled %o's shrieks with a hail of XK2 bullets."
	DeathStrings(2)="%k silenced %o with XK2 rounds."
	EffectChance=0.500000
	InvasionDamageScaling=1.500000
	DamageIdent="SMG"
	WeaponClass=Class'BallisticProV55.XK2SubMachinegun'
	DeathString="%o was put out by %k's XK2."
	FemaleSuicide="%o silenced herself."
	MaleSuicide="%o silenced himself."
	bFastInstantHit=True
	VehicleDamageScaling=0.150000

	TagMultiplier=0.7
	TagDuration=0.1
}
