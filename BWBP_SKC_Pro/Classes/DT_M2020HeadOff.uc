//=============================================================================
// DT_M2020HeadOff.
//
// DamageType for M2020 headshots, gauss offline or deflecting
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_M2020HeadOff extends DT_BWBullet;

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
     DeathStrings(0)="%o's head got in the way of %k's M2020 round."
     DeathStrings(1)="%k's M2020 opened %o's cranium"
     DeathStrings(2)="%k's M2020 wiped the smile clean off %o's face."
     HipString="Luck"
     AimedString="Scoped"
     bHeaddie=True
     DamageIdent="Sniper"
     WeaponClass=Class'BWBP_SKC_Pro.M2020GaussDMR'
     DeathString="%o's head got in the way of %k's M2020 round."
     FemaleSuicide="%o looked down her M2020 barrel."
     MaleSuicide="%o looked down his M2020 barrel."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     KDamageImpulse=1000.000000
}
