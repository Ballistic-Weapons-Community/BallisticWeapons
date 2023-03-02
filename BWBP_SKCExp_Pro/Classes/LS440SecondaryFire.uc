//=============================================================================
// LS440SecondaryFire.
//
// Death super laser. Is actually primary fire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class LS440SecondaryFire extends BallisticInstantFire;

var() int SplashDamage;
var() int SplashDamageRadius;



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

     TraceRange=(Min=1500000.000000,Max=1500000.000000)
     Damage=180
     HeadMult=1.5
     LimbMult=1.0
	 SplashDamage=50
	 SplashDamageRadius=96
     DamageType=Class'BWBP_SKCExp_Pro.DT_LS440Instagib'
     DamageTypeHead=Class'BWBP_SKCExp_Pro.DT_LS440Instagib'
     DamageTypeArm=Class'BWBP_SKCExp_Pro.DT_LS440Instagib'
     KickForce=25000
     PenetrateForce=500
     bPenetrate=True
	FireAnim="FireBig"
     ClipFinishSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-LastShot',Volume=1.000000,Radius=48.000000,bAtten=True)
     MuzzleFlashClass=Class'BWBP_SKCExp_Pro.A48FlashEmitter'
//     MuzzleFlashClass=Class'BWBP_SKCExp_Pro.GRSXXLaserFlashEmitter'
//     MuzzleFlashClass=Class'BWBP_SKCExp_Pro.VSKSilencedFlash'
     FlashScaleFactor=0.400000
    // RecoilPerShot=100.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FireInstagib',Volume=2.000000)
     FireEndAnim=
	AmmoPerFire=25
     TweenTime=0.000000
     FireRate=2.500000
     AmmoClass=Class'BWBP_SKCExp_Pro.Ammo_HVPCCells'
     ShakeRotMag=(X=200.000000,Y=16.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=-2.500000)
     ShakeOffsetRate=(X=-500.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=1.050000
     WarnTargetPct=0.050000
     aimerror=800.000000
}
