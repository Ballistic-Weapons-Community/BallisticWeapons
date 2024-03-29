//=============================================================================
// DT_MP40Head.
//
// DamageType for MP40 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MP40Head_Incendiary extends DT_BWBullet;

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
     DeathStrings(0)="%o wasn't just lobotomized by %k's FMP bullets, %ve was decapitated."
     DeathStrings(1)="%k executed the %o from the old guard with a fiery bullet to the back of the head."
     DeathStrings(2)="%o's brains were reduced to nothing after losing the war to %k."
     bHeaddie=True
	 bIgniteFires=True
	 EffectChance=1.000000
     WeaponClass=Class'BWBP_SKC_Pro.FMPMachinePistol'
     DeathString="%o was lobotomized by %k's FMP bullets."
     FemaleSuicide="%o shot herself in the face."
     MaleSuicide="%o shot himself in the face."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.650000
}
