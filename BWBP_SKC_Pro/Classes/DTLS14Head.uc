//=============================================================================
// DTLS14Head.
//
// DT for LS14 headshots. Adds blue blinding effect and motion blur.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTLS14Head extends DT_BWMiscDamage;

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
     DeathStrings(0)="%o was lasered right between the eyes by %k's carbine."
     DeathStrings(1)="%k's LS-14 decapitated %o and cauterized the stump."
     DeathStrings(2)="%k accurately melted %o's retinas with a blue LS-14 laser."
     DeathStrings(3)="%o's teeth were precisely disintegrated by %k's LS-14."
     SimpleKillString="LS-14 Single Barrel"
     BloodManagerName="BloodMan_HMCLaser"
     FlashThreshold=0
     FlashV=(X=700.000000,Y=700.000000,Z=2000.000000)
     FlashF=0.300000
     ShieldDamage=5
     bIgniteFires=True
     bHeaddie=True
     DamageIdent="Sniper"
     DamageDescription=",Laser,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBP_SKC_Pro.LS14Carbine'
     DeathString="%o was lasered right between the eyes by %k's carbine."
     FemaleSuicide="%o blasted her eyes out."
     MaleSuicide="%o blasted himself in the eye."
     bInstantHit=True
     bAlwaysSevers=True
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
