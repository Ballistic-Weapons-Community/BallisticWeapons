//=============================================================================
// SARPrimaryFire.
//
// Average power, 600RpM, rifle range, low accuracy assault rifle fire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class M7A3PrimaryFire extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=10000.000000,Max=12000.000000)
     Damage=20.000000
     RangeAtten=0.800000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBP_JCF_Pro.DTM7A3Rifle'
     DamageTypeHead=Class'BWBP_JCF_Pro.DTM7A3RifleHead'
     DamageTypeArm=Class'BWBP_JCF_Pro.DTM7A3Rifle'
     KickForce=10000
     PenetrateForce=450
     bPenetrate=True
     //ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBP_JCF_Pro.M7A3FlashEmitter'
     FlashScaleFactor=0.100000
     BrassClass=Class'BWBP_JCF_Pro.Brass_M7A3AR'
     BrassBone="tip"
	 AimedFireAnim="SightFire"
     BrassOffset=(X=-105.000000,Y=-10.000000,Z=-1.000000)
     FireRecoil=60.000000
     FireChaos=0.10000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     BallisticFireSound=(Sound=Sound'BWBP_JCF_Sounds.M7A3.M7A3_Fire_M',Volume=1.000000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.095000
     AmmoClass=Class'BallisticProV55.Ammo_RS762mm'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-300.000000)
     ShakeOffsetTime=1.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
