//=============================================================================
// DTJunkNeonLightStabSec.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkNeonLightStabSec extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k skewered %o with a shattered neon light."
     DeathStrings(1)="%o was impaled on %k's broken neon light."
     ShieldDamage=15
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkNeonBrokenSec'
     DeathString="%k skewered %o with a shattered neon light."
     FemaleSuicide="%o cracked herself with a neon light."
     MaleSuicide="%o cracked himself with a neon light."
}
