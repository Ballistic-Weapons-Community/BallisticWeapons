//=============================================================================
// DTLS14Overheat
//
// DT for Laser Carbine overheating.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTLS14Overheat extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was overheated by %k."
     DeathStrings(1)="%k overcharged %kh lightning gun in %o's face."
     FemaleSuicides(0)="%o forgot to release the trigger of her HVC."
     FemaleSuicides(1)="%o obliterated herself with her overcharged lightning gun."
     FemaleSuicides(2)="%o's lightning gun blew up in her face."
     MaleSuicides(0)="%o forgot to release the trigger of his HVC."
     MaleSuicides(1)="%o obliterated himself with his overcharged lightning gun."
     MaleSuicides(2)="%o's lightning gun blew up in his face."
     SimpleKillString="LS-14 Overheat"
     SimpleSuicideString="LS-14 Overheat"
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     FlashThreshold=0
     FlashV=(X=400.000000,Y=400.000000,Z=800.000000)
     FlashF=0.100000
     ShieldDamage=20
     bIgniteFires=True
     DamageDescription=",Electro,Hazard,"
     WeaponClass=Class'BWBP_SKC_Pro.LS14Carbine'
     DeathString="%o's lungs were turned to ashes by %k's laser carbine."
     FemaleSuicide="%o cannot use a carbine effectively."
     MaleSuicide="%o stinks at using laser carbines."
     bInstantHit=True
     bCauseConvulsions=True
     bCausesBlood=False
     bFlaming=True
     GibModifier=1.500000
     GibPerterbation=0.400000
     KDamageImpulse=20000.000000
}
