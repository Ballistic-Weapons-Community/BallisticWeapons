//=============================================================================
// DT_Nuke.
//
// NUKES. NUKES EVERYWHERE. You done got hit by one.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_Nuke extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o had a very brief and exciting time as %k's nuclear ground zero."
     DeathStrings(1)="%o was the happy recipient of %k's 10-ton nuclear yield."
     DeathStrings(2)="%k gave %o quite the atomic punch."
     WeaponClass=Class'BWBP_KFC_DE.M807Pistol'
     DeathString="%k gave %o quite the atomic punch."
     FemaleSuicide="%o attempted to stop a nuclear war and caught her own missile."
     MaleSuicide="%o attempted to stop a nuclear war and caught his own missile."
     bSuperWeapon=True
     bDelayedDamage=True
     VehicleDamageScaling=7.200000
     bAlwaysGibs=True
     bLocationalHit=False
     bAlwaysSevers=True
     GibPerterbation=4.000000
}
