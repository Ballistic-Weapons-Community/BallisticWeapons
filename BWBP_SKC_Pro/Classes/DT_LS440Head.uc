//=============================================================================
// DTLS440Head.
//
// DT for LS440 headshots. Adds RED blinding effect and motion blur.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LS440Head extends DT_BWMiscDamage;


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
     DeathStrings(0)="%o's face was doctored up by %k's lethal LS-440."
     DeathStrings(1)="%k's laser eye surgery on %o went horribly wrong."
     DeathStrings(2)="%k submitted %o to LS-440 cranial surgery."
     DeathStrings(3)="%o's head is incompatible with %k's LS-440 wavelengths."
     BloodManagerName="BWBP_SKC_Pro.BloodMan_HMCLaser"
     ShieldDamage=5
     bIgniteFires=True
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     bUseMotionBlur=True
     DamageDescription=",Laser,"
     WeaponClass=Class'BWBP_SKC_Pro.LS14Carbine'
     DeathString="%o's face was doctored up by %k's lethal LS-440."
     FemaleSuicide="%o blasted her eyes out."
     MaleSuicide="%o blasted himself in the eye."
     bInstantHit=True
     bAlwaysSevers=True
     GibModifier=3.000000
     GibPerterbation=1.200000
     KDamageImpulse=1000.000000
}
