//=============================================================================
// DTMRT6ShotgunHead.
//
// Damage type for MRT6 head shots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMRT6ShotgunHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o saw eye to eye with %k's MRT-6."
     DeathStrings(1)="%k's MRT-6 went off in %o's face."
     DeathStrings(2)="%o's head exploded with %k's MRT-6 pellets."
     DeathStrings(3)="%k showed %o the light at the end of two tunnels."
     bHeaddie=True
     InvasionDamageScaling=2
     DamageIdent="Sidearm"
     WeaponClass=Class'BallisticProV55.MRT6Shotgun'
     DeathString="%o saw eye to eye with %k's MRT-6."
     FemaleSuicide="%o blasted herself with the MRT-6."
     MaleSuicide="%o blasted himself with the MRT-6."
     bAlwaysSevers=True
     bSpecial=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
     VehicleDamageScaling=0.200000
     VehicleMomentumScaling=0.700000
}
