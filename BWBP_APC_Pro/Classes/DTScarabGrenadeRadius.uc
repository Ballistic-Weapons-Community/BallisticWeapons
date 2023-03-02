//=============================================================================
// DTScarabGrenadeRadius.
//
// Damage type for the NRP57 Grenade radius damage
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTScarabGrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o discovered one of %k's lurking pineapples."
     DeathStrings(1)="%k's pineapple crawled it's way into %o's path."
     DeathStrings(2)="%o couldn't get enough of %k's pineapple delight."
     InvasionDamageScaling=3.000000
     DamageIdent="Grenade"
     WeaponClass=Class'BWBP_APC_Pro.ScarabGrenade'
     DeathString="%o discovered one of %k's lurking pineapples."
     FemaleSuicide="%o blew herself apart with a pineapple."
     MaleSuicide="%o blew himself apart with a pineapple."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     VehicleMomentumScaling=0.350000
}
