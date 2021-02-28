//=============================================================================
// DTEagleMeleeHead.
//
// Headshot pistol whip!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTEagle250MeleeHead extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k rammed %kh AH250 into %o's skull."
     DeathStrings(1)="%o got a faceful of %k's AH250 handle."
     DeathStrings(2)="%k wiped the smile off %o's face with %kh AH250 handle."
     DeathStrings(3)="%k gave %o a backhanded slap with %kh AH250."
     DamageIdent="Sidearm"
	 BlockFatiguePenalty=0.15
     WeaponClass=Class'BWBP_SKC_Pro.AH250Pistol'
     DeathString="%k rammed %kh AH250 into %o's skull."
     FemaleSuicide="%o headbutted her own AH250."
     MaleSuicide="%o headbutted his own AH250."
}
