//=============================================================================
// SPASPrimaryFire.
//
// Semi auto shotgun fire. Rapid but inaccurate.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SPASPrimaryFire extends BallisticProShotgunFire;

defaultproperties
{
	 HipSpreadFactor=3.000000
	 DecayRange=(Min=1280,Max=2536)
	 TraceCount=6
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=7500.000000,Max=7500.000000)
     Damage=9.000000
     RangeAtten=0.30000
     DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
     DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
     DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
     KickForce=8000
     PenetrateForce=100
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     bBrassOnCock=True
     FireRecoil=650.000000
     XInaccuracy=170.000000
     YInaccuracy=170.000000
	 FlashScaleFactor=0.35
	 FireChaos=0.3
     BallisticFireSound=(Sound=Sound'BWBP_JCF_Sounds.SPAS.SPAS-FireOld2',Volume=1.500000)
     FireAnim="Fire"
	 AimedFireAnim="SightFire"
     FireEndAnim=
	 FireRate=0.450000
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
