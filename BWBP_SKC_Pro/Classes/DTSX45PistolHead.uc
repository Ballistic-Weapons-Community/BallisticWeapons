//=============================================================================
// DTSX45PistolHead.
//
// Damage type for SX45 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSX45PistolHead extends DT_BWBullet;

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
     bHeaddie=True
     DeathStrings(0)="%k relieved %o's cranial pressure with a well placed .45."
     DeathStrings(1)="%o had his third eye opened by %k's .45 round."
     DeathStrings(2)="%k's SX45 rhinoplasty turned %o into a beautiful corpse."
     DeathStrings(3)="%o's cataracts and eyeballs cleared up due to %k's SX45."
     WeaponClass=Class'BWBP_SKC_Pro.SX45Pistol'
     DeathString="%k relieved %o's cranial pressure with a well placed .45."
     FemaleSuicide="%o somehow shot herself."
     MaleSuicide="%o managed to shoot himself."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
