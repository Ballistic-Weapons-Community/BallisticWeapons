//=============================================================================
// DTM290Shotgun.
//
// Damage type for M290
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM290Shotgun extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k blasted two pounds of lead into %o with the M290."
     DeathStrings(1)="%o was blown into a ball by %k's M290."
     DeathStrings(2)="%o was atoned by %k's double barreled shotgun."
     InvasionDamageScaling=1.500000
     DamageIdent="Shotgun"
     WeaponClass=Class'BallisticProV55.M290Shotgun'
     DeathString="%k blasted two pounds of lead into %o with the M290."
     FemaleSuicide="%o nailed herself with the M290."
     MaleSuicide="%o nailed himself with the M290."
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
     VehicleDamageScaling=0.500000
}
