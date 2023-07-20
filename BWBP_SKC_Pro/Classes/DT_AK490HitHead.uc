//=============================================================================
// DT_AK490HitHead.
//
// Damagetype for AK490 Melee attack to the head
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AK490HitHead extends DT_AK490Hit;

defaultproperties
{
     bHeaddie=True
	 BlockFatiguePenalty=0.25
     DeathString="%k RAGED LIKE BEAR and beat %o's face with an AK!"
     FemaleSuicide="A drunken %o beat herself with her AK490."
     MaleSuicide="A drunken %o beat himself with his AK490."
}
