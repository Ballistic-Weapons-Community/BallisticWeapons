//=============================================================================
// DTanchor.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTanchor extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o's bones got destroyed by %k's anchor."
     DeathStrings(1)="%o tripped over %k's anchor."
     DeathStrings(2)="%o drowned in %vm own blood after being hit with an anchor."
     DeathStrings(3)="%o got torn apart by an anchor."
     DeathStrings(4)="%k made some shashlik out of %o using an anchor."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=180
     DamageDescription=",Hack,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkConcretePole'
     DeathString="%o was completey halved by %k's anchor assault."
     FemaleSuicide="%o halved herself with an anchor."
     MaleSuicide="%o halved himself with an anchor."
     bNeverSevers=False
}
