//=============================================================================
// DTXRS10SMGHead.
//
// Damage type for the XRS10 SMG headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXRS10SMGHead extends DT_BWBullet;

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
     DeathStrings(0)="%k fired %kh XRS-10 into %o's face."
     DeathStrings(1)="%k eliminated %o's head with %kh XRS-10."
     DeathStrings(2)="%o's cranium got liquidized by %k's XRS-10."
     DeathStrings(3)="%k silenced %o's twittering head with a burst of XRS-10 rounds."
     EffectChance=0.500000
     bHeaddie=True
     InvasionDamageScaling=1.500000
     DamageIdent="SMG"
     WeaponClass=Class'BallisticProV55.XRS10SubMachinegun'
     DeathString="%k fired %kh XRS-10 into %o's face."
     FemaleSuicide="%o silenced herself."
     MaleSuicide="%o silenced himself."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     VehicleDamageScaling=0.150000
}
