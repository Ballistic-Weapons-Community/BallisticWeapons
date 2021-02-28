//=============================================================================
// DT_MRDR88Head.
//
// Damage type for the MRDR SMG Headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MRDR88Head extends DT_BWBullet;

// HeadShot stuff from old sniper damage ------------------
static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;

	if ( PlayerController(Killer) == None )
		return;

	PlayerController(Killer).ReceiveLocalizedMessage( Class'XGame.SpecialKillMessage', 0, Killer.PlayerReplicationInfo, None, None );
	xPRI = xPlayerReplicationInfo(Killer.PlayerReplicationInfo);
	if ( xPRI != None )
	{
		xPRI.headcount++;
		if ( (xPRI.headcount == 15) && (UnrealPlayer(Killer) != None) )
			UnrealPlayer(Killer).ClientDelayedAnnouncementNamed('HeadHunter',15);
	}
}
// --------------------------------------------------------

defaultproperties
{
     DeathStrings(0)="%k nailed %o in the head with an MR-DR88."
     DeathStrings(1)="%o took %k's MR-DR88 bullet in the skull."
     DeathStrings(2)="%k's MR-DR88 put an end to %o's headache."
     DeathStrings(3)="%o fell after %k's MR-DR88 bullet left %vh skull."
     EffectChance=0.500000
     bHeaddie=True
     DamageIdent="SMG"
     WeaponClass=Class'BWBP_SKC_Pro.MRDRMachinePistol'
     DeathString="%k nailed %o in the head with an MR-DR88."
     FemaleSuicide="%o went out with her MR-DR88."
     MaleSuicide="%o went out with his MR-DR88."
     bFastInstantHit=True
     bSpecial=True
     VehicleDamageScaling=0.000000
}
