//=============================================================================
// DThooksword.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DThooksword extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o met %k aka. Captain HOOK."
     DeathStrings(1)="%k climbed into %o's skull."
     DeathStrings(2)="%k's hooksword smashed %o's jaws into pieces."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=25
     DamageDescription=",Slash,"
     ImpactManager=None
     DeathString="%k killed up %o with a hooksword."
     FemaleSuicide="%o killed herself with a hooksword."
     MaleSuicide="%o killed himself with a hooksword."
     bNeverSevers=False
}
