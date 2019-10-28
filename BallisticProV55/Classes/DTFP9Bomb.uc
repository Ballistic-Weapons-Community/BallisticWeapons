//=============================================================================
// DTFP9Bomb.
//
// Damage type for the FP9 bombs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFP9Bomb extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k slapped a bomb into %o's face."
     DeathStrings(1)="%o was hit over the head by %k's bomb."
     BloodManagerName="BallisticProV55.BloodMan_BluntSmall"
     bDetonatesBombs=False
     InvasionDamageScaling=3.000000
     DamageIdent="Grenade"
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BallisticProV55.FP9Explosive'
     DeathString="%k slapped a bomb into %o's face."
     FemaleSuicide="%o stubbed her toe on her own bomb."
     MaleSuicide="%o stubbed his toe on his own bomb."
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=2.000000
     VehicleMomentumScaling=2.000000
}
