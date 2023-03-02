//=============================================================================
// DTSARRifleHead.
//
// Damage type for the SAR12 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM7A3RifleHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's melon was popped by %k's M7A3."
     DeathStrings(1)="%k exploded %o's head with %kh M7A3 AR."
     DeathStrings(2)="%k's M7A3 dismantled poor %o's head."
     DeathStrings(3)="%o got %vh head removed by %k's M7A3."
     DeathStrings(4)="%k put a round through %o's head."
     EffectChance=0.500000
     bHeaddie=True
     WeaponClass=Class'BWBP_JCF_Pro.M7A3AssaultRifle'
     DeathString="%o's melon was popped by %k's M7A3."
     FemaleSuicide="%o headshottificated herself."
     MaleSuicide="%o headshottified himself."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     VehicleDamageScaling=0.600000
}
