//=============================================================================
// DTM1911TrackerStuck.
//
// Damage type for sadly dying to a tracker dart. Ouch.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM1911TrackerStuck extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k pinned the tracker dart on the %o."
     DeathStrings(1)="%o's corpse has a new tracker dart thanks to %k."
     DeathStrings(2)="%k's proximity grenade latched onto %o's flapping ear."
     SimpleKillString="RS04 Tracker Dart"
     bDetonatesBombs=False
     InvasionDamageScaling=2.000000
     DamageIdent="Grenade"
     WeaponClass=Class'BWBP_SKC_Pro.RS04Pistol'
     DeathString="%k's tracker dart lodged in %o's eye."
     FemaleSuicide="%o had a terrible tracker dark accident."
     MaleSuicide="%o is the reason why tracker darts are banned in the civillian market."
     bDelayedDamage=True
}
