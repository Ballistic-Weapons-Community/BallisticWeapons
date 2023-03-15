//=============================================================================
// DT_MARSMineDet.
//
// DamageType for the MARS 3 mine's final detonation
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MARSMineDet extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o ignored all the warning signs of %k's MARS mine."
     DeathStrings(1)="%o tried to pick up %k's spent MARS mine."
     DeathStrings(2)="%k's MARS mine showed %o its final trick."
     DeathStrings(3)="%o was loitering near %k's MARS shockwave grenade."
     FemaleSuicides(0)="%o tried to fetch her dying MARS mine."
     FemaleSuicides(1)="%o found out why her MARS mine had stopped pulsing."
     MaleSuicides(0)="%o tried to fetch his dying MARS mine."
     MaleSuicides(1)="%o found out why his MARS mine had stopped pulsing."
     WeaponClass=Class'BWBP_SKC_Pro.MARSAssaultRifle'
     SimpleKillString="MARS-2 Pulse Grenade"
     DeathString="%o ignored all the warning signs of %k's MARS mine."
     FemaleSuicide="%o found out why her MARS mine had stopped pulsing."
     MaleSuicide="%o found out why his MARS mine had stopped pulsing."
     bDelayedDamage=True
     VehicleDamageScaling=1.900000
     VehicleMomentumScaling=0.800000
}
