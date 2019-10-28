//=============================================================================
// DT_HVCOverheat.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA73Overheat extends DT_BWMiscDamage;

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
     SimpleKillString="A73 Skrith Rifle Overheat"
     SimpleSuicideString="A73 Skrith Rifle Overheat"
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     FlashThreshold=0
     FlashV=(X=400.000000,Y=400.000000,Z=800.000000)
     FlashF=0.100000
     ShieldDamage=15
     bIgniteFires=True
     DamageDescription=",Electro,Hazard,"
     WeaponClass=Class'BallisticProV55.A73SkrithRifle'
     DeathString="%o was overheated by %k."
     FemaleSuicide="%o's A73 burnt through her own hands."
     MaleSuicide="%o' A73 burnt through his own hands."
     bInstantHit=True
     bCauseConvulsions=True
     bCausesBlood=False
     bFlaming=True
     GibModifier=1.500000
     GibPerterbation=0.400000
     KDamageImpulse=20000.000000
}
