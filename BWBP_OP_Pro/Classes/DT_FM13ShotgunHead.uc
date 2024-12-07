//=============================================================================
// DT_FM13ShotgunHead.
//
// Damage type for FM13 headjobs
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FM13ShotgunHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k melted %o's helmet and head into molten slag."
     DeathStrings(1)="%o got his neck ripped out by by %k's Pitbull."
     DeathStrings(2)="%o took a whole facial of  %k's Pitbull breath shells."
     DeathStrings(3)="%k's let his Pitbull make a meal out of %o's face."
     bHeaddie=True
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_OP_Pro.FM13Shotgun'
     DeathString="%k uncorked %o with the FM13."
     FemaleSuicide="%o nailed herself with the FM13."
     MaleSuicide="%o nailed himself with the FM13."
	 bIgniteFires=True
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
