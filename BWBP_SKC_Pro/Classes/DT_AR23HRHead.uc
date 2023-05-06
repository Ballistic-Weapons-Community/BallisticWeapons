//=============================================================================
// DT_AR23HR.
//
// Damage type for the M925 Machinegun headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AR23HRHead extends DT_BWBullet;

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
	DeathStrings(0)="%k broke %o's helmet and skull with a well placed Beowulf right between the eyes."
	DeathStrings(1)="%o was deemed guilty and was sentenced to death by %k's .50 through the nostrils."
	DeathStrings(2)="%k made %o pay for his misdeeds by decimating their skull with an AR23."
	DeathStrings(3)="%o had their boarish squeals silenced by %k."
	DeathStrings(4)="%k popped %o's skull like a metaphor for popping someone’s head off."
	DeathStrings(5)="%o was the perpetrator for having %k's Beowulf round illegally possessed in their gray matter."
	bHeaddie=True
	DamageIdent="HeavyRifle"
	WeaponClass=Class'BWBP_SKC_Pro.AR23HeavyRifle'
	DeathString="%k's AR23 turned %o's head into mist."
	FemaleSuicide="%o caught her face in the belt feed of her AR23."
	MaleSuicide="%o caught his face in the belt feed of his AR23."
	bFastInstantHit=True
	bAlwaysSevers=True
	bSpecial=True
	PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'

	TagMultiplier=0.6
	TagDuration=0.2
}
