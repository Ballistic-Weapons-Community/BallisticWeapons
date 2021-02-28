//=============================================================================
// DTA49Shockwave.
//
// Damage type for the A49 alt fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA49Shockwave extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k sent a shockwave through %o with %kh A49."
     DeathStrings(1)="%o was blown away by %k's A49 shockwave."
     DeathStrings(2)="%o was sent flying by %k's A49."
     DeathStrings(3)="%k ruptured %o's insides with an A49 shockwave."
     DeathStrings(4)="%o was pulsed by %k."
     FlashThreshold=0
     FlashV=(X=800.000000,Y=800.000000,Z=2000.000000)
     FlashF=0.300000
     bPowerPush=True
     InvasionDamageScaling=1.500000
     DamageIdent="SMG"
     MinMotionBlurDamage=1.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=1.000000
     WeaponClass=Class'BWBPRecolorsPro.A49SkrithBlaster'
     DeathString="%k sent a shockwave through %o with %kh A49."
     FemaleSuicide="%o shockwaved her face off."
     MaleSuicide="%o shockwaved his face off."
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
     VehicleMomentumScaling=3.000000
}
