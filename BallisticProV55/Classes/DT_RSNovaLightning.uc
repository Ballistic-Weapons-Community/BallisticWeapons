//=============================================================================
// DT_RSNovaLightning.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSNovaLightning extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was fried to a crisp by %k's Nova lightning."
     DeathStrings(1)="%k did his Zeus impression on %o."
     DeathStrings(2)="%o found %vs being electrified by %k's Nova storm."
     SimpleKillString="Nova Lightning"
     BloodManagerName="BallisticProV55.BloodMan_NovaLightning"
     FlashThreshold=0
     FlashV=(X=2000.000000,Y=2000.000000,Z=800.000000)
     FlashF=0.300000
     ShieldDamage=15
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",Electro,NovaStaff,"
     WeaponClass=Class'BallisticProV55.RSNovaStaff'
     DeathString="%o was fried to a crisp by %k's NovaStaff."
     FemaleSuicide="%o struck herself."
     MaleSuicide="%o struck himself."
     bInstantHit=True
     bCauseConvulsions=True
     bNeverSevers=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     KDamageImpulse=20000.000000
}
