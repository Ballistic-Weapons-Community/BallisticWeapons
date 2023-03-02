//=============================================================================
// DTGRS9Laser.
//
// DT for GRS9 laser non-headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHMCBlast extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was fatally shocked by %k's HMC test pulse."
     DeathStrings(1)="%k mistook %o for an HMC heat shield."
     DeathStrings(2)="%o got fried by %k's laser pulse."
     BloodManagerName="BWBP_SKCExp_Pro.BloodMan_HMCLaser"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=2.000000
     ShieldDamage=3
     bIgniteFires=True
     InvasionDamageScaling=2.500000
     DamageIdent="Energy"
     WeaponClass=Class'BWBP_SKCExp_Pro.HMCBeamCannon'
     DeathString="%o was fataly shocked by %k's HMC test pulse."
     FemaleSuicide="%o got clumsy with a military-grade photon cannon."
     MaleSuicide="%o got clumsy with a military-grade photon cannon."
     bInstantHit=True
     GibModifier=4.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=2.000000
}
