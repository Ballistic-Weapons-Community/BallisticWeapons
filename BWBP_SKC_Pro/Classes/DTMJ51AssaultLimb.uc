//=============================================================================
// DTMJ51AssaultLimb.
//
// DamageType for the MJ51 assault rifle primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMJ51AssaultLimb extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's MJ53 made sure %o couldn't feel %vh legs."
     DeathStrings(1)="%o was crippled by %k's MJ53."
     DeathStrings(2)="%k gave %o's kneecaps air holes with an MJ53."
     DeathStrings(3)="%k jammed some MJ53 rounds into %o's fingers."
     WeaponClass=Class'BWBP_SKC_Pro.MJ51Carbine'
     DeathString="%k's MJ53 made sure %o couldn't feel %vh legs."
     FemaleSuicide="%o nailed herself with the MJ53."
     MaleSuicide="%o nailed himself with the MJ53."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.650000
}
