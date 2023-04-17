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
     DeathStrings(0)="%k's boltcaster slagged a fleeing %o."
     DeathStrings(1)="%o was hunted by %k's boltcaster."
     DeathStrings(2)="%o was slain by %k's AY90 Wyvern."
     DeathStrings(3)="%k gave %o a lethal glow up with the AY90."
     DeathStrings(4)="%k's Wyvern took chunks out of %o."
     SimpleKillString="AY90 Radius"
	 BloodManagerName="BallisticProV55.BloodMan_A73Burn"
     bIgniteFires=True
     bOnlySeverLimbs=True
     DamageDescription=",Flame,Plasma,"
     WeaponClass=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'
     DeathString="%k's boltcaster slagged a fleeing %o."
     FemaleSuicide="%o's own Wyvern ate her."
     MaleSuicide="%o's own Wyvern ate him."
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.900000
     bDelayedDamage=True
}
