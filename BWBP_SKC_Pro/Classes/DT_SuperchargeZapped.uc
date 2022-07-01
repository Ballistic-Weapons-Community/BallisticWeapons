//=============================================================================
// DT_AK91Zapped.
//
// Damage type for AK91 zaps
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_SuperchargeZapped extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k stopped %o's heart with his Supercharger."
     DeathStrings(1)="%k's Supercharger shorted out %o."
     DeathStrings(2)="%o was electrocuted by %k's Supercharger."
     DeathStrings(3)="%o got a fatal static shock from %k's Supercharger."
     DeathStrings(4)="%k turned up the voltage on %o."
     WeaponClass=Class'BWBP_SKC_Pro.Supercharger_AssaultWeapon'
     DeathString="%k stopped %o's heart with an AK91."
     FemaleSuicide="%o zapped herself."
     MaleSuicide="%o zapped himself."
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     DamageDescription=",Electro,Hazard,Plasma,"
     bDetonatesBombs=False
     bIgniteFires=True
     bDelayedDamage=True
     bCauseConvulsions=True
     GibModifier=5.000000
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.400000
}
