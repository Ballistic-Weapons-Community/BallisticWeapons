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
class DTR9000ERifleHead extends DT_BWBullet;

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
     DeathStrings(0)="%o got some unwanted tracheotomy from %k's sniper rifle."
     DeathStrings(1)="%k adapted to the situation and sniped off %o's head."
     DeathStrings(2)="%o failed to see the glint of %k's Chimera and got a bullet to the eye."
     DeathStrings(3)="%k's Chimera was a carnivore and took a bite out of %o's brains."
     DeathStrings(4)="%o took %k's .338 to the teeth, shattering the cavities to pieces."
     DeathStrings(5)="%k had no reason to amp %kh rifle to nail %o right between the eyes."
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
