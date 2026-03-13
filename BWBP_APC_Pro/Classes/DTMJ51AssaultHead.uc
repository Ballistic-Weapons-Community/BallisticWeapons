//=============================================================================
// DTMJ51AssaultHead.
//
// DamageType for MJ51 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMJ51AssaultHead extends DT_BWBullet;

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


// Decompiled with UE Explorer.
defaultproperties
{
    bHeaddie=true
    DeathStrings=/* Array type was not detected. */
    WeaponClass=Class'MJ51Carbine'
    DeathString="%o got %vh brain shredded by %k's MJ51."
    FemaleSuicide="%o saw a bullet coming up the barrel of her MJ51."
    MaleSuicide="%o saw a bullet coming up the barrel of his MJ51."
    bFastInstantHit=true
    bAlwaysSevers=true
    bSpecial=true
    PawnDamageSounds=/* Array type was not detected. */
    GibPerterbation=0.2000000
    KDamageImpulse=1000.0000000
    VehicleDamageScaling=0.6500000
}