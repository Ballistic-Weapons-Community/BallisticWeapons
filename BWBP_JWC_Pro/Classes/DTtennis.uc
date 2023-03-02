//=============================================================================
// DTTennis.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTtennis extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k and %o played tennis. %k served. A bloody bouillon."
     DeathStrings(1)="%o's brain trauma was unavoidable after being smashed with a tennis racket."
     DeathStrings(2)="%k showed %o how he won the tennis racket skull smashing world cup 1994."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=25
     DamageDescription=",Slash,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkMachete'
     DeathString="%k smashed %o with a tennis racket."
     FemaleSuicide="%o killed herself with a tennis racket."
     MaleSuicide="%o killed himself with a tennis racket."
     bNeverSevers=False
}
