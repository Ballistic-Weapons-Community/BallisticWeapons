class DTBRINKAssaultHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's head was ripped of by %k's Brink rifle."
     DeathStrings(1)="%k pulled out %kh Brink and %o's head fell off in terror."
     DeathStrings(2)="%o got %vh head blown clean off by %k's BR1NK assault rifle."
     bHeaddie=True
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_SWC_Pro.BRINKAssaultRifle'
     DeathString="%o's head was ripped of by %k's Brink rifle."
     FemaleSuicide="%o looked down the mouth of her Brink."
     MaleSuicide="%o looked down the mouth of his Brink."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
