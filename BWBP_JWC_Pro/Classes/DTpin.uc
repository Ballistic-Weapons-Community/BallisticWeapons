//=============================================================================
// DTpin.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTpin extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o got striked by %k."
     DeathStrings(1)="%k didn't know how to play bowling so %ke just smashed %o with a pin."
     DeathStrings(2)="%o didn't use bowling shoes and couldn't glide away to escape %k's pin attack."
     ShieldDamage=10
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkGearLever'
     DeathString="%o was shifted apart by %k's pin."
     FemaleSuicide="%o hit herself with a pin."
     MaleSuicide="%o hit himself with a pin."
}
