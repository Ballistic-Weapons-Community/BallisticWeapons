//=============================================================================
// DTGRS9PistolHead.
//
// Damage type for GRS9 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHKMKSpecPistolHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's helmet and gray matter has a shiny new hole thanks to %k."
     DeathStrings(1)="%k managed to stop %o with a headshot before they did something highly illegal."
     DeathStrings(2)="%o couldn't catch %k's speeding bullet coming right towards their gray matter."
     DeathStrings(3)="%k ripped right through %o's ears even though there was a helmet protecting them."
     DeathStrings(4)="%o was stopped from doing bad things by taking %k's armor piercing bullet to the dome."
     DeathStrings(5)="%k broke through thick glass and %o’s nose with a single bullet."
     bHeaddie=True
     WeaponClass=Class'BWBP_JCF_Pro.HKMKSpecPistol'
     DeathString="%k put %kh HKM-26 to %o's temple and fired."
     FemaleSuicide="%o litigated her own head off."
     MaleSuicide="%o litigated his own head off."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
