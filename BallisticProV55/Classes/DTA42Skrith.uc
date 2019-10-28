//=============================================================================
// DTA42Skrith.
//
// Damage type for A42 projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA42Skrith extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k enlightened %o with A42 fire."
     DeathStrings(1)="%k fused %o into a corpse."
     SimpleKillString="A42 Skrith Plasma"
     BloodManagerName="BallisticProV55.BloodMan_A73Burn"
     DamageIdent="Pistol"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BallisticProV55.A42SkrithPistol'
     DeathString="%k enlightened %o with A42 fire."
     FemaleSuicide="%o's A42 fused her into a corpse."
     MaleSuicide="%o's A42 fused him into a corpse."
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
     VehicleMomentumScaling=0.200000
}
