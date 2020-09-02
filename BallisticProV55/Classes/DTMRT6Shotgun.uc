//=============================================================================
// DTMRT6Shotgun.
//
// Damage type for MRT6
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMRT6Shotgun extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k blasted %kh way through %o with the MRT-6."
     DeathStrings(1)="%o found out what %k was packing."
     DeathStrings(2)="%o was ordained by %k's MRT-6."
     DeathStrings(3)="%o was blindsided by %k's MRT-6."
     DeathStrings(4)="%k outfitted %o with MRT-6 pellets."
     DeathStrings(5)="%o was mortified by %k."
     InvasionDamageScaling=2
     DamageIdent="Sidearm"
     WeaponClass=Class'BallisticProV55.MRT6Shotgun'
     DeathString="%k blasted %kh way through %o with the MRT-6."
     FemaleSuicide="%o blasted herself with the MRT-6."
     MaleSuicide="%o blasted himself with the MRT-6."
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
     VehicleDamageScaling=0.200000
     VehicleMomentumScaling=0.600000
}
