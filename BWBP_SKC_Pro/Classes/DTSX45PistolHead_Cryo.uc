//=============================================================================
// DTGRSXXPistolHead.
//
// Damage type for m10111242 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSX45PistolHead_Cryo extends DT_BWBullet;

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
     DeathStrings(0)="%k gave %o the deadliest brain freeze known to man."
     DeathStrings(1)="%o's nose fell off thanks to frostbite courtesy of %k."
     DeathStrings(2)="%k shot a lethal snowball into %o's head."
     DeathStrings(3)="%o took a lick of %k's ice bullet, it didn't stick to the bullet, just shattered his tongue."
     WeaponClass=Class'BWBP_SKC_Pro.SX45Pistol'
     DeathString="%o was force fed %k's SX45K bullets."
     FemaleSuicide="%o somehow shot herself."
     MaleSuicide="%o managed to shoot himself."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
