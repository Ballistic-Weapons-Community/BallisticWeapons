//=============================================================================
// M763PrimaryFire.
//
// Powerful shotgun blast with moderate spread and fair range for a shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SPASPrimarySlugFire extends BallisticInstantFire;


simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
     //HipSpreadFactor=5
	 //TraceCount=12
	 AmmoPerFire=1
     //CutOffDistance=2536.000000
     //CutOffStartRange=1280.000000
     //ImpactManager=Class'BallisticProV55.IM_BigBullet'
     TraceRange=(Min=4000.000000,Max=6000.000000)
     Damage=100.000000
     RangeAtten=0.300000
     DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
     DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
     DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
     KickForce=5000
     PenetrateForce=100
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     bBrassOnCock=True
     FireRecoil=900.000000
	 FirePushBackForce=180.000000
     FireChaos=0.500000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
	 FlashScaleFactor=0.1
     BallisticFireSound=(Sound=Sound'BWBP_JCF_Sounds.DE.Fire_SPAS_Cock',Volume=1.500000)
	 FireAnim="FireCock"
	 AimedFireAnim="SightFireCock"
	 FireEndAnim=
     FireRate=0.80000
     AmmoClass=Class'BallisticProV55.Ammo_12Gauge'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.500000
}
