//=============================================================================
// DTA42SkrithBeam.
//
// Damage type for A42 beams
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA42SkrithBeam extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was struck down by the hand of %k."
     DeathStrings(1)="%o was speared by %k's plasma lance."
     SimpleKillString="A42 Skrith Charged"
     BloodManagerName="BallisticProV55.BloodMan_A73Burn"
     DamageIdent="Pistol"
     DamageDescription=",Plasma,Laser,"
     WeaponClass=Class'BallisticProV55.A42SkrithPistol'
     DeathString="%k enlightened %o with A42 fire."
     FemaleSuicide="%o's A42 fused her into a corpse."
     MaleSuicide="%o's A42 fused him into a corpse."
     bExtraMomentumZ=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
     VehicleMomentumScaling=0.200000
}
