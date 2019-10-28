//=============================================================================
// DT_AS50Head
//
// Damage type for FSSG-50 headsharts
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AS50Head extends DT_BWBullet;

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
     DeathStrings(0)="%k's FSSG-50 assassinated %o with a headshot."
     DeathStrings(1)="%k sent a FSSG-50 round clean through %o's skull."
     DeathStrings(2)="%k terminated %o with an accurate FSSG-50 headshot."
     DeathStrings(3)="%o unfortunately took %k's FSSG-50 round right to the face."
     HipString="Luck"
     AimedString="Scoped"
     FlashThreshold=90
     bIgniteFires=True
     bHeaddie=True
     InvasionDamageScaling=2.000000
     DamageIdent="Sniper"
     bDisplaceAim=True
     AimDisplacementDamageThreshold=100
     AimDisplacementDuration=0.400000
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBPRecolorsPro.AS50Rifle'
     DeathString="%k's FSSG-50 assassinated %o with a headshot."
     FemaleSuicide="%o's FSSG-50 took her head off."
     MaleSuicide="%o's FSSG-50 took his head off."
     bFastInstantHit=True
     bAlwaysSevers=True
     bExtraMomentumZ=True
     GibModifier=1.200000
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.500000
}
