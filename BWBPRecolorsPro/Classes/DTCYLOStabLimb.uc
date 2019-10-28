//=============================================================================
// DTCYLOStabLimb.
//
// Damagetype for the CYLO bayonette attack to limbs
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCYLOStabLimb extends DT_BWBlade;

// Wishlist (*) and To do list (+):
// * Check to make sure messages are all unique and not rips from A73 or something.

defaultproperties
{
     DeathStrings(0)="%o almost fended off %k's CYLO."
     DeathStrings(1)="%o tried to kick %k's CYLO."
     DeathStrings(2)="%k stuck %kh CYLO blade into %o's forearm."
     DamageDescription=",Stab,"
     WeaponClass=Class'BWBPRecolorsPro.CYLOUAW'
     DeathString="%o almost fended off %k's CYLO."
     FemaleSuicide="%o cut herself on her CYLO."
     MaleSuicide="%o cut himself on his CYLO."
     bArmorStops=False
     PawnDamageSounds(0)=Sound'BallisticSounds2.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
}
