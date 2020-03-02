//=============================================================================
// DTFP7Grenade.
//
// Damage type for the FP7 Grenade hit
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTARGrenade extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k blasted a RCS-715 grenade directly into %o's helpless body."
     SimpleKillString="RCS-715 Grenade Impact"
     BloodManagerName="BallisticProV55.BloodMan_BluntSmall"
     bDetonatesBombs=False
     bIgnoredOnLifts=True
     InvasionDamageScaling=2.000000
     DamageIdent="Grenade"
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BallisticJiffyPack.ARShotgun'
     DeathString="%k blasted a RCS-715 grenade directly into %o's helpless body."
     FemaleSuicide="%o layed a RCS-715 grenade at her own feet."
     MaleSuicide="%o layed a RCS-715 grenade at his own feet."
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
}
