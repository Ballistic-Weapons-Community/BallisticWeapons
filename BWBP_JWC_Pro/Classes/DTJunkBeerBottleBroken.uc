//=============================================================================
// DTJunkBeerBottleBroken.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkBeerBottleBroken extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k cut %o down with a broken beer bottle."
     DeathStrings(1)="%o was torn to death by %k's beer bottle."
     DeathStrings(2)="%k once again showed %o how a bar-fight works."
     ShieldDamage=10
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkBeerBottleStab'
     DeathString="%k cut %o down with a broken beer bottle."
     FemaleSuicide="%o cracked herself with a beer bottle."
     MaleSuicide="%o cracked himself with a beer bottle."
}
