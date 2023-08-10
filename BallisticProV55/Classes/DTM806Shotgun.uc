//=============================================================================
// DTM806Shotgun.
//
// Damage type for M806 Underbarrel Shotgun
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM806Shotgun extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o didn't realize %k's M806 had a shotgun."
     DeathStrings(1)="%k finished off %o with %kh M806 underbarrel shotgun."
     DeathStrings(2)="%o was blown away by %k's M806 16 gauge."
     SimpleKillString="M806 Shotgun"
     DamageIdent="Shotgun"
	 InvasionDamageScaling=2
     WeaponClass=Class'BallisticProV55.M806Pistol'
     DeathString="%o didn't realize %k's M806 had a shotgun."
     FemaleSuicide="%o perforated herself with the M806."
     MaleSuicide="%o perforated himself with the M806."
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
}
