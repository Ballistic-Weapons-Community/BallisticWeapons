//=============================================================================
// DTA73Skrith.
//
// Damage type for A73 projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPlasmaCharge extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k burned %o a new one with the H-VPC."
     DeathStrings(1)="%o was atomized in a big ball of %k's plasma."
     DeathStrings(2)="%o felt the fury of %k's H-VPC."
     DeathStrings(3)="%k's H-VPC likes %kh %o extra crispy."
     BloodManagerName="BloodMan_HVPC"
     bIgniteFires=True
     DamageIdent="Streak"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BWBP_SKC_Pro.HVPCMk66PlasmaCannon'
     DeathString="%k burned %o a new one with the H-VPC."
     FemaleSuicide="%o valiantly attacked a wall and died for it."
     MaleSuicide="%o valiantly attacked a wall and died for it."
     bFlaming=True
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.650000
     VehicleMomentumScaling=0.750000
}
