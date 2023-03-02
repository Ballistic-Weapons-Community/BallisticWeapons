//=============================================================================
// DTsyrpois.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTsyrpois extends DTJunkDamage;

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
     DeathStrings(0)="%o was knocked out by %k's poison."
     DeathStrings(1)="%k's posion put %o into a deep sleep."
     DeathStrings(2)="%o died painless after being poisoned by %k."
     DeathStrings(3)="%k's poison put %o out cold."
     DeathStrings(4)="%k nonlethally downed %o with poison."
     bDetonatesBombs=False
     DamageDescription=",Gas,GearSafe,Hazard,"
     MinMotionBlurDamage=1.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=3.000000
     bUseMotionBlur=True
     WeaponClass=None
     DeathString="%o was knocked out by %k's poison."
     FemaleSuicide="%o knocked herself out."
     MaleSuicide="%o knocked himself out."
     bArmorStops=False
     bCausesBlood=False
     bDelayedDamage=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.001000
     KDamageImpulse=90000.000000
     VehicleDamageScaling=0.001000
     VehicleMomentumScaling=0.001000
}
