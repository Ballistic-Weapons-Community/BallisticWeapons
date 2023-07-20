//=============================================================================
// DTplayer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTplayer extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o's ear-drum popped thanks to %k's walkman."
     DeathStrings(1)="%k killed %o with horrible music."
     DeathStrings(2)="%k never wanted to give %o up, never wanted to let %vm dooown..."
     DeathStrings(3)="%k's sonic waves killed %o."
     ShieldDamage=40
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
     DeathString="%k killed %o with a walkman."
     FemaleSuicide="%o killed herself with a walkman."
     MaleSuicide="%o killed himself with a walkman."
     bArmorStops=False
     bCausesBlood=False
}
