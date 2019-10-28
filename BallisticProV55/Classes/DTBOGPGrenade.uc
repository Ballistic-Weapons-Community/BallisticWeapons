//=============================================================================
// DTBOGPGrenade.
//
// Damage type for the BOGP grenade.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBOGPGrenade extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o devoured a grenade launched from %k's grenade pistol."
     DeathStrings(1)="%k launched a grenade down %o's open mouth."
     DeathStrings(2)="%o headbutted %k's BORT grenade."
     InvasionDamageScaling=2.000000
     DamageIdent="Pistol"
     WeaponClass=Class'BallisticProV55.BOGPPistol'
     DeathString="%o devoured a grenade launched from %k's BORT-85."
     FemaleSuicide="%o swallowed her own BORT grenade."
     MaleSuicide="%o swallowed his own BORT grenade."
     bDelayedDamage=True
}
