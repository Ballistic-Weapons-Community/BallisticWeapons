//=============================================================================
// DTSRKSmgHead.
//
// DamageType for MJ51 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSRKSmgHead extends DT_BWBullet;

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
     DeathStrings(0)="%k used their super 205 to remove %o's head clean off."
     DeathStrings(1)="%o's brains were entombed in %k's 10mm lead casket."
     DeathStrings(2)="%k got backsplattered from headshotting %o in CQC."
	 DeathStrings(3)="%o had some dental work by %k, having their teeth replaced by 10mm bullets."
	 DeathStrings(4)="%k put two bullets in %o's eyes to blind them before dying."
     bHeaddie=True
     WeaponClass=Class'BWBP_APC_Pro.SRKSubMachinegun'
     DeathString="%o got %vh brain shredded by %k's SRK-205."
     FemaleSuicide="%o saw a bullet coming up the barrel of her SRK-205."
     MaleSuicide="%o saw a bullet coming up the barrel of his SRK-205."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.650000
}
