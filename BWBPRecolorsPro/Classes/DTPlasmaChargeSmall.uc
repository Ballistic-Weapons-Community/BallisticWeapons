//=============================================================================
// DTDT.
//
// HV-PC Alt
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPlasmaChargeSmall extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k turned %o into Swiss cheese with plasma."
     DeathStrings(1)="%o accepted %k's offering of plasma."
     DeathStrings(2)="%k turned %kh H-VPC on %o."
     DeathStrings(3)="%k's H-VPC gave %o a lethal dose."
     BloodManagerName="BloodMan_HVPC"
     bIgniteFires=True
     DamageIdent="Streak"
     DamageDescription=",Plasma,"
     bOnlySeverLimbs=True
     WeaponClass=Class'BWBPRecolorsPro.HVPCMk66PlasmaCannon'
     DeathString="%k turned %o into Swiss cheese with plasma."
     FemaleSuicide="%o shot off her toes."
     MaleSuicide="%o shot off his toes."
     bFlaming=True
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.500000
     VehicleMomentumScaling=0.750000
}
