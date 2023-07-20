//=============================================================================
// DTBOGPGrenadeRadius.
//
// Damage type for the BOGP grenade.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTTOPORGrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k boiled over %o's blood with too much explosives, splattering all over the place."
     DeathStrings(1)="%o failed their reflex test, they exploded into borscht by %k's Topor."
	 DeathStrings(2)="%k only had one grenade for %o, yet it was enough to destroy their ambitions and body."
	 DeathStrings(3)="%o took the ZTV express straight into a wall thanks to %k."
	 DeathStrings(4)="%k ravaged %o's motherland and corpse with just one Topor Grenade."
     InvasionDamageScaling=2.000000
     WeaponClass=Class'BWBP_SKC_Pro.ThumperGrenadeLauncher'
     DeathString="%o was shattered by %k's Topor grenade."
     FemaleSuicide="%o painted herself on the wall with a Topor grenade."
     MaleSuicide="%o painted himself on the wall with a Topor grenade."
     bDelayedDamage=True
}
