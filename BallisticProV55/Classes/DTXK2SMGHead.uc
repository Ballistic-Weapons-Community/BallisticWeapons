//=============================================================================
// DTXK2SMGHead.
//
// Damage type for the XK2 SMG headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXK2SMGHead extends DT_BWBullet;

// HeadShot stuff from old sniper damage ------------------
static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;

	if ( PlayerController(Killer) == None )
		return;

	//PlayerController(Killer).ReceiveLocalizedMessage( Class'XGame.SpecialKillMessage', 0, Killer.PlayerReplicationInfo, None, None );
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
     DeathStrings(0)="%o was stung in the head by %k's XK2."
     DeathStrings(1)="%k ruined %o's head with %kh XK2."
     EffectChance=0.500000
     bHeaddie=True
     InvasionDamageScaling=1.500000
     DamageIdent="SMG"
     WeaponClass=Class'BallisticProV55.XK2SubMachinegun'
     DeathString="%o was stung in the head by %k's XK2."
     FemaleSuicide="%o silenced herself."
     MaleSuicide="%o silenced himself."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     VehicleDamageScaling=0.000000
}
