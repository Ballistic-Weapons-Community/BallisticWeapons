//=============================================================================
// DT_A49Overheat.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA49OverHeat extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o shared %k's overloaded A49."
     FemaleSuicides(0)="%o short circuited some Skrith technology."
     FemaleSuicides(1)="%o overheated her A49 one too many times."
     FemaleSuicides(2)="%o happily played with damaged alien equipment."
     MaleSuicides(0)="%o short circuited some Skrith technology."
     MaleSuicides(1)="%o overheated his A49 one too many times."
     MaleSuicides(2)="%o happily played with damaged alien equipment."
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     FlashThreshold=0
     FlashV=(X=800.000000,Y=800.000000,Z=2000.000000)
     FlashF=0.500000
     bDetonatesBombs=False
     bIgniteFires=True
     InvasionDamageScaling=1.500000
     DamageIdent="SMG"
     DamageDescription=",Electro,Hazard"
     WeaponClass=Class'BWBPRecolorsPro.A49SkrithBlaster'
     DeathString="%o shared %k's overloaded A49."
     FemaleSuicide="%o short circuited some Skrith technology."
     MaleSuicide="%o short circuited some Skrith technology."
     bArmorStops=False
     bInstantHit=True
     bCauseConvulsions=True
     bFlaming=True
     GibModifier=5.000000
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.400000
     KDamageImpulse=20000.000000
}
