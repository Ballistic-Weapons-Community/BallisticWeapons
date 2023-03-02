//=============================================================================
// DTBulldog.
//
// Damage type for the AH104 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPugCannon extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k knocked more than the wind out of %o."
     DeathStrings(1)="%k knocked %o heart out of rhythm with a rubber slug."
     DeathStrings(2)="%o got his riotous ways suppressed by %k."
     DeathStrings(3)="%o won't be able to have an uprising after taking %k's slug to the groin."
     bIgniteFires=True
     bMultiSever=True
     WeaponClass=Class'BWBP_SKCExp_Pro.PUGAssaultCannon'
     DeathString="%k's PUG chewed up and spat out %o."
     FemaleSuicide="%o rocked her world with the PUG."
     MaleSuicide="%o's PUG rocked his world."
     VehicleDamageScaling=0.575000
     VehicleMomentumScaling=0.300000
}
