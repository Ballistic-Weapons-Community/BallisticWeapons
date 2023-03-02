//=============================================================================
// DTJunkScythe.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkScythe extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k harvested the flesh off %o's body."
     DeathStrings(1)="%o was cut down to size by %k's scythe."
     DeathStrings(2)="%o slashed %vs with %k's shimmering scythe."
     BloodManagerName="BallisticFix.BloodMan_Slash"
     ShieldDamage=85
     DamageDescription=",Slash,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScythe'
     DeathString="%k harvested the flesh off %o's body."
     FemaleSuicide="%o harvested herself with a scythe."
     MaleSuicide="%o harvested himself with a scythe."
     bNeverSevers=False
}
