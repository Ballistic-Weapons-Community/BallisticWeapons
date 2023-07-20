//=============================================================================
// DTJunkMachete.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkMachete extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k sliced up %o with a machete."
     DeathStrings(1)="%o couldn't escape %k's rampaging machete."
     BloodManagerName="BallisticFix.BloodMan_Slash"
     ShieldDamage=25
     DamageDescription=",Slash,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkMachete'
     DeathString="%k sliced up %o with a machete."
     FemaleSuicide="%o sliced herself with a machete."
     MaleSuicide="%o slice himself with a machete."
     bNeverSevers=False
}
