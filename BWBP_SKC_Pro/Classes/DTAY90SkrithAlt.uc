//=============================================================================
// DTA73BSkrith.
//
// Damage type for A73B projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAY90SkrithAlt extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k divided %o into fourths with his boltcaster."
     DeathStrings(1)="%o was split 50/50 due to %k's vulture."
     DeathStrings(2)="%k's Vulture ripped %o in halves so as not to waste food."
     DeathStrings(3)="%o rode %k's plasma wave til he perished."
     BloodManagerName="BWBP_SKC_Pro.BloodMan_A73B"
     bIgniteFires=True
	 bAlwaysSevers=True
     DamageDescription=",Flame,Plasma,"
     WeaponClass=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'
     DeathString="%k fused parts of %o with the AY90."
     FemaleSuicide="%o's AY90 turned on her."
     MaleSuicide="%o's AY90 turned on him."
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.900000
}
