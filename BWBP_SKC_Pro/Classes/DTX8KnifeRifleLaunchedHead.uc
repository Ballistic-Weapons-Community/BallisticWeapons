//=============================================================================
// DTX8KnifeRifleLaunchedHead.
//
// Damagetype for launched X8 Knife hitting heads
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX8KnifeRifleLaunchedHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k's knife defied all odds to enter %o's vodka-blurred eye."
     DeathStrings(1)="%k drunkenly launched a knife into %o's face."
     DeathStrings(2)="%o took a knife to the eye from %k's AK490 launcher."
     SimpleKillString="AK-490 Bayonet Launched"
     bCanBeBlocked=False
     bHeaddie=True
     DisplacementType=DSP_None
     WeaponClass=Class'BWBP_SKC_Pro.AK490BattleRifle'
     DeathString="%k's knife defied all odds to enter %o's vodka-blurred eye."
     FemaleSuicide="%o's AK490 bayonet gave her a surprise."
     MaleSuicide="%o's AK490 bayonet gave him a surprise."
     bArmorStops=False
     bNeverSevers=True
     KDamageImpulse=1000.000000
}
