//=============================================================================
// DThatpin.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHatpin extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k pinned  %o."
     DeathStrings(1)="%k thought %o was some kind of fancy hat."
     DeathStrings(2)="%o was perforated by %k's hatpin."
     DeathStrings(3)="%o was killed by %k's hatpin."
     ShieldDamage=2
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriver'
     DeathString="%k punctured %o into sponge with %kh hatpin."
     FemaleSuicide="%o cracked herself with a hatpin."
     MaleSuicide="%o cracked himself with a hatpin."
}
