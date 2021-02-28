//=============================================================================
// DTAH250Pistol.
//
// Damage type for the AH250 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAH250Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k took %o out with %kh .44 handcannon."
     DeathStrings(1)="%k's AH250 blasted out %o's spine."
     DeathStrings(2)="%o got on the wrong side of %k's AH250."
     DeathStrings(3)="%o got in the way of %k's rampaging AH250."
     DamageIdent="Sidearm"
     WeaponClass=Class'BWBP_SKC_Pro.AH250Pistol'
     DeathString="%k took %o out with his .44 handcannon."
     FemaleSuicide="%o pointed her AH250 backwards."
     MaleSuicide="%o pointed his AH250 backwards."
     VehicleDamageScaling=0.150000
}
