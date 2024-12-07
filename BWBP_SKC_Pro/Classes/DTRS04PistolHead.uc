//=============================================================================
// DTGRSXXPistolHead.
//
// Damage type for m10111242 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRS04PistolHead extends DT_BWBullet;

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
     DeathStrings(0)="%o was force fed %k's RS04 bullets."
     DeathStrings(1)="%k's lodged some RS04 bullets in %o's head."
     DeathStrings(2)="%o took %k's RS04 round right in the eye."
     DeathStrings(3)="%k removed %o's head with a .45 RS04 bullet."
     bHeaddie=True
     WeaponClass=Class'BWBP_SKC_Pro.RS04Pistol'
     DeathString="%o was force fed %k's RS04 bullets."
     FemaleSuicide="%o somehow shot herself."
     MaleSuicide="%o managed to shoot himself."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
