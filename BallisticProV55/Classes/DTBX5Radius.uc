//=============================================================================
// DTBX5Radius.
//
// Damage type for the BX5 land mine.
// Anti-vehicle, and deadly at it.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBX5Radius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o jumped onto %k's BX5 mine."
     DeathStrings(1)="%o tried to stamp out %k's BX5."
     DeathStrings(2)="%o was mined by %k."
     DeathStrings(3)="%o didn't quite spot %k's mine."
     WeaponClass=Class'BallisticProV55.BX5Mine'
     DeathString="%o jumped onto %k's BX5 Mine."
     FemaleSuicide="%o tripped on her own mine."
     MaleSuicide="%o tripped on his own mine."
     bDelayedDamage=True
     VehicleDamageScaling=3.000000
     VehicleMomentumScaling=3.000000
}
