//=============================================================================
// DTSRACFRAGRadius.
//
// DamageType for the autocannon radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPugFRAGRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k's made %o cry to death with some tear gas."
     DeathStrings(1)="%o suffocated with tears and %k's gas."
     DeathStrings(2)="%k made sure %o can't rebel thanks to the tear gas."
     DeathStrings(3)="%o was forced to stop resisting forever due to %k."
     FemaleSuicides(0)="%o viciously blew up her feet."
     FemaleSuicides(1)="%o happily autocannoned some nearby walls."
     FemaleSuicides(2)="%o mistook her Autocannon for something less explosive."
     MaleSuicides(0)="%o viciously blew up his feet."
     MaleSuicides(1)="%o happily autocannoned a nearby wall."
     MaleSuicides(2)="%o mistook his Autocannon for something less explosive."
     WeaponClass=Class'BWBP_SKC_Pro.PUGAssaultCannon'
     DeathString="%o couldn't run from %k's Autocannon."
     FemaleSuicide="%o forgot that FRAG-12s explode."
     MaleSuicide="%o forgot that FRAG-12s explode."
     bDelayedDamage=True
     VehicleDamageScaling=0.300000
     VehicleMomentumScaling=0.400000
}
