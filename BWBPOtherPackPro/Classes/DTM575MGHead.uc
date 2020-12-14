//=============================================================================
// DTM575MGHead.
//
// Damage type for the M575 Machinegun headshot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM575MGHead extends DT_BWBullet;

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
     DeathStrings(0)="%k gave an eye for an eye a whole new meaning when he shot %o's head off."
     DeathStrings(1)="%o lost more than his sight when %k's M575 saw him."
     DeathStrings(2)="%k blinded %o with his M575, and decapitated him for good measure."
	 DeathStrings(3)="%o couldn’t see %k putting several holes into his head."
	 DeathStrings(4)="%k took %o's vision and his life at the same time."
	 DeathStrings(5)="%o's skull was hollowed out by %k's hybrid beast."
     bHeaddie=True
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBPOtherPackPro.M575Machinegun'
     DeathString="%k furiously machinegunned %o's head off."
     FemaleSuicide="%o shot herself in the head with the M575."
     MaleSuicide="%o shot himself in the head with the M575."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
