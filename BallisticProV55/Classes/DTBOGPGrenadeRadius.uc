//=============================================================================
// DTBOGPGrenadeRadius.
//
// Damage type for the BOGP grenade.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBOGPGrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was shattered by %k's BORT grenade."
     DeathStrings(1)="%k splintered %o with %kh break open grenade pistol."
     InvasionDamageScaling=2.000000
     DamageIdent="Pistol"
     WeaponClass=Class'BallisticProV55.BOGPPistol'
     DeathString="%o was shattered by %k's BORT grenade."
     FemaleSuicide="%o painted herself on the wall with a BORT grenade."
     MaleSuicide="%o painted himself on the wall with a BORT grenade."
     bDelayedDamage=True
}
