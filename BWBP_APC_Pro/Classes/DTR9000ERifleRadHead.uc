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
class DTR9000ERifleRadHead extends DT_BWBullet;

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
     DeathStrings(0)="%o received brain cancer from %k's Chimera."
     DeathStrings(1)="%k found that radioactive magnum bullets are good for melting the flesh off of %o's face."
     DeathStrings(2)="%o's cranium was splattered and scattered by %k and their irradiated Chimera."
     DeathStrings(3)="%k made radioactive soup out of %o, using radiation and gray matter respectively."
	 DeathStrings(4)="%o had their atoms and head separated from their shoulder by %k."
	 DeathStrings(5)="%k's Chimera slurped %o's brains down like a milkshake."
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
