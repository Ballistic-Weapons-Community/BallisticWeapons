//=============================================================================
// DT_HVCOverheat.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_HVCOverheat extends DT_BWMiscDamage;

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
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     FlashThreshold=0
     FlashV=(X=2000.000000,Y=600.000000,Z=600.000000)
     FlashF=0.100000
     ShieldDamage=15
     bIgniteFires=True
     DamageDescription=",Electro,Hazard,"
     WeaponClass=Class'BallisticProV55.HVCMk9LightningGun'
     DeathString="%o was overheated by %k."
     FemaleSuicide="%o forgot to release the trigger of her HVC."
     MaleSuicide="%o forgot to release the trigger of his HVC."
     bInstantHit=True
     bCauseConvulsions=True
     bCausesBlood=False
     bFlaming=True
     GibModifier=1.500000
     DamageOverlayMaterial=Shader'BallisticEpicEffects.PlayerShaders.PlayerTransRed'
     DamageOverlayTime=0.900000
     GibPerterbation=0.400000
     KDamageImpulse=20000.000000
}
