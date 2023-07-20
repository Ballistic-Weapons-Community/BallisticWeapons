//=============================================================================
// DTJunkWineGlass.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkWineGlass extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o recieved a faceful of glass from %k."
     DeathStrings(1)="%o was cracked down by %k's wine glass."
     ShieldDamage=0
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkGlassSmallBreak'
     DeathString="%o recieved a faceful of glass from %k."
     FemaleSuicide="%o cracked herself with a wine glass."
     MaleSuicide="%o cracked himself with a wine glass."
}
