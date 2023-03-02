//=============================================================================
// DTJunkBPHammer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkBPHammer extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k pounded on %o's breaking body with %kh BP Hammer."
     DeathStrings(1)="%o was hammered into a pile by %k's Ball Peen."
     DeathStrings(2)="%k snapped %kh Ball Peen hammer into %o's wild-eyed face."
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClawHammer'
     DeathString="%k hammered %o into submission."
     FemaleSuicide="%o cracked herself with a BP."
     MaleSuicide="%o cracked himself with a BP."
}
