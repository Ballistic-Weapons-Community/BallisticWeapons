//=============================================================================
// DT_HVCFisher.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_HVCFisher extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k fished %o out of the water with %kh lightning gun"
     DeathStrings(1)="%o swam too near lightning-crazy %k."
     DeathStrings(2)="%k blew %o out of the water with a depth charge."
     DeathStrings(3)="%k did %kh electric eel impression on %o."
     FemaleSuicides(0)="%o found a stingray."
     FemaleSuicides(1)="%o tried some lightning fishing and blew herself to hell."
     FemaleSuicides(2)="%o fished herself out of the water."
     FemaleSuicides(3)="%o successfully made a flashbang."
     MaleSuicides(0)="%o found a stingray."
     MaleSuicides(1)="%o tried some lightning fishing and blew himself to hell."
     MaleSuicides(2)="%o fished himself out of the water."
     MaleSuicides(3)="%o successfully made a flashbang."
     BloodManagerName="BallisticProV55.BloodMan_Blunt"
     FlashThreshold=0
     FlashV=(X=800.000000,Y=800.000000,Z=2000.000000)
     bIgniteFires=True
     DamageDescription=",Electro,GearSafe,Hazard,"
     WeaponClass=Class'BallisticProV55.HVCMk9LightningGun'
     DeathString="%k fished %o out of the water with %kh lightning gun."
     FemaleSuicide="%o found a stingray."
     MaleSuicide="%o found a stingray."
     bInstantHit=True
     bCauseConvulsions=True
     GibModifier=2.000000
     GibPerterbation=0.700000
     KDamageImpulse=20000.000000
}
