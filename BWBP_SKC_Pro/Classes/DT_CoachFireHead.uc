//=============================================================================
// DT_CoachFireHead.
//
// Damage type for Coach Trench FM13 Flamer whatever
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_CoachFireHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o’s face was literally melted off by %k’s hot shot."
     DeathStrings(1)="%k bruleed %o’s face to the point it was burnt to a crisp."
     DeathStrings(2)="%o singed their tongue, nose, heck, the whole face after being too close to %k’s trenchgun."
     DeathStrings(3)="%k exposed the skull of %o with just one easy white hot shot to the dome."
     DeathStrings(4)="%o’s had their hair set ablaze before their whole head melted off due to %k."
     bHeaddie=True
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_SKC_Pro.CoachGun'
     DeathString="%o singed their tongue, nose, heck, the whole face after being too close to %k’s trenchgun."
     FemaleSuicide="%o roasted themselves with a dragon’s breath shell."
     MaleSuicide="%%o roasted themselves with a dragon’s breath shell."
	 bIgniteFires=True
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
