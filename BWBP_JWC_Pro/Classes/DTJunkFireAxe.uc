//=============================================================================
// DTJunkFireAxe.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkFireAxe extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o was completey halved by %k's fire-axe assault."
     DeathStrings(1)="%k severed %o's neck with a massive axe."
     DeathStrings(2)="%k went psychotic all over a terrified %o."
     BloodManagerName="BallisticFix.BloodMan_Slash"
     ShieldDamage=180
     DamageDescription=",Hack,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkFireAxe'
     DeathString="%o was completey halved by %k's fire-axe assault."
     FemaleSuicide="%o halved herself with a fire axe."
     MaleSuicide="%o halved himself with a fire axe."
     bNeverSevers=False
}
