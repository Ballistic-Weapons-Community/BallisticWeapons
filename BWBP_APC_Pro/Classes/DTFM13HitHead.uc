//=============================================================================
// DTFM13HitHead.
//
// Damagetype for M763 Melee attack to the head
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFM13HitHead extends DTFM13Hit;

defaultproperties
{
     DeathStrings(0)="%k smashed %kh FM13 into %o's face."
     DeathStrings(1)="%o headbutted %k in the shotgun."
     DeathStrings(2)="%k swatted a bug off %o's head using the FM13."
     DeathStrings(3)="%o's head moved in the way of %k's speeding FM13."
     DeathString="%k smashed the FM13 into %o's face."
     FemaleSuicide="%o swatted a fly on her head using the FM13."
     MaleSuicide="%o swatted a fly on his head using the FM13."
	 BlockFatiguePenalty=0.25
}
