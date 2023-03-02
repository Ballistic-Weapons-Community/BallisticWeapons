//=============================================================================
// DTswatter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTswatter extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k got rid of %o's annoying buzzing."
     DeathStrings(1)="%k swatted %o like a fly."
     DeathStrings(2)="%k crushed %o with a swatter."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=25
     DamageDescription=",Slash,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkMachete'
     DeathString="%k smashed %o with a swatter."
     FemaleSuicide="%o killed herself with a swatter."
     MaleSuicide="%o killed himself with a swatter."
     bAlwaysGibs=True
     bNeverSevers=False
     GibPerterbation=4.000000
}
