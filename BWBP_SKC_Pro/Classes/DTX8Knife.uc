//=============================================================================
// DTX8Knife.
//
// Damagetype for X8 Knife
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX8Knife extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k chopped %o up into little delicious bits."
     DeathStrings(1)="%o sprung a few leaks thanks to %k's X8."
     DeathStrings(2)="%k viciously slit %o's throat with an X8."
     DeathStrings(3)="%o's daily stroll was interrupted by %k's stabbing spree."
     DamageDescription=",Slash,Stab,"
     WeaponClass=Class'BWBP_SKC_Pro.X8Knife'
     DeathString="%k chopped %o up into little delicious bits."
     FemaleSuicide="%o fell on her X8 knife."
     MaleSuicide="%o fell on his X8 knife."
     bArmorStops=False
	 BlockFatiguePenalty=0.1
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.500000
}
