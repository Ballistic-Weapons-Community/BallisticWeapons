//=============================================================================
// DTGRS9PistolHead.
//
// Damage type for GRS9 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHKMKSpecPistolHeadAlt extends DT_BWBullet;

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
     DeathStrings(0)="%o had their mugshot taken by %k, giving them a literal mug shot."
     DeathStrings(1)="%k destroyed %o's face so viciously that it doesn’t match their wanted poster."
     DeathStrings(2)="%o didn't feel so lucky when they assumed that %k's mag was empty. Boom, headshot."
     DeathStrings(3)="%k's HKM took a bite out of crime and %o's face with a small shottie."
     DeathStrings(4)="%o found out the hard way that staring down %k's shotgun would leave them blind and dead."
     bHeaddie=True
     WeaponClass=Class'BWBP_JCF_Pro.HKMKSpecPistol'
     DeathString="%k put %kh HKM-26 to %o's temple and fired."
     FemaleSuicide="%o litigated her own head off."
     MaleSuicide="%o litigated his own head off."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
