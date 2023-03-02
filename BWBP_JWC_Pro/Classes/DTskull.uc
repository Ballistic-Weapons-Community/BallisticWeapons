//=============================================================================
// DTskull.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTskull extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="A skull crushed %o's skull."
     DeathStrings(1)="%k continued someone else's killstreak on %o's head."
     DeathStrings(2)="%k found a skull and decided to bludgeon %o with it."
     ShieldDamage=2
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
     DeathString="%k threw a skull at %o."
     FemaleSuicide="%o threw a skull at herself."
     MaleSuicide="%o threw a skull at himself."
     VehicleDamageScaling=0.000000
}
