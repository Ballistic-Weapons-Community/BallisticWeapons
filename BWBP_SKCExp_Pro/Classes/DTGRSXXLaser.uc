//=============================================================================
// DTGRS9Laser.
//
// DT for GRS9 laser non-headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTGRSXXLaser extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o discovered %k's flailing GRS-XX laser."
     DeathStrings(1)="%k intensified %o to a crisp."
     DeathStrings(2)="%o flailed and thrashed through %k's death beam."
     DeathStrings(3)="%k cross-examined %o with %kh GRS-XX laser."
     SimpleKillString="GRS-XX Laser"
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     DamageIdent="Sidearm"
     DamageDescription=",Laser,"
     WeaponClass=Class'BWBP_SKCExp_Pro.GRSXXPistol'
     DeathString="%o discovered %k's flailing GRS-XX laser."
     FemaleSuicide="%o tripped and thrashed through her own death beam."
     MaleSuicide="%o tripped and thrashed through his own death beam."
     bInstantHit=True
     GibModifier=4.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.200000
}
