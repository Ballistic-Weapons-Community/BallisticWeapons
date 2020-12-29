class DTCX85BulletHead extends DT_BWBullet;

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
     DeathStrings(0)="%o was decapitated by %k with the CX85."
     DeathStrings(1)="%k beheaded %o with %kh CX85."
     bHeaddie=True
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBPOtherPackPro.CX85AssaultWeapon'
     DeathString="%o was decapitated by %k with the CX85."
     FemaleSuicide="%o peered down the barrel of her CX85."
     MaleSuicide="%o peered down the barrel of his CX85."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
}
