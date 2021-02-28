//=============================================================================
// DTM50AssaultHead.
//
// DamageType for M50 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMX32PrimaryHead extends DT_BWBullet;

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
     DeathStrings(0)="%o died due to lead poisoning and decapitation thanks to %k's MX32."
     DeathStrings(1)="%k turned %o's head to stew meat."
     DeathStrings(2)="%o's gray matter was ejected by %k's MX32."
     DeathStrings(3)="%k’s low caliber leadstorm shredded %o's head finely."
     bHeaddie=True
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_OP_Pro.MX32Weapon'
     DeathString="%o died due to lead poisoning and decapitation thanks to %k's MX32."
     FemaleSuicide="%o saw a bullet coming up the barrel of her MX32."
     MaleSuicide="%o saw a bullet coming up the barrel of his MX32."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.000000
}
