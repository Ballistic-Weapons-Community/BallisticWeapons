//=============================================================================
// DTImmolation.
//
// Damage type for players caught alight by burning junk weapons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTImmolation extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o was immolated by %k."
     DeathStrings(1)="%o died painfully after being ignited by %k."
     DeathStrings(2)="%o couldn't withstand %k's hot aura."
     DeathStrings(3)="%o couldn't get to a fire extinguisher before %k's fire finished %vm off."
     DeathStrings(4)="%o ran screaming for the water, but was overcome by %k's flames."
     FemaleSuicides(0)="%o ran around like a maniac in a ball of fire."
     FemaleSuicides(1)="%o did her flaming scarecrow impression."
     MaleSuicides(0)="%o ran around like a maniac in a ball of fire."
     MaleSuicides(1)="%o did his flaming scarecrow impression."
     DeathString="%o was set a blaze by %k's weapon."
     FemaleSuicide="%o ran around like a maniac in a ball of fire."
     MaleSuicide="%o ran around like a maniac in a ball of fire."
     bSkeletize=True
     bDelayedDamage=True
     GibPerterbation=0.100000
     KDamageImpulse=200.000000
}
