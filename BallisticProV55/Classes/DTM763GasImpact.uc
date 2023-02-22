//=============================================================================
// DTM763GasImpact.
//
// Damage type for the HE SK410 shells
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM763GasImpact extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k put down %o's riot with a direct slug shot."
     DeathStrings(1)="%o ate the gas slug %k sent %vh way."
     bNegatesMomentum=True
     InvasionDamageScaling=1.500000
     DamageIdent="Shotgun"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BallisticProV55.M763Shotgun'
     DeathString="%k put down %o's riot with a direct slug shot."
     FemaleSuicide="%o ended her own riot"
     MaleSuicide="%o ended his own riot."
     bDelayedDamage=True
     bExtraMomentumZ=True
     GibPerterbation=2.000000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.600000
}
