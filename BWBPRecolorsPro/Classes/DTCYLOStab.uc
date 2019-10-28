//=============================================================================
// DTCYLOStab.
//
// Damagetype for the CYLO bayonette attack
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCYLOStab extends DT_BWBlade;

// Wishlist (*) and To do list (+):
// * Check to make sure messages are all unique and not rips from A73 or something.

defaultproperties
{
     DeathStrings(0)="%o was slain by %k's CYLO."
     DeathStrings(1)="%o was split down the middle by %k's CYLO blade."
     DeathStrings(2)="%k cut %o down with %kh CYLO."
     DeathStrings(3)="%k viciously hacked at %o with %kh CYLO blade."
     DeathStrings(4)="%o lost %vh limbs to %k's slicing CYLO."
     DeathStrings(5)="%o got a fatal chopping from %k's CYLO."
     DamageDescription=",Stab,"
     ImpactManager=Class'BallisticProV55.IM_Fifty9Blade'
     WeaponClass=Class'BWBPRecolorsPro.CYLOUAW'
     DeathString="%o was impaled on %k's CYLO."
     FemaleSuicide="%o cut herself on her CYLO."
     MaleSuicide="%o cut himself on his CYLO."
     bArmorStops=False
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'BallisticSounds2.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.100000
}
