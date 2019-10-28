//=============================================================================
// DT_X82Head.
//
// DamageType for M30A2 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_X82Head extends DT_BWBullet;

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
     DeathStrings(0)="%k blew %o's skull away with a .50 Cal bullet."
     DeathStrings(1)="%o was decapitated by %k's anti-materiel round."
     DeathStrings(2)="%k scored a .50 Cal headshot on hapless %o."
     HipString="Luck"
     AimedString="Scoped"
     bSnipingDamage=True
     bHeaddie=True
     InvasionDamageScaling=2.000000
     DamageIdent="Sniper"
     bDisplaceAim=True
     AimDisplacementDuration=0.700000
     WeaponClass=Class'BWBPRecolorsPro.X82Rifle'
     DeathString="%k blew %o's skull away with a .50 Cal bullet."
     FemaleSuicide="%o shot herself in the head while cleaning her gun."
     MaleSuicide="%o shot himself in the head while cleaning his gun."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=10000.000000
     VehicleDamageScaling=0.650000
}
