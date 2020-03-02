//=============================================================================
// DTFP7Immolation.
//
// Damage type for players caught alight by the FP7
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTARImmolation extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o was set ablaze by %k's RCS-715 grenade."
	 DeathStrings(1)="%o was immolated by %k's RCS-715 grenade."
	 DeathStrings(2)="%k demonstrated their firebending skills on %o with their RCS-715 grenade."
     SimpleKillString="RCS-715 Grenade Immolation"
     bIgnoredOnLifts=True
     InvasionDamageScaling=2.000000
     DamageIdent="Grenade"
     WeaponClass=Class'BallisticJiffyPack.ARShotgun'
     DeathString="%o was set ablaze by %k's RCS-715 grenade."
     FemaleSuicide="%o ran around like a maniac in a ball of fire."
     MaleSuicide="%o ran around like a maniac in a ball of fire."
     bSkeletize=True
     bDelayedDamage=True
     GibPerterbation=0.100000
     KDamageImpulse=200.000000
}
