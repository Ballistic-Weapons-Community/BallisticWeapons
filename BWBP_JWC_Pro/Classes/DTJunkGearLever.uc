//=============================================================================
// DTJunkGearLever.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkGearLever extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o was shifted apart by %k's gear lever."
     DeathStrings(1)="%k broke %o with a gear lever."
     ShieldDamage=10
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkGearLever'
     DeathString="%o was shifted apart by %k's gear lever."
     FemaleSuicide="%o hit herself with a gear lever."
     MaleSuicide="%o hit himself with a gear lever."
}
