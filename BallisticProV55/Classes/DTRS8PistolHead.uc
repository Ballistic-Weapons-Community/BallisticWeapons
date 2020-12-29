//=============================================================================
// DTRS8PistolHead.
//
// Damage type for the RS8 Pistol Headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRS8PistolHead extends DT_BWBullet;

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
     DeathStrings(0)="%k shut down %o's head with %kh RS8."
     DeathStrings(1)="%o found %vh head being obliterated by %k's 10mm RS8."
     DeathStrings(2)="%o's head was assassinated off by %k's RS8."
     EffectChance=0.500000
     bHeaddie=True
     DamageIdent="Pistol"
     WeaponClass=Class'BallisticProV55.RS8Pistol'
     DeathString="%k shut down %o's head with %kh RS8."
     FemaleSuicide="%o silenced herself."
     MaleSuicide="%o silenced himself."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     VehicleDamageScaling=0.000000
}
