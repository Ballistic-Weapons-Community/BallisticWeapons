//=============================================================================
// DTGRSXXPistolHead.
//
// Damage type for m10111242 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSX45PistolHead_RAD extends DT_BWBullet;

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
     FlashF=0.200000
     FlashV=(X=1500.000000,Y=1500.000000)
     bHeaddie=True
     DeathStrings(0)="%k melted %o's potato head using the power of radiation."
     DeathStrings(1)="%o licked the end of %k's bullet and got mouth cancer from it."
     DeathStrings(2)="%k made an art exhibit out of %o's brains and radium."
     DeathStrings(3)="%o's gray matter is now green thanks to %k."
     WeaponClass=Class'BWBP_SKC_Pro.SX45Pistol'
     DeathString="%o was force fed %k's SX45K bullets."
     FemaleSuicide="%o somehow shot herself."
     MaleSuicide="%o managed to shoot himself."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
