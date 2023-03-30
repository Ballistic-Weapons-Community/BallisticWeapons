//=============================================================================
// DTE23Plasma.
//
// Damage type for E23 projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTE5Plasma extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o got pricked by %k's miniature viper, it still was lethal."
     DeathStrings(1)="%k's plasma pistol might be small, but still burned a hole through %o's thorax."
     DeathStrings(2)="%o got bit by %k's viper in the leg, not even a plasma amputation could save them."
     DeathStrings(3)="%k eventually put %o to rest after blasting them with a plasma pistol repeatedly."
     DeathStrings(4)="%o ran into all of %k's small bolts of plasma doom."
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",Plasma,"
     bOnlySeverLimbs=True
     WeaponClass=Class'BWBP_APC_Pro.E5PlasmaRifle'
     DeathString="%k melted a burning hole through %o with the E-5 ViPeR."
     FemaleSuicide="%o's ASP bit her in half."
     MaleSuicide="%o's ASP bit him in half."
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
}
