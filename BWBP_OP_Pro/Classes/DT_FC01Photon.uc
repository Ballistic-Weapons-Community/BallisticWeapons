//=============================================================================
// DT_FC01Photon.
//
// Damage type for the fc01 zap mode
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FC01Photon extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o had %vh nervous system fried to the point where %ve couldn't reboot thanks to %k."
     DeathStrings(1)="%k scorched %o's memories with a photon burst until %ve went blank."
     DeathStrings(2)="%o became the guinea pig to %k's experimental photon burst, it was a success."
     DeathStrings(3)="%k got the results they wanted after subject %o to some mind altering photon tech."
     WeaponClass=Class'BWBP_OP_Pro.FC01SmartGun'
     DeathString="%o was torn to shreds by %k's FC01-B."
     FemaleSuicide="%o shot herself in the foot with the FC01-B."
     MaleSuicide="%o shot himself in the foot with the FC01-B."
     bFastInstantHit=True
}
