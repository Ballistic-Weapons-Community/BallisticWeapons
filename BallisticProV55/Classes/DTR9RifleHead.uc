//=============================================================================
// DTR9RifleHead.
//
// Damage type for the R9 Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTR9RifleHead extends DT_BWBullet;

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
     DeathStrings(0)="%k shot %o's head out of the way with %kh R9."
     DeathStrings(1)="%k levelled %kh rifle at %o and blew %vh head off."
     DeathStrings(2)="%o caught a round from %k's R9."
     DeathStrings(3)="%k found %o's head with %kh ranger rifle."
     DeathStrings(4)="%o's head received a round from %k's R9."
     bHeaddie=True
     DamageIdent="Sniper"
     WeaponClass=Class'BallisticProV55.R9RangerRifle'
     DeathString="%k shot %o's head out of the way with %kh R9."
     FemaleSuicide="%o R9ed off her own head."
     MaleSuicide="%o R9ed off his own head."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     KDamageImpulse=2000.000000
}
