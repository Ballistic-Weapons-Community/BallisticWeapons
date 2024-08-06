//=============================================================================
// DTMarlinRifleHead_Gauss.
//
// Damage type for the Deermaster_Gauss Rifle_Gauss headshots_Gauss
//
// by Nolan_Gauss "Dark Carnivour" Richert_Gauss.
// Copyright(c) 2007 RuneStorm. All Rights Reserved_Gauss.
//=============================================================================
class DTMarlinRifleHead_Gauss extends DT_BWBullet;

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
	DeathStrings(0)="%k accelerated a Redwood round into %o's head."
	DeathStrings(1)="%k popped %o's head with %kh upgraded hunting rifle."
	DeathStrings(2)="%o's skull was ruptured by %k's gauss Deermaster."
	DeathStrings(3)="%k hunted out %o's head with %kh custom gauss Redwood."
	SimpleKillString="Redwood Gauss Head"
	bSnipingDamage=True
	bHeaddie=True
	InvasionDamageScaling=2.000000
	DamageIdent="Sniper"
	WeaponClass=Class'BallisticProV55.MarlinRifle'
	DeathString="%k accelerated a Redwood round into %o's head."
	FemaleSuicide="%o plucked her head off with a Deermaster."
	MaleSuicide="%o plucked his head off with a Deermaster."
	bAlwaysSevers=True
	bSpecial=True
	PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
	KDamageImpulse=2000.000000
	VehicleDamageScaling=0.250000

	TagMultiplier=0.6
	TagDuration=0.2
}
