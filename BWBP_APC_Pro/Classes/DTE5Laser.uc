//=============================================================================
// DTVPRLaser.
//
// DT for VPR laser non-headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTE5Laser extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o had %vh lower spine beamed in half by %k's ASP."
     DeathStrings(1)="%k carved %kh name in %o's stomach with a mini plasma pistol."
     DeathStrings(2)="%o's fingers made for good finger food for %k's viper."
     DeathStrings(3)="%o took %k's small but potent beam to the groin."
     DeathStrings(4)="%k burrowed a decent sized hole into %o's belly despite %kh pistol being miniature."
     SimpleKillString="E-5 'ViPeR' Laser"
     AimedString="Scoped"
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",Laser,"
     WeaponClass=Class'BWBP_APC_Pro.E5PlasmaRifle'
     DeathString="%o was burnt in two by %k's sacred fire."
     FemaleSuicide="%o accidentally scorched her own legs off with the E-5 laser."
     MaleSuicide="%o accidentally scorched his own legs off with the E-5 laser."
     bInstantHit=True
     GibModifier=4.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.750000
     VehicleMomentumScaling=0.750000
}
