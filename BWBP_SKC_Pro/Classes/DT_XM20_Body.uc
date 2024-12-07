//=============================================================================
// DTXM20ody
//
// DT for Laser Carbine body shots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_XM20_Body extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o melted away in a brilliant storm of %k's laser carbine."
     DeathStrings(1)="%k's laser assault rifle burned %o to the ground."
     DeathStrings(2)="%o was left a smoldering heap thanks to %k's XM-20."
     DeathStrings(3)="%k murdered %o with frickin' lasers."
     DeathStrings(4)="%o's heart melted when %k gave %vm the gift of AUTOMATIC LASERS."
     SimpleKillString="XM20 Laser Carbine"
     BloodManagerName="BloodMan_HMCLaser"
     ShieldDamage=3
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",Laser,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=2.000000
     WeaponClass=Class'BWBP_SKC_Pro.XM20Carbine'
     DeathString="%o melted away in a brilliant storm of %k's laser carbine."
     FemaleSuicide="%o cannot use a laser assault rifle effectively."
     MaleSuicide="%o stinks at using laser assault rifles."
     bInstantHit=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
     VehicleMomentumScaling=0.400000
}