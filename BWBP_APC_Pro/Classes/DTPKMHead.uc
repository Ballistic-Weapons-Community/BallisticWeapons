//=============================================================================
// DTM353MGHead.
//
// Damage type for the M353 Machinegun headshot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPKMHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's head was cleaned out of any political thoughts by %k's PKMA."
     DeathStrings(1)="%k purged %o's mind of negative feelings and gray matter."
     DeathStrings(2)="%o got %vh skull shattered by %k's heavy PKMA boolets."
     DeathStrings(3)="%k's PKMA cleared %k's pores and brains."
     bHeaddie=True
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBP_APC_Pro.PKMMachinegun'
     DeathString="%k furiously machinegunned %o's head off."
     FemaleSuicide="%o shot herself in the head with the PKM."
     MaleSuicide="%o shot himself in the head with the PKM."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
