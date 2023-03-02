//=============================================================================
// DTHMCBeamHead.
//
// DT for HMC Beam headshots. Adds red blinding effect and motion blur
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHMCBeamHead extends DT_BWMiscDamage;

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF, default.FlashV);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     FlashF=0.300000
     FlashV=(X=2000.000000,Y=700.000000,Z=700.000000)
     DeathStrings(0)="%o's head was partially melted by %k's HMC beam."
     DeathStrings(1)="%k welded %o's mouth shut."
     DeathStrings(2)="%k blinded %o with %kh giant HMC laser."
     BloodManagerName="BWBP_SKCExp_Pro.BloodMan_HMCLaser"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=3.000000
     bUseMotionBlur=True
     ShieldDamage=3
     bIgniteFires=True
     bPowerPush=True
     bHeaddie=True
     DamageIdent="Energy"
     WeaponClass=Class'BWBP_SKCExp_Pro.HMCBeamCannon'
     DeathString="%o's head was partially melted by %k's HMC beam."
     FemaleSuicide="%o showed truly exemplary marksmanship with her HMC laser."
     MaleSuicide="%o ate his own laser."
     bInstantHit=True
     bAlwaysSevers=True
     GibModifier=3.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
