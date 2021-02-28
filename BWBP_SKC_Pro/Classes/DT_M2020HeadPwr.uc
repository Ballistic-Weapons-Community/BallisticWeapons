//=============================================================================
// DT_M2020HeadPwr.
//
// DamageType for M2020 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_M2020HeadPwr extends DT_BWBullet;

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
     DeathStrings(0)="%o's head got in the way of %k's M2020 gauss round."
     DeathStrings(1)="%k's M2020 opened %o's mind to the wonders of electromagnets"
     DeathStrings(2)="%k's M2020 wiped the smile clean off %o's face."
     HipString="Luck"
     AimedString="Scoped"
     bHeaddie=True
     DamageIdent="Sniper"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=150
     AimDisplacementDuration=0.65
	 InvasionDamageScaling=2
     WeaponClass=Class'BWBP_SKC_Pro.M2020GaussDMR'
     DeathString="%o's head got in the way of %k's M2020 gauss round."
     FemaleSuicide="%o wanted to experience magnetic acceleration first hand!"
     MaleSuicide="%o wanted to experience magnetic acceleration first hand!"
     bArmorStops=False
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.800000
}
