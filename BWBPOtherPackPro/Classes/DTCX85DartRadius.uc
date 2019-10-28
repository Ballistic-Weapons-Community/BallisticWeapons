//=============================================================================
// DTM46GrenadeRadius.
//
// Damage type for the Proximity Grenade fired from the M46
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCX85DartRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was blown up from afar by %k's remote detonation darts."
     DeathStrings(1)="%k's nasty plot took %o out with convenience."
     DeathStrings(2)="%o got his butt blasted by %k's CX85 explosion."
     SimpleKillString="CX85 Dart Detonation"
     bDetonatesBombs=False
     InvasionDamageScaling=2.000000
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBPOtherPackPro.CX85AssaultWeapon'
     DeathString="%o was blown up from afar by %k's remote detonation darts."
     FemaleSuicide="%o MESSED herself UP with her CX85."
     MaleSuicide="%o RUINED his shit with his CX85."
     bDelayedDamage=True
}
