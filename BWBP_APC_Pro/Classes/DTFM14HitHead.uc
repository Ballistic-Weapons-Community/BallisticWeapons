//=============================================================================
// DTFM13HitHead.
//
// Damagetype for M763 Melee attack to the head
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFM14HitHead extends DTFM14Hit;

defaultproperties
{
     DeathStrings(0)="%k smashed %kh FM14 into %o's face."
     DeathStrings(1)="%o headbutted %k in the shotgun."
     DeathStrings(2)="%k swatted a bug off %o's head using the FM14."
     DeathStrings(3)="%o's head moved in the way of %k's speeding FM14."
     DeathString="%k smashed the FM14 into %o's face."
     FemaleSuicide="%o swatted a fly on her head using the FM14."
     MaleSuicide="%o swatted a fly on his head using the FM14."
	 BlockFatiguePenalty=0.25
}
