//=============================================================================
//The Squashed damage type for the TMV Leopard.
//

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//=============================================================================

class LeopardDamTypePancake extends BE_VDT_Manager
	abstract;

defaultproperties
{
     DeathStrings(0)="%o should have looked up in case of %k's flying TMV."
     DeathStrings(1)="%o's head was shaved by %k's TMV tracks."
     DeathStrings(2)="%o got pasted to the ground by %k's TMV underside."
     FemaleSuicides(0)="%o should have been more carefull when abandoning her TMV on the edge of a precipice."
     FemaleSuicides(1)="%o got rolled on by her own TMV."
     MaleSuicides(0)="%o should have been more carefull when abandoning his TMV on the edge of a precipice."
     MaleSuicides(1)="%o got rolled on by his own TMV."
     MessageSwitchBase=3
     NumMessages=2
     bArmorStops=False
     bAlwaysGibs=True
     GibPerterbation=1.000000
}
