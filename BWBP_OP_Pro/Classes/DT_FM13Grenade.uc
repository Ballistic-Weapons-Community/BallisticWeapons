//=============================================================================
// DT_FM13Grenade.
//
// Damage type for the grenade fired from the FM13
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FM13Grenade extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was slugged by %k's FM13."
     DeathStrings(1)="%o intercepted %k's FM13 HE Slug."
     SimpleKillString="FM13 Grenade"
     InvasionDamageScaling=2.000000
     DamageIdent="Grenade"
     WeaponClass=Class'BWBP_OP_Pro.FM13Shotgun'
     DeathString="%o was slugged by %k's FM13."
     FemaleSuicide="%o found out her FM13 slugs explode."
     MaleSuicide="%o found out his FM13 slugs explode."
     bDelayedDamage=True
}
