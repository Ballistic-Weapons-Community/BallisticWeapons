//=============================================================================
// DTslow.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTslow extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k turned %o into a sieve."
     DeathStrings(1)="%o got some new holes now."
     DeathStrings(2)="%k killed %o after slowing %vm down."
     DeathStrings(3)="%k's viper shuriken turned %o into a slug and poured salt on him."
     ShieldDamage=2
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriver'
     DeathString="%k punctured %o into sponge with %kh viper shuriken."
     FemaleSuicide="%o cracked herself with a viper shuriken."
     MaleSuicide="%o cracked himself with a viper shuriken."
}
