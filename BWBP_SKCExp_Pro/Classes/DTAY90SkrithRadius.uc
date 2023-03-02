//=============================================================================
// DTA73BSkrith.
//
// Damage type for A73B projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAY90SkrithRadius extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k burned a hole through %o with the AY90."
     DeathStrings(1)="%o was scorched in half by %k's AY90."
     DeathStrings(2)="%o saw the light of %k's AY90."
     DeathStrings(3)="%k lit up %o with the AY90."
     DeathStrings(4)="%k's sapphire energy stream effortlessly pierced %o."
     SimpleKillString="AY90 Radius"
     BloodManagerName="BWBP_SKCExp_Pro.BloodMan_A73B"
     bIgniteFires=True
     bOnlySeverLimbs=True
     DamageDescription=",Flame,Plasma,"
     WeaponClass=Class'BWBP_SKCExp_Pro.AY90SkrithBoltcaster'
     DeathString="%k fused parts of %o with the AY90."
     FemaleSuicide="%o's AY90 turned on her."
     MaleSuicide="%o's AY90 turned on him."
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.900000
}
