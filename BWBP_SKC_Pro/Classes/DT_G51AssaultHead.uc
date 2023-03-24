//=============================================================================
// DT_G51AssaultHead.
//
// DamageType for G51 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_G51AssaultHead extends DT_BWBullet;

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
     DeathStrings(0)="%o got %vh brain shredded by %k's MJ53."
     DeathStrings(1)="%o lost his head thanks to %k's MJ53."
     DeathStrings(2)="%k's MJ53 lifted %o's head off %vh shoulders."
     bHeaddie=True
     WeaponClass=Class'BWBP_SKC_Pro.G51Carbine'
     DeathString="%o got %vh brain shredded by %k's MJ53."
     FemaleSuicide="%o saw a bullet coming up the barrel of her MJ53."
     MaleSuicide="%o saw a bullet coming up the barrel of his MJ53."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.650000
}
