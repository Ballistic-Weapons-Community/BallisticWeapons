//=============================================================================
// DTA49Skrith.
//
// Damage type for A49 projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA49Skrith extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k's A49 burned %o's corpse away."
     DeathStrings(1)="%o was charred and cauterized by %k's A49."
     DeathStrings(2)="%k turned %o's legs to drumsticks with an A49."
     DeathStrings(3)="%k's blue plasma burned away %o's head."
     BloodManagerName="BallisticProV55.BloodMan_A73Burn"
     InvasionDamageScaling=1.500000
     DamageIdent="SMG"
     WeaponClass=Class'BWBPRecolorsPro.A49SkrithBlaster'
     DeathString="%k's A49 burned %o's corpse away."
     FemaleSuicide="%o's A49 melted her feet to the ground."
     MaleSuicide="%o's A49 melted his feet to the ground."
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
     VehicleMomentumScaling=0.500000
}
