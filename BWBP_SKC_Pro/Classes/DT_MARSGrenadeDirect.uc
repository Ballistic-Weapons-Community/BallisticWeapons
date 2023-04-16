//=============================================================================
// DT_MARSGrenadeDirect.
//
// Damage type for a direct hit from a MARS grenade, doesn't matter which type
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MARSGrenadeDirect extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k whipped a MARS grenade at %o's face."
     DeathStrings(1)="%o took %k's grenade to the face."
     DeathStrings(2)="%o successfully caught %k's MARS grenade."
     SimpleKillString="MARS Grenade Direct"
     WeaponClass=Class'BWBP_SKC_Pro.MARSAssaultRifle'
     DeathString="%k whipped a MARS2 grenade at %o's face."
     FemaleSuicide="%o amazingly caught her own MARS grenade."
     MaleSuicide="%o amazingly caught his own MARS grenade."
     bDelayedDamage=True
     VehicleDamageScaling=0.500000
}
