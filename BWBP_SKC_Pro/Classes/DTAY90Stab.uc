//=============================================================================
// DTA73bStab.
//
// Damagetype for the A73b bayonette attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAY90Stab extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%o was impaled on the blades of %k's Elite AY90."
     DeathStrings(1)="%o was split like a pear by %k's Elite AY90 blades."
     DeathStrings(2)="%k skewered %o with the Elite AY90."
     DamageDescription=",Stab,"
     WeaponClass=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'
     DeathString="%o was impaled on the blades of %k's Elite AY90."
     FemaleSuicide="%o cut herself on her Elite AY90."
     MaleSuicide="%o cut himself on his Elite AY90."
     bArmorStops=False
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'BW_Core_WeaponSound.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.500000
}
