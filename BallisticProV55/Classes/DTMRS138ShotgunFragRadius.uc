//=============================================================================
// DTMRS138ShotgunFragRadius.
//
// Damage type for MRS138 Shotgun explosive slug radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMRS138ShotgunFragRadius extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k blasted %o with an explosive MRS-138."
     DeathStrings(1)="%o was put down by %k's explosive combat shotgun."
     DeathStrings(2)="%k stopped %o's riot with an explosive MRS slug."
     DeathStrings(3)="%o was disarmed by %k's MRS-138 frag round."
     WeaponClass=Class'BallisticProV55.MRS138Shotgun'
     SimpleKillString="MRS138 FRAG"
     InvasionDamageScaling=2
     DamageIdent="Ordnance, Shotgun"
     DeathString="%k's MRS138 fragged %o."
     FemaleSuicide="%o forgot she loaded frag rounds."
     MaleSuicide="%o forgot he loaded frag rounds."
     bDelayedDamage=True
}
