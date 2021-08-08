//=============================================================================
// DTX8KnifeLaunchedHead.
//
// Damagetype for launched X8 Knife hitting heads
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX8KnifeLaunchedHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k's knife defied all odds to enter %o's eye."
     DeathStrings(1)="%k launched a knife into %o's face."
     DeathStrings(2)="%k's ballistic knife gave %o a new piercing."
     SimpleKillString="X8 Ballistic Knife Launched"
     bCanBeBlocked=False
     bHeaddie=True
     WeaponClass=Class'BWBP_SKC_Pro.X8Knife'
     DeathString="%k's knife defied all odds to enter %o's eye."
     FemaleSuicide="%o acupunctured her face."
     MaleSuicide="%o acupunctured his face."
     bNeverSevers=True
     KDamageImpulse=1000.000000
}
