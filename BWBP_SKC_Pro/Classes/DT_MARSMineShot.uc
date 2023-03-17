//=============================================================================
// DT_MARSMineShot.
//
// DamageType for jerk faces who shoot the poor defenseless MARS mine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MARSMineShot extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k hastened %o's death with a MARS shock combo."
     DeathStrings(1)="%k prematurely detonated the MARS mine %o was playing with."
     DeathStrings(2)="%k's impromptu MARS shock combo vaporized %o."

     FemaleSuicides(0)="%o took out her anger on her MARS mine."
     FemaleSuicides(1)="%o successfully combined bullets and volatile shock mines."
     FemaleSuicides(2)="%o tried to stop the MARS mine at her feet by shooting it."
     FemaleSuicides(3)="%o had the great idea to shoot a MARS-3 shockwave grenade."
     MaleSuicides(0)="%o took out his anger on his MARS mine."
     MaleSuicides(1)="%o successfully combined bullets and volatile shock mines."
     MaleSuicides(2)="%o tried to stop the MARS mine at his feet by shooting it."
     MaleSuicides(3)="%o had the great idea to shoot a MARS-3 shockwave grenade."

     WeaponClass=Class'BWBP_SKC_Pro.MARSAssaultRifle'
     SimpleKillString="MARS-2 Pulse Grenade"
     DeathString="%o hastened %o's death with a MARS shock combo."
     FemaleSuicide="%o took out her anger on her MARS mine."
     MaleSuicide="%o took out his anger on his MARS mine."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     VehicleMomentumScaling=0.800000
}
