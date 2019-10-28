//=============================================================================
// DTM75RailgunHead.
//
// Damage type for the M75 Railgun headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM75RailgunHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's mad-eyed head got caught in %k's corkscrew."
     DeathStrings(1)="%k's rail slug stumped %o's already stumpy head."
     DeathStrings(2)="%o lost %vh head in a fight with %k's M75."
     HipString="Complete Luck"
     AimedString="Scoped"
     FlashThreshold=140
     FlashV=(Z=250.000000)
     FlashF=0.100000
     bSnipingDamage=True
     bHeaddie=True
     InvasionDamageScaling=1.500000
     DamageIdent="Sniper"
     bDisplaceAim=True
     AimDisplacementDamageThreshold=150
     AimDisplacementDuration=1.000000
     WeaponClass=Class'BallisticProV55.M75Railgun'
     DeathString="%o's mad eyed head got caught in %k's corkscrew."
     FemaleSuicide="%o derailed herself."
     MaleSuicide="%o derailed himself."
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
}
