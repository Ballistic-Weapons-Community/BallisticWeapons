//=============================================================================
// DTM353MG.
//
// Damage type for the M353 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTProtoPhoton extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o had their nervous system fried to the point where they couldn't reboot thanks to %k."
     DeathStrings(1)="%k scorched %o's memories with a photon burst until they went blank."
     DeathStrings(2)="%o became the guinea pig to %k's experimental photon burst, it was a success."
	 DeathStrings(3)="%k got the results they wanted after subject %o to some mind altering photon tech."
     WeaponClass=Class'BWBP_APC_Pro.ProtoSMG'
     DeathString="%o was torn to shreds by %k's FC01-B."
     FemaleSuicide="%o shot herself in the foot with the FC01-B."
     MaleSuicide="%o shot himself in the foot with the FC01-B."
     bFastInstantHit=True
}
