//=============================================================================
// DTXMV500MGHead.
//
// Damage type for the XMV500 Minigun headshot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXMV500MGHead extends DT_BWBullet;

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
     DeathStrings(0)="%k's smart minigun blew %o's brain."
     DeathStrings(1)="%o's head was replaced with %k's XMB-500 bullets."
     DeathStrings(2)="%o lost %vh head in a fight with %k's XMB-500."
     DeathStrings(3)="%k's XMB-500 smashed rounds through %o's cranium."
     bIgniteFires=True
     WeaponClass=Class'BWBP_APC_Pro.XMV500Minigun'
     DeathString="%k's smart minigun blew %o's brain."
     FemaleSuicide="%o minigunned her own head off."
     MaleSuicide="%o minigunned his own head off."
     DamageDescription=",Flame,Bullet,"
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     //PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSounnd.BulletImpacts.Headshot'
}
