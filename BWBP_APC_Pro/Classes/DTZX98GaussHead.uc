//=============================================================================
// DTZX98RifleHead.
//
// Damage type for the ZX-98 headshots
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTZX98GaussHead extends DT_BWBullet;

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
     DeathStrings(0)="%o went dark on %k due to having %vh mind blown by the Reaper."
     DeathStrings(1)="%k's Reaper punched a fist-sized hole into %o's tiny head."
     DeathStrings(2)="%o's mind couldn't handle the gauss tech used by %k's Reaper."
     DeathStrings(3)="%k popped off on %o, taking his head off %vh shoulders."
     EffectChance=0.500000
     bHeaddie=True
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_APC_Pro.ZX98AssaultRifle'
     DeathString="%k badgered %o's head off."
     FemaleSuicide="%o routed herself."
     MaleSuicide="%o routed himself."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
