//=============================================================================
// DTkitchfork.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTkitchfork extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k poked %o to death with a carving fork."
     DeathStrings(1)="%o got killed by chef %k's kitchen knife."
     DeathStrings(2)="%k made some BBQ using %o's cut out intestines."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=25
     DamageDescription=",Slash,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkMachete'
     DeathString="%k sliced up %o with a kitchen knife."
     FemaleSuicide="%o sliced herself with a kitchen knife."
     MaleSuicide="%o slice himself with a kitchen knife."
     bNeverSevers=False
}
