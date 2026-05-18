//=============================================================================
// DTPKMRPG.
//
// Damage type for RPK projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPKMRPG extends DTG5Bazooka;

defaultproperties

{
     DeathStrings(0)="%o was blown to pieces by %k's RPG."
     DeathStrings(1)="%o caught %k's RPG rocket."
     DeathStrings(2)="%k launched %kh RPG rocket into %o's face."
     InvasionDamageScaling=3.000000
     DamageIdent="Ordnance"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=100
     AimDisplacementDuration=0.50
     WeaponClass=Class'BWBP_APC_Pro.PKMMachinegun'
     DeathString="%o was blown to pieces by %k's RPG."
     FemaleSuicide="%o splattered the walls with her gibs using a RPG."
     MaleSuicide="%o splattered the walls with his gibs using a RPG."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     VehicleMomentumScaling=1.500000
}