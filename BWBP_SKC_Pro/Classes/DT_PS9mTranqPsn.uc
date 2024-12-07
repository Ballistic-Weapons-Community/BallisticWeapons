//=============================================================================
// DT_PS9mTranqPsn.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_PS9mTranqPsn extends DT_BWMiscDamage;

var float	FlashF1;
var vector	FlashV1;

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF1, default.FlashV1);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     FlashF1=0.400000
     FlashV1=(Y=2000.000000)
     DeathStrings(0)="%o was fatally poisoned by %k's PS9m."
     DeathStrings(1)="%k's PS9m made %o take a dirt nap."
     DeathStrings(2)="%o was overdosed by %k's toxin dart."
     DeathStrings(3)="%k's neurotoxin dart put %o under."
     bDetonatesBombs=False
     DamageDescription=",Gas,GearSafe,Hazard,"
     MinMotionBlurDamage=1.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=3.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBP_SKC_Pro.PS9mPistol'
     DeathString="%o was knocked out by %k's PS9m."
     FemaleSuicide="%o knocked herself out."
     MaleSuicide="%o knocked himself out."
     bArmorStops=False
     bInstantHit=True
     bCausesBlood=False
     bDelayedDamage=True
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'BWBP_SKC_Sounds.VSK.VSK-Poison'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.001000
     KDamageImpulse=90000.000000
     VehicleDamageScaling=0.001000
     VehicleMomentumScaling=0.001000
}
