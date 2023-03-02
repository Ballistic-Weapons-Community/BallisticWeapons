//=============================================================================
// DTJunkShank.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkShank extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k scrapped %o with a jagged shank."
     DeathStrings(1)="%o was torn apart in a fury by %k's prison issue."
     DeathStrings(2)="%o cut %vs apart all over %k's bloody shank."
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkShankHit'
     DeathString="%k scrapped %o with a jagged shank."
     FemaleSuicide="%o cracked herself with a shank."
     MaleSuicide="%o cracked himself with a shank."
}
