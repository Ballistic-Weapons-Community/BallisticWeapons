//=============================================================================
// DTleMatrevolverHead.
//
// Damage type for the Wilson DB Revolver headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTleMatRevolverHead extends DT_BWBullet;

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
     DeathStrings(0)="%k unleashed %kh diamond back on %o's head."
     DeathStrings(1)="%o got %vh head blown off in a duel with %k."
     DeathStrings(2)="%k went leMat on %o's head.."
     DeathStrings(3)="%o got %vh head in a few too many duels with %k."
     DeathStrings(4)="%k's Diamond Back bit %o in the head."
     bHeaddie=True
     WeaponClass=Class'BallisticProV55.leMatRevolver'
     DeathString="%k went leMat on %o's head."
     FemaleSuicide="%o shot herself in the face."
     MaleSuicide="%o shot himself in the face."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
