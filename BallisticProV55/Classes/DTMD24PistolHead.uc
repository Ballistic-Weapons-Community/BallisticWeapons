//=============================================================================
// DTMD24PistolHead.
//
// Damage type for the MD24 Pistol headshots
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMD24PistolHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's head was whisked away by %k's MD24 round."
     DeathStrings(1)="%k whipped %o's head off with %kh MD24 pistol."
     DeathStrings(2)="%k's MD24 round cleared away %o's cranium."
     bHeaddie=True
     DamageIdent="Pistol"
     WeaponClass=Class'BallisticProV55.MD24Pistol'
     DeathString="%o's head was whisked away by %k's MD24 round."
     FemaleSuicide="%o blew her ugly face off with an MD24."
     MaleSuicide="%o blew his ugly face off with an MD24."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     VehicleDamageScaling=0.000000
}
