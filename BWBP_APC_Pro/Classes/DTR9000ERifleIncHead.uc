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
class DTR9000ERifleIncHead extends DT_BWBullet;

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
     DeathStrings(0)="%o had %vh brains sizzling by %k's incendiary magnum bullet to the head."
     DeathStrings(1)="%k roasted %o so much that %vh head exploded in a fiery ball."
     DeathStrings(2)="%o's gray matter was the primary ingredient of %k's crispy brains recipe."
     DeathStrings(3)="%k singed %o's tongue after force feeding %vm a very hot bullet down their throat."
     DeathStrings(4)="%o's cheeks were bright red after %k shot %vm with an incendiary amped Chimera."
     DeathStrings(5)="%k turned %o's head into a beacon after igniting %vh cranium."
     HipString="Luck"
     AimedString="Scoped"
     bSnipingDamage=True
     bHeaddie=True
     InvasionDamageScaling=2.000000
     DamageIdent="Sniper"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=150
     WeaponClass=Class'BWBP_APC_Pro.R9000ERifle'
     DeathString="%o's head was removed from the scene by %k's R9000-E."
     FemaleSuicide="%o sniped off her own head."
     MaleSuicide="%o sniped off his own head."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.150000
}
