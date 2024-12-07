//=============================================================================
// DTR9RifleHead_Freeze.
//
// Damage type for the R9 Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTR9A1RifleHead_Freeze extends DT_BWBullet;

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
	DeathStrings(0)="%k sent a supersonic icicle through %o's head."
	DeathStrings(1)="%k leveled %kh R9 at %o and chilled %vm down."
	DeathStrings(2)="%o caught frostbite from %k's R9A1."
	DeathStrings(3)="%k sent %o's head to the freezer."
	DeathStrings(4)="%o's brainfreeze wasn't helped by %k's R9A1."
	SimpleKillString="R9A1 Freeze Head"
	bHeaddie=True
	DamageIdent="Sniper"
	WeaponClass=Class'BWBP_OP_Pro.R9A1RangerRifle'
	DeathString="%k sent a supersonic icicle through %o's head."
	FemaleSuicide="%o iced herself."
	MaleSuicide="%o iced himself."
	bAlwaysSevers=True
	bSpecial=True
	PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
	KDamageImpulse=2000.000000
}
