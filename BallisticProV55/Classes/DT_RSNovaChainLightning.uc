//=============================================================================
// DT_RSNovaChainLightning.
//
// Damage for NovaStaff chainlightning
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSNovaChainLightning extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k fried %o to a crisp with chain lightning."
     DeathStrings(1)="%o was one of the links in %k's chain lightning attack."
     DeathStrings(2)="%k incinerated %o with Nova lightning."
     SimpleKillString="Nova Chain Lightning"
     BloodManagerName="BallisticProV55.BloodMan_NovaLightning"
     FlashThreshold=0
     FlashV=(X=2000.000000,Y=2000.000000,Z=800.000000)
     FlashF=0.300000
     ShieldDamage=15
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",Electro,NovaStaff,"
     WeaponClass=Class'BallisticProV55.RSNovaStaff'
     DeathString="%k fried %o to a crisp with chain lightning."
     FemaleSuicide="%o did her Zeus impression on herself."
     MaleSuicide="%o did his Zeus impression on himself."
     bInstantHit=True
     bCauseConvulsions=True
     bNeverSevers=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     KDamageImpulse=20000.000000
}
