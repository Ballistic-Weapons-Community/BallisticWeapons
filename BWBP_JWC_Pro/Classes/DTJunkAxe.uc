//=============================================================================
// DTJunkAxe.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkAxe extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k chopped %o's head off."
     DeathStrings(1)="%o was cut down in %vh prime by %k's hand axe."
     DeathStrings(2)="%o was felled by %k's axe."
     BloodManagerName="BallisticFix.BloodMan_Slash"
     ShieldDamage=45
     DamageDescription=",Hack,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkAxe'
     DeathString="%k chopped %o's head off."
     FemaleSuicide="%o chopped herself with a hand axe."
     MaleSuicide="%o chopped himself with a hand axe."
     bNeverSevers=False
}
