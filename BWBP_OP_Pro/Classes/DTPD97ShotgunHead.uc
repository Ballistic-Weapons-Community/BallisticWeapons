//=============================================================================
// DTPD97ShotgunHead.
//
// Damage type for PD97 Shotgun
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPD97ShotgunHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o got a face full of loving courtesy of %k's PD97."
     DeathStrings(1)="%k blew %o's face off with %kh PD97 shotgun."
     DeathStrings(2)="%o wondered what the bottom barrel of %k's PD97 did."
     SimpleKillString="PD97 Shotgun"
     bHeaddie=True
	 InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_OP_Pro.PD97Bloodhound'
     DeathString="%o got a face full of loving courtesy of %k's PD97."
     FemaleSuicide="%o perforated herself with the PD97."
     MaleSuicide="%o perforated himself with the PD97."
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
