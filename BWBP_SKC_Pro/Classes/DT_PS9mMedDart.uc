//=============================================================================
// DT_PS9mMedDart.
//
// DamageType for the PS9m Medical dart secondary fire
// Deus Ex for the win
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_PS9mMedDart extends DT_BWBlunt;

defaultproperties
{
     DamageIdent="Sidearm"
     WeaponClass=Class'BWBP_SKC_Pro.PS9mPistol'
     DeathString="%o was ironically killed by %k's health dart."
     FemaleSuicide="%o horrifyingly killed herself with a medical dart."
     MaleSuicide="%o horrifyingly killed himself with a medical dart."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.050000
}
