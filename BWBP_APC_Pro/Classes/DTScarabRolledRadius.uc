//=============================================================================
// DTScarabRolledRadius.
//
// Damage type for the Rolled NRP57 Grenade radius damage
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTScarabRolledRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k rolled a pineapple into %o's town."
     DeathStrings(1)="%o tripped on %k's patroling pineapple."
     InvasionDamageScaling=3.000000
     DamageIdent="Grenade"
     WeaponClass=Class'BWBP_APC_Pro.ScarabGrenade'
     DeathString="%k rolled a pineapple into %o's town."
     FemaleSuicide="%o blew herself apart with a pineapple."
     MaleSuicide="%o blew himself apart with a pineapple."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     VehicleMomentumScaling=0.350000
}
