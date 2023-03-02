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
     DeathStrings(0)="%k burned a hole through %o with the Y11."
     DeathStrings(1)="%o was scorched in half by %k's Y11."
     DeathStrings(2)="%o saw the light of %k's Y11."
     DeathStrings(3)="%k lit up %o with the Y11."
     BloodManagerName="BallisticProV55.BloodMan_A73Burn"
	 SimpleKillString="Y11 Power Bomb"
     bIgniteFires=True
     DamageDescription=",Plasma,"
     bOnlySeverLimbs=True
     WeaponClass=Class'BWBP_SWC_Pro.A800SkrithMinigun'
     DeathString="%k burned a hole through %o with the Y11."
     FemaleSuicide="%o's Y11 turned on her."
     MaleSuicide="%o's Y11 turned on him."
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.750000
}
