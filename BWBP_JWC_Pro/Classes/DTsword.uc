//=============================================================================
// DTSword.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTsword extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o got hacked up by a medieval sword."
     DeathStrings(1)="%o's limbs were cut off by %k's sword."
     DeathStrings(2)="%k stabbed %o like a knight of olde."
     DeathStrings(3)="%o fell in combat and lost honor to %k."
     DeathStrings(4)="%k turned %o's head into the next Sword of the Stone."
     DeathStrings(5)="%o's head was used as a trophy for %k's Victory."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=25
     DamageDescription=",Slash,"
     ImpactManager=None
     DeathString="%k sliced up %o with a sword."
     FemaleSuicide="%o sliced herself with a sword."
     MaleSuicide="%o slice himself with a sword."
     bNeverSevers=False
}
