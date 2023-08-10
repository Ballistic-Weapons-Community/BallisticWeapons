//=============================================================================
// DTM806ShotgunHead.
//
// Damage type for M806 Shotgun Headders
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM806ShotgunHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o got a face full of buck from %k's M806 attachment."
     DeathStrings(1)="%k blew %o's face off with %kh M806 shotgun."
     DeathStrings(2)="%o got a face to face with %k's M806 shotgun."
     SimpleKillString="M806 Shotgun"
     bHeaddie=True
	 InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BallisticProV55.M806Pistol'
     DeathString="%o got a face full of buck from %k's M806 attachment."
     FemaleSuicide="%o perforated herself with the M806."
     MaleSuicide="%o perforated himself with the M806."
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
