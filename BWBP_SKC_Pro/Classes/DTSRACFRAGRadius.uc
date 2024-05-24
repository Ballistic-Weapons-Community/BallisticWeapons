//=============================================================================
// DTSRACFRAGRadius.
//
// DamageType for the autocannon radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSRACFRAGRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o couldn't run from %k's SRAC-21/G Autocannon."
     DeathStrings(1)="%o was pulverized by %k's SRAC-21/G Autocannon."
     DeathStrings(2)="%k tastefully removed %o's feet with an autocannon."
     DeathStrings(3)="%k's autocannon introduced %o to the FRAG-12."
     FemaleSuicides(0)="%o viciously blew up her feet."
     FemaleSuicides(1)="%o happily autocannoned some nearby walls."
     FemaleSuicides(2)="%o mistook her SRAC for something less explosive."
     MaleSuicides(0)="%o viciously blew up his feet."
     MaleSuicides(1)="%o happily autocannoned a nearby wall."
     MaleSuicides(2)="%o mistook his SRAC for something less explosive."
     SimpleKillString="SKAS FRAG-12"
     InvasionDamageScaling=2
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBP_SKC_Pro.SKASShotgun'
     DeathString="%o couldn't run from %k's SRAC-21/G Autocannon."
     FemaleSuicide="%o forgot that FRAG-12s explode."
     MaleSuicide="%o forgot that FRAG-12s explode."
     bDelayedDamage=True
     VehicleDamageScaling=0.300000
     VehicleMomentumScaling=0.400000
}
