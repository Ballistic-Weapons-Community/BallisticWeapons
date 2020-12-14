//=============================================================================
// DTBulldogHead.
//
// Damage type for the Bulldog headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBulldogHead extends DT_BWBullet;

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
     DeathStrings(0)="%k's Bulldog tore %o's head clean off."
     DeathStrings(1)="%k blasted a huge chunk out of %o's head with a BOLT."
     DeathStrings(2)="%o's head was eaten up by %k's Bulldog."
     DeathStrings(3)="%k blew %o's head into a wall with one BOLT round."
     bHeaddie=True
     InvasionDamageScaling=2
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBPRecolorsPro.BulldogAssaultCannon'
     DeathString="%o's head got eaten by %k's Bulldog."
     FemaleSuicide="%o is tactically inept with a Bulldog."
     MaleSuicide="%o is tactically inept with a Bulldog."
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     VehicleDamageScaling=1.000000
}
