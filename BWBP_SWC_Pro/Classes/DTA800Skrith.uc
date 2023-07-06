//=============================================================================
// DTA73Skrith.
//
// Damage type for A73 projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA800Skrith extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k burned a hole through %o with the Hyperblaster."
     DeathStrings(1)="%o was scorched in half by %k's Hyperblaster."
     DeathStrings(2)="%o saw the light of %k's Hyperblaster."
     DeathStrings(3)="%k lit up %o with the Hyperblaster."
     BloodManagerName="BallisticProV55.BloodMan_A73Burn"
	 SimpleKillString="A800 Power Bomb"
     bIgniteFires=True
     DamageDescription=",Plasma,"
     bOnlySeverLimbs=True
     WeaponClass=Class'BWBP_SWC_Pro.A800SkrithMinigun'
     DeathString="%k burned a hole through %o with the Hyperblaster."
     FemaleSuicide="%o's Hyperblaster turned on her."
     MaleSuicide="%o's Hyperblaster turned on him."
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.750000
}
