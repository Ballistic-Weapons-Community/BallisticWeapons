//=============================================================================
// DTA73Skrith.
//
// Damage type for A73 projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA73SkrithPower extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k burned a hole through %o with the A73."
     DeathStrings(1)="%o was scorched in half by %k's A73."
     DeathStrings(2)="%o saw the light of %k's A73."
     DeathStrings(3)="%k lit up %o with the A73."
     DeathStrings(4)="%k's sapphire energy stream effortlessly pierced %o."
     SimpleKillString="A73 Power Shot"
     BloodManagerName="BallisticProV55.BloodMan_A73Burn"
     FlashThreshold=0
     FlashV=(X=400.000000,Y=400.000000,Z=1000.000000)
     FlashF=-0.100000
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",Plasma,"
     bOnlySeverLimbs=True
     WeaponClass=Class'BallisticProV55.A73SkrithRifle'
     DeathString="%k burned a hole through %o with the A73."
     FemaleSuicide="%o's A73 turned on her."
     MaleSuicide="%o's A73 turned on him."
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
}
