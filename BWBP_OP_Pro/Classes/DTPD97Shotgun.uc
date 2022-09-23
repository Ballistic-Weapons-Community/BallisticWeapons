//=============================================================================
// DTPD97Shotgun.
//
// Damage type for PD97 Shotgun
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPD97Shotgun extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o didn't realize %k's PD97 had a shotgun."
     DeathStrings(1)="%k finished off %o with %kh PD97 shotgun."
     DeathStrings(2)="%o was maimed by %k's PD97 12 gauge."
     SimpleKillString="PD97 Shotgun"
     DamageIdent="Shotgun"
	 InvasionDamageScaling=2
     WeaponClass=Class'BWBP_OP_Pro.PD97Bloodhound'
     DeathString="%o didn't realize %k's PD97 had a shotgun."
     FemaleSuicide="%o perforated herself with the PD97."
     MaleSuicide="%o perforated himself with the PD97."
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
}
