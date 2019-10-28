//=============================================================================
// DTCYLOShotgun.
//
// Damage type for CYLO Shotgun
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCYLOShotgun extends DT_BWShell;

// Wishlist (*) and To do list (+):
// * Check to make sure messages are all unique and not rips from M763 or something.

defaultproperties
{
     DeathStrings(0)="%o didn't realize %k's CYLO had a shotgun."
     DeathStrings(1)="%k finished off %o with %kh CYLO shotgun."
     DeathStrings(2)="%o was maimed by %k's CYLO 12 gauge."
     SimpleKillString="CYLO UAW Shotgun"
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBPRecolorsPro.CYLOUAW'
     DeathString="%o didn't realize %k's CYLO had a shotgun."
     FemaleSuicide="%o perforated herself with the CYLO."
     MaleSuicide="%o perforated himself with the CYLO."
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
}
