//=============================================================================
// DTGRS9LaserHead.
//
// DT for GRS9 laser headshots. Adds red blinding effect and motion blur
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHMCBlastHead extends DT_BWMiscDamage;

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF, default.FlashV);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

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
     FlashF=0.300000
     FlashV=(X=2000.000000,Y=700.000000,Z=700.000000)
     DeathStrings(0)="%o was blinded during %k's HMC pulse test."
     DeathStrings(1)="%k's HMC tested the heat shields of %o's face."
     DeathStrings(2)="%k overcharged %o's face with an HMC pulse."
     BloodManagerName="BWBP_SKC_Pro.BloodMan_HMCLaser"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     bUseMotionBlur=True
     ShieldDamage=5
     bIgniteFires=True
     bHeaddie=True
     InvasionDamageScaling=2.500000
     DamageIdent="Energy"
     WeaponClass=Class'BWBP_SKC_Pro.HMCBeamCannon'
     DeathString="%o was blinded during %k's HMC pulse test."
     FemaleSuicide="%o self tested her own HMC laser blast."
     MaleSuicide="%o self tested his own HMC laser blast."
     bInstantHit=True
     bAlwaysSevers=True
     GibModifier=3.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
