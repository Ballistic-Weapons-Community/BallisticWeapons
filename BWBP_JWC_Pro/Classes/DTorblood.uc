//=============================================================================
// DTorblood.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTorblood extends DTJunkDamage;

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
     DeathStrings(0)="%o bled out."
     DeathStrings(1)="%o died of blood loss."
     bDetonatesBombs=False
     DamageDescription=",Gas,GearSafe,Hazard,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=1.000000
     bUseMotionBlur=True
     WeaponClass=None
     DeathString="%o was knocked out by blood loss."
     FemaleSuicide="%o knocked herself out."
     MaleSuicide="%o knocked himself out."
     bArmorStops=False
     bDelayedDamage=True
     DamageOverlayTime=0.900000
     GibPerterbation=0.600000
     KDamageImpulse=90000.000000
     VehicleDamageScaling=0.001000
     VehicleMomentumScaling=0.001000
}
