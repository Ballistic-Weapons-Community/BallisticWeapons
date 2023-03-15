//=============================================================================
// DTBOGPGrenade.
//
// Damage type for the BOGP grenade.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTTOPORGrenade extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k rationed a Topor grenade right up %o's butt."
     DeathStrings(1)="%o had their liver ruptured by %k before the vodka destroyed it."
     DeathStrings(2)="%k knocked out %o with a Topor grenade, better than then the vodka."
	 DeathStrings(3)="%o's chest cavity was shattered like the union thanks to %k."
     InvasionDamageScaling=2.000000
     WeaponClass=Class'BWBP_SKC_Pro.ThumperGrenadeLauncher'
     DeathString="%o devoured a grenade launched from %k's Topor."
     FemaleSuicide="%o swallowed her own TOPOR grenade."
     MaleSuicide="%o swallowed his own TOPOR grenade."
     bDelayedDamage=True
}
