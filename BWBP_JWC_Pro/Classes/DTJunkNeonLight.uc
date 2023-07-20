//=============================================================================
// DTJunkNeonLight.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkNeonLight extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k smashed a neon light into %o's face."
     DeathStrings(1)="%k shattered a neon light over %o's head."
     ShieldDamage=15
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkNeonLightBreak'
     DeathString="%k smashed a neon light into %o's face."
     FemaleSuicide="%o cracked herself with a neon light."
     MaleSuicide="%o cracked himself with a neon light."
}
