//=============================================================================
// DTlamp.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTlamp extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k smashed %o with a lamp post."
     DeathStrings(1)="%o met the light bulb's big brother."
     DeathStrings(2)="%o's lights were going out after being hit by %k's lamp post."
     DeathStrings(3)="%o got launched in the air by %k's lamp post hit."
     DeathStrings(4)="Legend tells that the light bulb's glass contained small pieces of brain after %o was hit with a lamp post."
     ShieldDamage=160
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkConcretePole'
     DeathString="%k crushed %o with %kh lamp post."
     FemaleSuicide="%o crushed herself to death with a lamp post."
     MaleSuicide="%o crushed himself to death with a lamp post."
}
