//=============================================================================
// DTXM84AfterShock.
//?/ a/sf/ a/s/ Headache grenades!
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXM84AfterShock extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o's brain was reduced to goo by %k's XM84."
     DeathStrings(1)="%k's XM84 slowly liquidized %o's fragile brain."
     DeathStrings(2)="%o painfully succumbed to %k's XM84 aftershock."
     FlashThreshold=0
     FlashF=-1.250000
     FlashV=(X=1900.000000,Y=1900.000000,Z=2000.000000)
     AltFlashF=-4.000000
	 AltFlashV=(X=1.000000,Y=1.000000,Z=1200.000000)
     bDetonatesBombs=False
	 bArmorStops=False
     DamageIdent="Grenade"
	 InvasionDamageScaling=3
     DamageDescription=",Gas,GearSafe,Hazard,"
     MinMotionBlurDamage=1.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=3.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBP_SKC_Pro.XM84Flashbang'
     DeathString="%o's brain was reduced to goo by %k's XM84."
     FemaleSuicide="%o succumbed to her own tech grenade."
     MaleSuicide="%o succumbed to his own tech grenade."
     bInstantHit=True
     bCausesBlood=False
     bDelayedDamage=True
     bNeverSevers=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.001000
     KDamageImpulse=90000.000000
     VehicleMomentumScaling=0.000000
}
