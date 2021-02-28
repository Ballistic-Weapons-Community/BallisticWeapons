//=============================================================================
// DT_SK410.
//
// Damage type for the HE SK410 shells
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_SK410Slug extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o blasted off like a rocket courtesy of %k's SK-410 slug."
     DeathStrings(1)="%o caught %k's SK-410 slug right in the chops."
     bNegatesMomentum=True
     InvasionDamageScaling=1.500000
     DamageIdent="Shotgun"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBP_SKC_Pro.SK410Shotgun'
     DeathString="%o blasted off like a rocket courtesy of %k's SK-410 slug."
     FemaleSuicide="%o amputated a foot with the SK410"
     MaleSuicide="%o removed some toes with his SK410."
     bDelayedDamage=True
     bExtraMomentumZ=True
     GibPerterbation=2.000000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.600000
}
