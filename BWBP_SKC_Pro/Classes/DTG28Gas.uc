//=============================================================================
// DTT10Gas.
//
// Damage type for T10 clouds
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTG28Gas extends DT_BWMiscDamage;

defaultproperties
{
     bDetonatesBombs=False
     DamageDescription=",Gas,GearSafe,Hazard,"
     MinMotionBlurDamage=1.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=6.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBP_SKC_Pro.G28Grenade'
     DeathString="%o had an allergic reaction to a health grenade."
     FemaleSuicide="%o overdosed on health grenades."
     MaleSuicide="%o overdosed on health grenades."
     bArmorStops=False
     bLocationalHit=False
     bCausesBlood=False
     bDelayedDamage=True
     bNeverSevers=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.000000
}
