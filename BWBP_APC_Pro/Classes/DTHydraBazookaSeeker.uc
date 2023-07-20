//=============================================================================
// DTHydraBazooka.
//
// DamageType for the Hydra Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHydraBazookaSeeker extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o ran so far away, only to be annihilated by %k's lock on rockets."
     DeathStrings(1)="%k made sure that %o couldn't escape from the cacophony of explosions."
     DeathStrings(2)="%o tried to hide, but it was fruitless as %ve were reduced to a puddle by %k's Hydra."
     DeathStrings(3)="%k's rockets tracked %o down and devastated %vm to the point of no return."
     InvasionDamageScaling=3.000000
     DamageIdent="Ordnance"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=100
     AimDisplacementDuration=0.700000
     WeaponClass=Class'BWBP_APC_Pro.HydraBazooka'
     DeathString="%o was blown to pieces by %k's Hydra."
     FemaleSuicide="%o splattered the walls with her gibs using a Hydra."
     MaleSuicide="%o splattered the walls with his gibs using a Hydra."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     VehicleMomentumScaling=1.500000
}
