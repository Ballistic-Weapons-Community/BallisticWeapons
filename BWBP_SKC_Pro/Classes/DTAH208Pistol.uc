//=============================================================================
// DTAH208Pistol.
//
// Damage type for the AH208 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAH208Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k took %o out with %kh .44 handcannon."
     DeathStrings(1)="%k's AH208 blasted out %o's spine."
     DeathStrings(2)="%o got on the wrong side of %k's AH208."
     DeathStrings(3)="%o got in the way of %k's rampaging AH208."
     DamageIdent="Killstreak"
     WeaponClass=Class'BWBP_SKC_Pro.AH208Pistol'
     DeathString="%k took %o out with his .44 handcannon."
     FemaleSuicide="%o pointed her AH208 backwards."
     MaleSuicide="%o pointed his AH208 backwards."
}
