//=============================================================================
// DTKama.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTkama extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k harvested %o's intestines with his kama."
     DeathStrings(1)="%k acted like a freaking monk killing %o with a kama."
     DeathStrings(2)="Kamas may be smaller than scythes but they were enough to kill %o."
     DeathStrings(3)="%k cut %o into pieces with his kama."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=25
     DamageDescription=",Slash,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkMachete'
     DeathString="%k sliced up %o with a kama."
     FemaleSuicide="%o sliced herself with a kama."
     MaleSuicide="%o slice himself with a kama."
     bNeverSevers=False
}
