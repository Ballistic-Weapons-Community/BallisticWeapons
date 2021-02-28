//=============================================================================
// DTCYLOShotgunHead.
//
// Damage type for CYLO Shotgun
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCYLOShotgunHead extends DT_BWShell;

// Wishlist (*) and To do list (+):
// * Check to make sure messages are all unique and not rips from M763 or something.

defaultproperties
{
     DeathStrings(0)="%o got a face full of loving courtesy of %k's CYLO."
     DeathStrings(1)="%k blew %o's face off with %kh CYLO shotgun."
     DeathStrings(2)="%o wondered what the bottom barrel of %k's CYLO did."
     SimpleKillString="CYLO UAW Shotgun"
     bHeaddie=True
	 InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBPRecolorsPro.CYLOUAW'
     DeathString="%o got a face full of loving courtesy of %k's CYLO."
     FemaleSuicide="%o perforated herself with the CYLO."
     MaleSuicide="%o perforated himself with the CYLO."
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
