//=============================================================================
// DTD49RevolverHead.
//
// Damage type for the D49 Revolver headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTD49RevolverHead extends DT_BWBullet;

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
     DeathStrings(0)="%k took %o's head out with a shot from %kh D49."
     DeathStrings(1)="%k angled a shot through %o's head with %kh six shooter."
     DeathStrings(2)="%k put a magnum round through %o's face."
     DeathStrings(3)="%o's head was blown apart by %k's magnum."
     DeathStrings(4)="%o lost a showdown with %k's magnum."
     DeathStrings(5)="%o fumbled for %vh gun before %k blew %vh head off."
     bHeaddie=True
     DamageIdent="Pistol"
     WeaponClass=Class'BallisticProV55.D49Revolver'
     DeathString="%k took %o's head out with a shot from %kh D49."
     FemaleSuicide="%o shot herself in the face."
     MaleSuicide="%o shot himself in the face."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
