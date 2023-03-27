//=============================================================================
// DTHydraBazooka.
//
// DamageType for the Hydra Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHydraBazookaSwoop extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was swooped off to Hell by %k's swooping rockets."
     DeathStrings(1)="%k got around some barricades to blow %o to smithereens."
     DeathStrings(2)="%o got swept off the mortal coil thanks to %k and %kh multi-purpose Hydra."
     DeathStrings(3)="%k sweeped the floor with the blood and guts of %o."
     InvasionDamageScaling=3.000000
     DamageIdent="Ordnance"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=100
     AimDisplacementDuration=0.700000
     WeaponClass=Class'BWBP_APC_Pro.HydraBazooka'
     DeathString="%o was blown to pieces by %k's Hydra."
     FemaleSuicide="%o thought multiple rockets could be useful for a powerful rocket jump."
     MaleSuicide="%o thought multiple rockets could be useful for a powerful rocket jump."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     VehicleMomentumScaling=1.500000
}
