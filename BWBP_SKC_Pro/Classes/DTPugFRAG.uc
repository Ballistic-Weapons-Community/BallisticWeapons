//=============================================================================
// DTSRACFrag.
//
// DamageType for the autocannon direct hits
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPugFRAG extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k's made %o cry to death with some tear gas."
     DeathStrings(1)="%o suffocated with tears and %k's gas."
     DeathStrings(2)="%k made sure %o can't rebel thanks to the tear gas."
     DeathStrings(3)="%o was forced to stop resisting forever due to %k."
     WeaponClass=Class'BWBP_SKC_Pro.PUGAssaultCannon'
     DeathString="%k's Pug terminated %o with extreme prejudice."
     FemaleSuicide="%o launched a FRAG-12 and ran screaming after it."
     MaleSuicide="%o ran screaming into the path of his own FRAG-12."
     bDelayedDamage=True
     VehicleDamageScaling=0.900000
}
