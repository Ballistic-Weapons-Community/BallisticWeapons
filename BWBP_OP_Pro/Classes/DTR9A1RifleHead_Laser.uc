//=============================================================================
// DTR9RifleHeadLaser.
//
// Damage type for the R9 LaserRifle Laserheadshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTR9A1RifleHead_Laser extends DT_BWBullet;

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
	DeathStrings(0)="%k's tech R9A1 gave %o eye surgery."
	DeathStrings(1)="%k leveled %kh R9A1 at %o's head and blasted."
	DeathStrings(2)="%o got lobotomized by %k's R9A1 laser."
	SimpleKillString="R9A1 Laser Head"
	bHeaddie=True
	DamageIdent="Sniper"
	WeaponClass=Class'BWBP_OP_Pro.R9A1RangerRifle'
	DeathString="%k's tech R9A1 gave %o eye surgery."
	FemaleSuicide="%o lasered herself."
	MaleSuicide="%o lasered himself."
	bAlwaysSevers=True
	bSpecial=True
	PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
	KDamageImpulse=2000.000000
}
