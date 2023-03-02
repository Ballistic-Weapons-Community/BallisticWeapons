//=============================================================================
// DTvamp.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTvamp extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o got bitten by %k's vampire pick."
     DeathStrings(1)="%k absorbed %o's blood with his vampire pick."
     DeathStrings(2)="%k turned %o into an undead."
     DeathStrings(3)="%o lost his vitality to %k."
     DeathStrings(4)="%k let %o wither to death."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=25
     DamageDescription=",Slash,"
     ImpactManager=None
     DeathString="%k killed up %o with a vampire pick."
     FemaleSuicide="%o killed herself with a vampire pick."
     MaleSuicide="%o killed himself with a vampire pick."
     bNeverSevers=False
}
