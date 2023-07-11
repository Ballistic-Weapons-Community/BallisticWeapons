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
     DeathStrings(1)="%k overcharged %kh LS14 in %o's face."
     FemaleSuicides(0)="%o blew the capacitors on her LS14."
     FemaleSuicides(1)="%o pushed her LS14 past its limits."
     FemaleSuicides(2)="%o's LS14 went critical."
     MaleSuicides(0)="%o blew the capacitors on his LS14."
     MaleSuicides(1)="%o pushed his LS14 past its limits."
     MaleSuicides(2)="%o's LS14 went critical."
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
