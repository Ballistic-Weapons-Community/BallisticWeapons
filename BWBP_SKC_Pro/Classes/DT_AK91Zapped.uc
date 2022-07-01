//=============================================================================
// DT_AK91Zapped.
//
// Damage type for AK91 zaps
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AK91Zapped extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k stopped %o's heart with an AK91."
     DeathStrings(1)="%k's AK91 shorted out %o."
     DeathStrings(2)="%o was electrocuted by %k's AK91."
     DeathStrings(3)="%o got a fatal static shock from %k's AK91."
     DeathStrings(4)="%k turned up the voltage on %o."
     WeaponClass=Class'BWBP_SKC_Pro.AK91ChargeRifle'
     DeathString="%k stopped %o's heart with an AK91."
     FemaleSuicide="%o zapped herself."
     MaleSuicide="%o zapped himself."
     BloodManagerName="BallisticFix.BloodMan_Lightning"
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
