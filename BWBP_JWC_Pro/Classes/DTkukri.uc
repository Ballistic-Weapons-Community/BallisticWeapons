//=============================================================================
// Kukri.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTKukri extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k cut through %o's limbs with a kukri."
     DeathStrings(1)="%k's kukri did a good job cutting through %o."
     DeathStrings(2)="%o's head met %k's kukri."
     DeathStrings(3)="%k's kukri vs. %o. Kukri wins."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=25
     DamageDescription=",Slash,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkMachete'
     DeathString="%k sliced up %o with a kukri."
     FemaleSuicide="%o sliced herself with a Kukri."
     MaleSuicide="%o slice himself with a Kukri."
     bNeverSevers=False
}
