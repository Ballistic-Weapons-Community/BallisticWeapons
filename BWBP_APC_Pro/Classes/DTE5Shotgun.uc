//=============================================================================
// DTE23Plasma.
//
// Damage type for E23 projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTE5Shotgun extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o fell down after taking %k's ring of plasma bolts to the chest."
     DeathStrings(1)="%k was in spitting distance to spit some plasma bolts towards %o."
     DeathStrings(2)="%o has several scorching holes as a gift from %k."
     DeathStrings(3)="%k's viper sunk it's fangs into %o's ribcage."
	 DeathStrings(4)="%o's limbs atrophied after getting bit by %k."
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",Plasma,"
     bOnlySeverLimbs=True
     WeaponClass=Class'BWBP_APC_Pro.E5PlasmaRifle'
     DeathString="%k melted a burning hole through %o with the E-5 ViPeR."
     FemaleSuicide="%o's ViPeR bit her in half."
     MaleSuicide="%o's ViPeR bit him in half."
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
}
