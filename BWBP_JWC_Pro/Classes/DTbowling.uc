//=============================================================================
// DTbowling.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTbowling extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k scored a strike on %o's head."
     DeathStrings(1)="%k's bowling ball smashed %o's fragile skull."
     DeathStrings(2)="%k's bowling ball smash let %o die of internal bleeding."
     ShieldDamage=2
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
     DeathString="%k threw a bowling ball at %o."
     FemaleSuicide="%o threw a bowling ball at herself."
     MaleSuicide="%o threw a bowling ball at himself."
     VehicleDamageScaling=0.000000
}
