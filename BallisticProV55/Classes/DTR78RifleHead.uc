//=============================================================================
// DTR78RifleHead.
//
// Damage type for the R78 Sniper Rifle headshots
//
// Removed A1 designation, as M16 and M4 death messages rarely list it.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTR78RifleHead extends DT_BWBullet;

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
     DeathStrings(0)="%k's precision sniping sent %o's head spiralling into the distance."
     DeathStrings(1)="%k's R78 bullet turned %o's face into hamburger."
     DeathStrings(2)="%o's head was preyed upon by %k's Raven."
     DeathStrings(3)="%k's expert marksmanship brought an end to %o's paltry attempts at stealth."
     HipString="Luck"
     AimedString="Scoped"
     bSnipingDamage=True
     bHeaddie=True
     InvasionDamageScaling=2.000000
     DamageIdent="Sniper"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=150
     WeaponClass=Class'BallisticProV55.R78Rifle'
     DeathString="%o's head was removed from the scene by %k's R78."
     FemaleSuicide="%o sniped off her own head."
     MaleSuicide="%o sniped off his own head."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.150000
}
