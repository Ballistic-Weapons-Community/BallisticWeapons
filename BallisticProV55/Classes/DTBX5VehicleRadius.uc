//=============================================================================
// DTBX5VehicleRadius.
//
// Damage type for the BX5 land mine when damaging vehicles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBX5VehicleRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o drove %vs into %k's mine field."
     DeathStrings(1)="%o tried to crush %k's mine with %vh tyre."
     DeathStrings(2)="%o rolled %vh vehicle into %k's mine."
     DeathStrings(3)="%o was peering out the window as %vh vehicle rolled into %k's mine."
     DeathStrings(4)="%o's beady little eyes didn't see %k's mine hiding in the road."
     WeaponClass=Class'BallisticProV55.BX5Mine'
     DeathString="%o drove %vs into %k's mine field."
     FemaleSuicide="%o reversed over one of her mines."
     MaleSuicide="%o reversed over one of his mines."
     bDelayedDamage=True
     VehicleDamageScaling=3.000000
     VehicleMomentumScaling=3.000000
}
