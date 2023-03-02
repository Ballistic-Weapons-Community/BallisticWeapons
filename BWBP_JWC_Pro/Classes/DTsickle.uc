//=============================================================================
// Sickle.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSickle extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k harvested %o's intestines."
     DeathStrings(1)="Soviet %k killed capitalist %o."
     DeathStrings(2)="Stalin told %k to kill %o. HE DID."
     DeathStrings(3)="%o's limbs were raped by %k's sickle."
     DeathStrings(4)="%k did a sickle surgery on %o's head."
     DeathStrings(5)="%o was SICK of %k's SICKle."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=25
     DamageDescription=",Slash,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkMachete'
     DeathString="%k sliced up %o with a sickle."
     FemaleSuicide="%o sliced herself with a sickle."
     MaleSuicide="%o slice himself with a sickle."
     bNeverSevers=False
}
