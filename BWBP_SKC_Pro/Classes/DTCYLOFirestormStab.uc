//=============================================================================
// DTCYLOFirestormStab.
//
// Damagetype for the incendiary pyromancer's blade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCYLOFirestormStab extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%o tripped into %k's CYLO blade."
     DeathStrings(1)="%o was shredded by %k's bladed CYLO."
     DeathStrings(2)="%k's CYLO ripped into defenseless %o."
     DamageIdent="Melee"
     DamageDescription=",Stab,"
     WeaponClass=Class'BWBP_SKC_Pro.CYLOUAW'
     DeathString="%o tripped into %k's CYLO blade."
     FemaleSuicide="%o cut herself on her CYLO."
     MaleSuicide="%o cut himself on his CYLO."
     bNeverSevers=True
	 BlockFatiguePenalty=0.25
     PawnDamageSounds(0)=Sound'BW_Core_WeaponSound.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.500000
}
