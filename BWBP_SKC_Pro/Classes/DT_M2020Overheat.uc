//=============================================================================
// DT_M2020Pwr.
//
// DamageType for the M2020 gauss shot suicide
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2003 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_M2020Overheat extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was overheated by %k."
     FemaleSuicides(0)="%o polarized herself."
     FemaleSuicides(1)="%o obliterated herself with her overcharged DMR."
     FemaleSuicides(2)="%o's DMR blew up in her face."
     MaleSuicides(0)="%o polarized himself."
     MaleSuicides(1)="%o obliterated himself with his overcharged DMR."
     MaleSuicides(2)="%o's DMR blew up in his face."
     SimpleKillString="M2020 Gauss DMR Overheat"
     SimpleSuicideString="M2020 Gauss DMR Overheat"
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     FlashThreshold=0
     FlashV=(X=400.000000,Y=400.000000,Z=800.000000)
     FlashF=0.100000
     ShieldDamage=30
     bIgniteFires=True
     DamageDescription=",Electro,Hazard,"
     WeaponClass=Class'BWBP_SKC_Pro.M2020GaussDMR'
     DeathString="%o was overheated by %k."
     FemaleSuicide="%o polarized herself."
     MaleSuicide="%o polarized himself."
     bInstantHit=True
     bCauseConvulsions=True
     bCausesBlood=False
     bFlaming=True
     GibModifier=1.500000
     GibPerterbation=0.400000
     KDamageImpulse=20000.000000
}
