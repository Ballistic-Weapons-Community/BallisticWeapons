//=============================================================================
// DTAM67LaserHeadBal.
//
// DT for AM67 laser headshots. Adds red blinding effect and motion blur
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAM67LaserHead extends DT_BWMiscDamage;

var float	FlashF;
var vector	FlashV;

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
     DeathStrings(0)="%o's head was illuminated off by %k's AM67 beam."
     DeathStrings(1)="%k burned %o's eye out with %kh laser."
     DeathStrings(2)="%k carved a smile on %o's face with %kh AM67 laser."
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=3.000000
     bUseMotionBlur=True
     WeaponClass=Class'BallisticProV55.AM67Pistol'
     DeathString="%k burned %o's eye out with %kh laser."
     FemaleSuicide="%o put her eye out with an AM67."
     MaleSuicide="%o put his eye out with an AM67."
     bInstantHit=True
     GibModifier=3.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
