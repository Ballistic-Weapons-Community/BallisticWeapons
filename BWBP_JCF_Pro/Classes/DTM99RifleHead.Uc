//=============================================================================
// DTR78RifleHead.
//
// Damage type for the R78 Sniper Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM99RifleHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's head was completely destroyed by %k's M99-ECS."
     DeathStrings(1)="%k's M99 popped %o's juicy, watermelon-like head."
     DeathStrings(2)="%k blasted %o's head right off %vh shoulders with a M99-ECS round."
     bHeaddie=True
     WeaponClass=Class'BWBP_JCF_Pro.M99Rifle'
     DeathString="%o's head was completely destroyed by %k's M99-ECS."
     FemaleSuicide="%o sniped off her own head."
     MaleSuicide="%o sniped off his own head."
     bArmorStops=False
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     KDamageImpulse=2000.000000
}
