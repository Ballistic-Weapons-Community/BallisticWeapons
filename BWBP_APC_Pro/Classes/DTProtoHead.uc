//=============================================================================
// DTM353MGHead.
//
// Damage type for the M353 Machinegun headshot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTProtoHead extends DT_BWBullet;

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
     DeathStrings(0)="%k filled %o's mind with the truth and about 30 bullets."
     DeathStrings(1)="%o's gray matter didn't need photon tech to scramble %vh gray matter, %k's 5.7mm lead works."
     DeathStrings(2)="%k reduced %o's skull into bony shrapnel without them ever noticing."
	 DeathStrings(3)="One by one, %o got shot in the head by %k's experimental PDW until they died."
     bHeaddie=True
     WeaponClass=Class'BWBP_APC_Pro.ProtoSMG'
     DeathString="%k furiously machinegunned %o's head off."
     FemaleSuicide="%o shot herself in the head with the FC01-B."
     MaleSuicide="%o shot himself in the head with the FC01-B."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
