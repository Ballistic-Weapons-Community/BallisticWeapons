//=============================================================================
// DT_VSKTranqHead.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_VSKTranqHead extends DT_BWMiscDamage;

var float	FlashF2;
var vector	FlashV2;

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF2, default.FlashV2);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     FlashF2=0.300000
     FlashV2=(Y=2000.000000)
     DeathStrings(0)="%o took %k's tranquilizer dart in the face."
     DeathStrings(1)="%k subdued %o with a VSK-42 dart to the face."
     DeathStrings(2)="%k's VSK-42 nonlethally pincushioned %o's head."
     DeathStrings(3)="%k's tranq dart lodged itself in %o's eye."
     bDetonatesBombs=False
     DamageDescription=",Gas,GearSafe,Hazard,"
     MinMotionBlurDamage=1.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=12.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBP_SKCExp_Pro.VSKTranqRifle'
     DeathString="%o took %k's tranquilizer dart in the face."
     FemaleSuicide="%o knocked herself out."
     MaleSuicide="%o knocked himself out."
     bInstantHit=True
     bCausesBlood=False
     bDelayedDamage=True
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'BWBP_SKC_Sounds.VSK.VSK-ImpactFlesh'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.001000
     KDamageImpulse=90000.000000
     VehicleDamageScaling=0.001000
     VehicleMomentumScaling=0.001000
}
