//=============================================================================
// DTBOGPGrenade.
//
// Damage type for the BOGP grenade.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTTOPORSmokeGrenade extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k concussed %o without having the grenade exploding."
     DeathStrings(1)="%o's brain is leaking with borscht thanks to %k's concussive Topor."
     DeathStrings(2)="%k thumped %o in the noggin with an undetonated Topor 'nade."
	 DeathStrings(3)="%o got a concussive nutcracker from %k's Topor."
     InvasionDamageScaling=2.000000
     WeaponClass=Class'BWBP_SKC_Pro.ThumperGrenadeLauncher'
     DeathString="%o devoured a grenade launched from %k's Topor."
     FemaleSuicide="%o swallowed her own Topor grenade."
     MaleSuicide="%o swallowed his own Topor grenade."
     bDelayedDamage=True
}
