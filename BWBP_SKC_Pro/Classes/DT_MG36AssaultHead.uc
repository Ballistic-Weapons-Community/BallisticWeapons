//=============================================================================
// DT_MG36AssaultHead.
//
// DamageType for MG36 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MG36AssaultHead extends DT_BWBullet;

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
	 DeathStrings(0)="%k spotted %o. with night vision and put a bullet through his skull."
     DeathStrings(1)="%o's skull became the next target for %k's MG36."
     DeathStrings(2)="%k quietly turned %o's skull into mincemeat."
     DeathStrings(3)="%o head is now a trophy for %k's collection."
	 bHeaddie=True
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_SKC_Pro.MG36Carbine'
     DeathString="%o had %vh brain shredded by %k's MJ51."
     FemaleSuicide="%o took the easy way out."
     MaleSuicide="%o took the easy way out."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=1.000000
}
