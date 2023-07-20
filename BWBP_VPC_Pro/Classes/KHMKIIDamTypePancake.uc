//=============================================================================
//The Squashed damage type for the KH MarkII Cobra.
//

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//=============================================================================
class KHMKIIDamTypePancake extends BE_VDT_Manager
	abstract;

defaultproperties
{
     DeathStrings(0)="%o squealed like a pig when trapped under %k's landing bars."
     DeathStrings(1)="%o was pinned down by %k's landing bars."
     DeathStrings(2)="%o got pasted to the ground by %k's landing bars."
     FemaleSuicides(0)="%o got her moronic self trapped under her own landing bars."
     FemaleSuicides(1)="%o got rolled on by her own Cobra."
     FemaleSuicides(2)="%o wasn't watching the skies for the Cobra she abandoned."
     MaleSuicides(0)="%o got his moronic self trapped under his own landing bars."
     MaleSuicides(1)="%o got rolled on by his own Cobra."
     MaleSuicides(2)="%o wasn't watching the skies for the Cobra he abandoned."
     MessageSwitchBase=3
     NumMessages=2
     bArmorStops=False
     bAlwaysGibs=True
     GibPerterbation=1.000000
}
