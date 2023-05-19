//=============================================================================
// DTPugGas.
//
// Damage type for PUG tear gas clouds
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPugGas extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o's riot was put down by %k's tear gas."
     DeathStrings(1)="%k subdued %o with a PUG tear gas shell."
     DeathStrings(2)="%o protested into %k's PUG tear gas grenade."
     DeathStrings(3)="%k's tear gas shell ended %o's protests."
     DeathStrings(4)="%o huffed too much of %k's teargas."
     FemaleSuicides(0)="%o teargassed herself."
     FemaleSuicides(1)="%o foolishly ran into her own tear gas."
     FemaleSuicides(2)="%o caught a whiff of her own fumes."
     FemaleSuicides(3)="%o huffed too much teargas."
     MaleSuicides(0)="%o teargassed herself."
     MaleSuicides(1)="%o foolishly ran into his own tear gas."
     MaleSuicides(2)="%o caught a whiff of his own fumes."
     MaleSuicides(3)="%o huffed too much teargas."
     FlashThreshold=0
     FlashV=(Y=2000.000000)
     FlashF=0.300000
     bDetonatesBombs=False
     bIgnoredOnLifts=True
     DamageIdent="Grenade"
     DamageDescription=",Gas,GearSafe,Hazard,"
     MinMotionBlurDamage=1.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=6.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBP_SKC_Pro.PugAssaultCannon'
     DeathString="%o's riot was put down by %k's tear gas."
     FemaleSuicide="%o teargassed herself."
     MaleSuicide="%o teargassed himself."
     bArmorStops=False
     bLocationalHit=False
     bCausesBlood=False
     bDelayedDamage=True
     bNeverSevers=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.000000
}
