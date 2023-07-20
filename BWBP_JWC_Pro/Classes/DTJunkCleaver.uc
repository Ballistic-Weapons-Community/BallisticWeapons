//=============================================================================
// DTJunkCleaver.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkCleaver extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o was cut like a piece of meat by %k's cleaver."
     DeathStrings(1)="%k chopped %o real good with %kh cleaver."
     DeathStrings(2)="%o got %vs cleaved open by a butchering %k."
     BloodManagerName="BallisticFix.BloodMan_Slash"
     DamageDescription=",Slash,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCleaver'
     DeathString="%o was cut like a piece of meat by %k's cleaver."
     FemaleSuicide="%o cleaved herself with a cleaver."
     MaleSuicide="%o cleaved himself with a cleaver."
     bNeverSevers=False
}
