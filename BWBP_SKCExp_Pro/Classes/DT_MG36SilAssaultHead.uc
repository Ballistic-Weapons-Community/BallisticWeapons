//=============================================================================
// DT_MG36SilAssaultHead.
//
// DamageType for _MG360 Silent Headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MG36SilAssaultHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's head was picked off by %k's silent MG36."
     DeathStrings(1)="%o throughts were silenced by %k's MG36."
     DeathStrings(2)="%k's MG36 spat death in %o's face."
     SimpleKillString="MG36 Night Ops Suppressed"
     bHeaddie=True
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_SKCExp_Pro.MG36Carbine'
     DeathString="%o's head was picked off by %k's silent MG36."
     FemaleSuicide="%o saw a bullet coming up the barrel of her MG36."
     MaleSuicide="%o saw a bullet coming up the barrel of his MG36."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=1.000000
}
