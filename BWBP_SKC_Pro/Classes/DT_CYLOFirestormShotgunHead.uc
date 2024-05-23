//=============================================================================
// DTFM13ShotgunHead.
//
// Damage type for FM13
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_CYLOFirestormShotgunHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k cooked %o's head to roasted perfection."
     DeathStrings(1)="%o's face was flame broiled by %k's Firestorm."
     DeathStrings(2)="%o took %k's firestorm to the face."
     DeathStrings(3)="%k's let %kh Firestorm make a charred meal out of %o's face."
     bHeaddie=True
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_SKC_Pro.CYLOUAW'
     DeathString="%k uncorked %o with the CYLO."
     FemaleSuicide="%o nailed herself with the CYLO."
     MaleSuicide="%o nailed himself with the CYLO."
	 bIgniteFires=True
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
