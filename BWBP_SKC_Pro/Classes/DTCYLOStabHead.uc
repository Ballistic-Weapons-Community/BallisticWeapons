//=============================================================================
// DTCYLOStabHead.
//
// Damagetype for the CYLO bayonette attack
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCYLOStabHead extends DT_BWBlade;

// Wishlist (*) and To do list (+):
// * Check to make sure messages are all unique and not rips from A73 or something.

defaultproperties
{
     DeathStrings(0)="%o was mauled by %k's CYLO."
     DeathStrings(1)="%k accidentally stabbed %kh CYLO into %o's face."
     DeathStrings(2)="%k's CYLO tried to eat %o."
     bHeaddie=True
     DamageDescription=",Stab,"
     WeaponClass=Class'BWBP_SKC_Pro.CYLOUAW'
     DeathString="%o was was mauled by %k's CYLO."
     FemaleSuicide="%o sliced her own head in half with the CYLO."
     MaleSuicide="%o sliced his own head in half with the CYLO."
     bArmorStops=False
     bAlwaysSevers=True
     bSpecial=True
	 BlockFatiguePenalty=0.25
     PawnDamageSounds(0)=Sound'BW_Core_WeaponSound.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
}
