//=============================================================================
// DTLS14Body
//
// DT for Laser Carbine body shots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTLS14Twin extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k pasted %o with his twin LS-14 barrels."
     DeathStrings(1)="%k's twin LS-14 barrels destroyed %o."
     DeathStrings(2)="%k's LS-14 directed a deluge of photons through %o."
     DeathStrings(3)="%o was roasted by %k's twin LS-14 blast."
     SimpleKillString="LS-14 Double Barrel"
     BloodManagerName="BloodMan_HMCLaser"
     ShieldDamage=3
     bIgniteFires=True
     bSnipingDamage=True
     InvasionDamageScaling=2.000000
     DamageIdent="Sniper"
     DamageDescription=",Laser,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=2.000000
     WeaponClass=Class'BWBP_SKC_Pro.LS14Carbine'
     DeathString="%o's lungs were turned to ashes by %k's laser carbine."
     FemaleSuicide="%o cannot use a carbine effectively."
     MaleSuicide="%o stinks at using laser carbines."
     bInstantHit=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
     VehicleMomentumScaling=0.400000
}
