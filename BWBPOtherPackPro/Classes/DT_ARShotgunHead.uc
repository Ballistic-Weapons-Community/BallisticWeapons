//=============================================================================
// DT_SK410Head.
//
// Damage type for the DT_SK410 DT_SK410DT_SK410DT_SK410.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_ARShotgunHead extends DT_BWBullet;

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
	 DeathStrings(0)="%o had their head tactically busted off by %k's RCS-715."
     DeathStrings(1)="%k shredded %o's head to pieces with their RCS-715 shells."
     DeathStrings(2)="%k emptied their RCS-715 drum magazine all over %o's head."
     DeathStrings(3)="%o's head was met with a barrage of RCS-715 shotgun shells from %k."
     DeathStrings(4)="%o had their brains busted by %k's RCS-715."
     EffectChance=0.500000
     bIgniteFires=True
     bHeaddie=True
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBPOtherPackPro.ARShotgun'
     DeathString="%o had their head tactically busted off by %k's RCS-715."
     FemaleSuicide="%o pointed her RCS-715 the wrong way round."
     MaleSuicide="%o pointed his RCS-715 the wrong way round."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     GibPerterbation=1.600000
     KDamageImpulse=1000.000000
}
