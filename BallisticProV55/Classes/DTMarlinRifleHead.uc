//=============================================================================
// DTMarlinRifleHead.
//
// Damage type for the Deermaster Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMarlinRifleHead extends DT_BWBullet;

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
     DeathStrings(0)="%k plunged a Redwood round into %o's head."
     DeathStrings(1)="%k scoured %o's head with %kh hunting rifle."
     DeathStrings(2)="%o's cranium crumbled before %k's Deermaster."
     DeathStrings(3)="%k hunted out %o's head with %kh Redwood 6000."
     DeathStrings(4)="%o got %vh head plucked off by %k's Deermaster rifle."
     bSnipingDamage=True
     bHeaddie=True
     InvasionDamageScaling=2.000000
     DamageIdent="Sniper"
     WeaponClass=Class'BallisticProV55.MarlinRifle'
     DeathString="%k plunged a Redwood 6000 round into %o's head."
     FemaleSuicide="%o plucked her head off with a Deermaster."
     MaleSuicide="%o plucked his head off with a Deermaster."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.150000
}
