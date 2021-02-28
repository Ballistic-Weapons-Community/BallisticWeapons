//=============================================================================
// DTSRXRifleHead.
//
// DamageType for SRS900 Battle Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSRXRifleHead extends DT_BWBullet;

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
     DeathStrings(0)="%o had their ears ripped apart by %k."
     DeathStrings(1)="%k drilled %o right between their beady little eyes."
     DeathStrings(2)="%o peeked their head out right when %k shot them in the skull."
     DeathStrings(3)="%k's SRK took %o's head off from their shoulders, not clean but it gets the job done."
     AimedString="Scoped"
     bHeaddie=True
     DamageIdent="Sniper"
     WeaponClass=Class'BWBP_SKC_Pro.SRXRifle'
     DeathString="%k assasinated %o's head with %kh SRK-650."
     FemaleSuicide="%o saw a bullet coming up the barrel of her SRK-650."
     MaleSuicide="%o saw a bullet coming up the barrel of his SRK-650."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.000000
}
