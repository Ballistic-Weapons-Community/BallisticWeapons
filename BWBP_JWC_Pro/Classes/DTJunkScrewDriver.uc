//=============================================================================
// DTJunkScrewDriver.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkScrewDriver extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k punctured %o into sponge with %kh screw driver."
     DeathStrings(1)="%o got %vs ruptured on %k's brand new screw driver."
     ShieldDamage=15
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriver'
     DeathString="%k punctured %o into sponge with %kh screw driver."
     FemaleSuicide="%o cracked herself with a screw driver."
     MaleSuicide="%o cracked himself with a screw driver."
}
