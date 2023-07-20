//=============================================================================
// DTJunkWrench.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkWrench extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o was plumbed by %k's rusty wrench."
     DeathStrings(1)="%k wrenched %o's head off."
     DeathStrings(2)="%o got beaten senseless by %k's wrench."
     ShieldDamage=65
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkWrench'
     DeathString="%o was plumbed by %k's rusty wrench."
     FemaleSuicide="%o cracked herself with a wrench."
     MaleSuicide="%o cracked himself with a wrench."
}
