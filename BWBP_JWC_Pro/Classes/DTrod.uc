//=============================================================================
// DTrod.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTrod extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k cooked %o with an immersion heater."
     DeathStrings(1)="%k burned %o with an immersion heater."
     DeathStrings(2)="An immersion heater brought death to %o."
     ShieldDamage=10
     bIgniteFires=True
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkGearLever'
     DeathString="%o was shifted apart by %k's immersion heater."
     FemaleSuicide="%o hit herself with an immersion heater."
     MaleSuicide="%o hit himself with an immersion heater."
}
