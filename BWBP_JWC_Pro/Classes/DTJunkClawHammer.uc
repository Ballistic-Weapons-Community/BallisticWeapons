//=============================================================================
// DTJunkClawHammer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkClawHammer extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k hammered %o into submission."
     DeathStrings(1)="%o found the wrong end of %k's claw hammer."
     DeathStrings(2)="%o was pounded open by a hammer crazed %k."
     ShieldDamage=25
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClawHammer'
     DeathString="%k hammered %o into submission."
     FemaleSuicide="%o cracked herself with a claw hammer."
     MaleSuicide="%o cracked himself with a claw hammer."
}
