//=============================================================================
// DTMRS138Gas.
//
// Damage type for T10 clouds
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMRS138Gas extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o choked out in cloud of %k's tear gas."
     DeathStrings(1)="%k gassed out an insubordinate %o ."
     DeathStrings(2)="%o was subdued by %k's MRS tear gas."
     DeathStrings(3)="%k's MRS-138 gassed out %o's rebellion."
     DeathStrings(4)="%o's riot was cut short by %k's MRS gas slug."
     FemaleSuicides(0)="%o took a whiff of her own gas."
     FemaleSuicides(1)="%o didn't want to share her tear gas."
     FemaleSuicides(2)="%o got lost in her own tear gas cloud."
     FemaleSuicides(3)="%o huffed one of her tear gas shells."
     MaleSuicides(0)="%o took a whiff of his own gas."
     MaleSuicides(1)="%o didn't want to share his tear gas."
     MaleSuicides(2)="%o got lost in his own tear gas cloud."
     MaleSuicides(3)="%o huffed one of his tear gas shells."
     FlashThreshold=0
     FlashV=(Y=8000.000000)
     FlashF=1.000000
     bDetonatesBombs=False
     bIgnoredOnLifts=True
     DamageIdent="Grenade"
     DamageDescription=",Gas,GearSafe,Hazard,"
     MinMotionBlurDamage=1.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=6.000000
     bUseMotionBlur=True
     WeaponClass=Class'BallisticProV55.MRS138Shotgun'
     DeathString="%o choked out in cloud of %k's tear gas."
     FemaleSuicide="%o took a whiff of her own gas."
     MaleSuicide="%o took a whiff of his own gas."
     bArmorStops=False
     bLocationalHit=False
     bCausesBlood=False
     bDelayedDamage=True
     bNeverSevers=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.000000
}
