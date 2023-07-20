//=============================================================================
// DT_G51AssaultLimb.
//
// DamageType for the G51 assault rifle primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_G51AssaultLimb extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's G51 made sure %o couldn't feel %vh legs."
     DeathStrings(1)="%o was crippled by %k's G51."
     DeathStrings(2)="%k gave %o's kneecaps air holes with an G51."
     DeathStrings(3)="%k jammed some G51 rounds into %o's fingers."
     WeaponClass=Class'BWBP_SKC_Pro.G51Carbine'
     DeathString="%k's G51 made sure %o couldn't feel %vh legs."
     FemaleSuicide="%o nailed herself with the G51."
     MaleSuicide="%o nailed himself with the G51."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.650000
}
