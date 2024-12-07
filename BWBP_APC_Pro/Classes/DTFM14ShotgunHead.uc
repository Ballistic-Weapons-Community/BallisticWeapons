//=============================================================================
// DTFM13ShotgunHead.
//
// Damage type for FM13
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFM14ShotgunHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k turned %o's gray matter bait for any aviary prey to snack on."
     DeathStrings(1)="%o had %vh skull shattered into fine dust by %k's big ass shotgun."
     DeathStrings(2)="%k’s gnasher lived up to the moniker by gnashing &o's visage off."
     DeathStrings(3)="%o’s head will be mounted on %k's wall after getting decapped by a slug."
     bHeaddie=True
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_APC_Pro.FM14Shotgun'
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
