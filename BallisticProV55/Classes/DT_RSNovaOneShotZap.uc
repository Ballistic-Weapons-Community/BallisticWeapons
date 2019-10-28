//=============================================================================
// DT_RSNovaOneShotZap.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSNovaOneShotZap extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o felt the wrath of %k's godly lightning strike."
     DeathStrings(1)="%k struck down %o with %kh Nova strike."
     DeathStrings(2)="%o was obliterated by %k's godly lightning."
     DeathStrings(3)="%k invoked %kh heavenly powers to smite %o down."
     SimpleKillString="Nova God Strike"
     BloodManagerName="BallisticProV55.BloodMan_NovaLightning"
     FlashThreshold=0
     FlashV=(X=2000.000000,Y=2000.000000,Z=800.000000)
     FlashF=0.300000
     ShieldDamage=15
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",Electro,NovaStaff,"
     WeaponClass=Class'BallisticProV55.RSNovaStaff'
     DeathString="%o felt the wrath of %k's godly lightning strike."
     FemaleSuicide="%o struck herself down with heaven's power."
     MaleSuicide="%o struck himself down with heaven's power."
     bInstantHit=True
     bCauseConvulsions=True
     GibModifier=1.500000
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
     VehicleMomentumScaling=1.500000
}
