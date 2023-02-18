//=============================================================================
// DTFM13ShotgunHead.
//
// Damage type for FM13
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_TrenchFireHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k melted %o's helmet and head into molten slag."
     DeathStrings(1)="%o got his neck ripped out by by %k's Trenchgun."
     DeathStrings(2)="%o took a whole facial of %k's dragon breath shells."
     DeathStrings(3)="%k's let his Trenchgun make a meal out of %o's face."
     bHeaddie=True
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_OP_Pro.TrenchGun'
     DeathString="%k uncorked %o with the Trenchgun."
     FemaleSuicide="%o nailed herself with the Trenchgun."
     MaleSuicide="%o nailed himself with the Trenchgun."
	 bIgniteFires=True
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
