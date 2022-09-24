//=============================================================================
// DTAM67PistolHead.
//
// Damage type for the AM67 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAM67PistolHead extends DT_BWBullet;

// HeadShot stuff from old sniper damage ------------------
static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;

	if ( PlayerController(Killer) == None )
		return;

	//PlayerController(Killer).ReceiveLocalizedMessage( Class'XGame.SpecialKillMessage', 0, Killer.PlayerReplicationInfo, None, None );
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
     DeathStrings(0)="%o's skull was shattered by %k's AM67."
     DeathStrings(1)="%k denounced %o's head with AM67 rounds."
     DeathStrings(2)="%o's head was negotiated off by %k's AM67."
     bHeaddie=True
     DamageIdent="Pistol"
     WeaponClass=Class'BallisticProV55.AM67Pistol'
     DeathString="%k blew %o's head off with %kh AM67."
     FemaleSuicide="%o blew her head off with the AM67."
     MaleSuicide="%o blew his head off with the AM67."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
