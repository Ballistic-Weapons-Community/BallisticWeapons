class DTKF8XBoltHead extends DT_BWBullet;

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
     DeathStrings(0)="%o was assassinated from the shadows by %k's KF8X bolt."
     DeathStrings(1)="%k planted a crossbow bolt into %o."
     DeathStrings(2)="%o was discreetly decommissioned by %k's silent bolt."
     SimpleKillString="KF8X Crossbow Bolt"
     DamageIdent="Sniper"
     bMetallic=True
	 bHeaddie=True
	 InvasionDamageScaling=2
     WeaponClass=Class'BWBP_OP_Pro.KF8XCrossbow'
     DeathString="%%o was assassinated from the shadows by %k's KF8X bolt."
     FemaleSuicide="%o dropped her own crossbow."
     MaleSuicide="%o dropped his own crossbow."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=10000.000000
}
