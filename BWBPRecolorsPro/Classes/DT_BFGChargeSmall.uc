//=============================================================================
// DTDT.
//
// HV-PC Alt
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_BFGChargeSmall extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k ripped into %o with a E-V HPC plasma barrage."
     DeathStrings(1)="%o was severely burned by %k's green plasma."
     DeathStrings(2)="%k's E-V HPC melted %o during a discharge."
     DeathStrings(3)="%k's Hyper Plasma Cannon overcharged %o."
     BloodManagerName="BloodMan_HVPC"
     bIgniteFires=True
     InvasionDamageScaling=1.500000
     DamageDescription=",Plasma,"
     bOnlySeverLimbs=True
     WeaponClass=Class'BWBPRecolorsPro.HVPCMk66PlasmaCannon'
     DeathString="%k ripped into %o with a E-V HPC plasma barrage."
     FemaleSuicide="%o shot off her toes."
     MaleSuicide="%o shot off his toes."
     bFlaming=True
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=3.000000
     VehicleMomentumScaling=0.750000
}
