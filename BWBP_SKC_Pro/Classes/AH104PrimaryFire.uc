//  =============================================================================
//   AH104PrimaryFire.
//  
//   Very powerful, long range bullet attack.
//  
//   You'll be attacked with bullets.
//   Hello whoever is reading this.
//  =============================================================================
class AH104PrimaryFire extends BallisticInstantFire;

var() sound		FireSound1;
var() sound		FireSound2;
var() int SplashDamage;
var() int SplashDamageRadius;

simulated event ModeDoFire()
{
	if (AH104Pistol(Weapon).bFireSound1) 
		     BallisticFireSound.Sound=FireSound1;
	else if (AH104Pistol(Weapon).bFireSound2) 
		     BallisticFireSound.Sound=FireSound2;
	Super.ModeDoFire();

}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim.bProjTarget)
	{
		BW.TargetedHurtRadius(SplashDamage, SplashDamageRadius, class'DT_AH104Pistol', 200, HitLocation, Pawn(Victim));
	}
}

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	if (Other == None || Other.bWorldGeometry)
		BW.TargetedHurtRadius(SplashDamage, SplashDamageRadius, DamageType, 0, HitLocation);
	return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}


defaultproperties
{
     FireSound1=Sound'BWBP_SKC_Sounds.AH104.AH104-Blast2'
     FireSound2=Sound'BWBP_SKC_Sounds.AH104.AH104-Blast'
     TraceRange=(Min=6000.000000,Max=6500.000000)
     PDamageFactor=0.800000
     WallPDamageFactor=0.800000
	 SplashDamage=10
	 SplashDamageRadius=32
     DamageType=Class'BWBP_SKC_Pro.DT_AH104Pistol'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_AH104PistolHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_AH104Pistol'
     KickForce=35000
     PenetrateForce=250
     bPenetrate=True
     DryFireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-DryFire',Volume=1.000000)
     bDryUncock=True
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     FlashScaleFactor=1.100000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     FireChaos=-10.000000
     XInaccuracy=3.000000
     YInaccuracy=3.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Super',Volume=7.100000)
     FireEndAnim=
	 AimedFireAnim="SightFire"
     TweenTime=0.000000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_600HEAP'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
