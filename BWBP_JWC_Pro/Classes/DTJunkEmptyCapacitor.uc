//=============================================================================
// DTJunkEmptyCapacitor.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkEmptyCapacitor extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k bludgeoned %o to death with an empty capacitor."
     DeathStrings(1)="%o got capped by %k."
     DeathStrings(2)="%o found %k's empty capacitor."
     ShieldDamage=25
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkEmptyCapacitor'
     DeathString="%k hammered %o into submission."
     FemaleSuicide="%o cracked herself with an empty capacitor."
     MaleSuicide="%o cracked himself with an empty capacitor."
}
