//=============================================================================
// DT_RSNovaLightning.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM7A3Tazer extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o got shocked by %k's M7A3 tazer."
     DeathStrings(1)="%k defibrillated %o with a M7A3 tazer."
     DeathStrings(2)="%o got zapped hard by %k's pistol tazer."
     SimpleKillString="M7A3 Tazer"
     BloodManagerName="BallisticProV55.BloodMan_NovaLightning"
     FlashThreshold=0
     FlashV=(Z=350.000000)
     FlashF=0.700000
     ShieldDamage=15
     bIgniteFires=True
     DamageIdent="Sidearm"
     DamageDescription=",Electro,"
     WeaponClass=Class'BWBP_JCF_Pro.M7A3AssaultRifle'
     DeathString="%o got shocked by %k's M7A3 tazer."
     FemaleSuicide="%o struck herself."
     MaleSuicide="%o struck himself."
     bInstantHit=True
     bLocationalHit=False
     bCauseConvulsions=True
     bNeverSevers=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     KDamageImpulse=20000.000000
}
