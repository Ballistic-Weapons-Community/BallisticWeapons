//=============================================================================
// DTBOGPGrenade.
//
// Damage type for the BOGP grenade.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTTOPORSmokeGrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k concussed %o so hard that they began to speak Russian before collapsing."
     DeathStrings(1)="%o drank too much, %k's concussion 'nade didn't help matters."
     DeathStrings(2)="%k knocked %o around like a pinball before their neck snapped from the various impacts."
     DeathStrings(3)="%o was sent to the gulags by %k's concussion grenades."
	 InvasionDamageScaling=2.000000
     WeaponClass=Class'BWBP_SKC_Pro.ThumperGrenadeLauncher'
     DeathString="%o devoured a grenade launched from %k's Topor."
     FemaleSuicide="%o swallowed her own Topor grenade."
     MaleSuicide="%o swallowed his own Topor grenade."
     bDelayedDamage=True
}
