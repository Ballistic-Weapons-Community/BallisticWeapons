//=============================================================================
// DTGASCPistolHead.
//
// Damage type for the GASC Pistol headshots
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTGASCPistolHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's head was whisked away by %k's GASC round."
     DeathStrings(1)="%k whipped %o's head off with %kh GASC pistol."
     DeathStrings(2)="%k's GASC round cleared away %o's cranium."
     bHeaddie=True
     DamageIdent="Pistol"
     WeaponClass=Class'BWBP_APC_Pro.GASCPistol'
     DeathString="%o's head was whisked away by %k's GASC round."
     FemaleSuicide="%o blew her ugly face off with an GASC."
     MaleSuicide="%o blew his ugly face off with an GASC."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     VehicleDamageScaling=0.000000
}
