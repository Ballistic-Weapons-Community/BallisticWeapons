//=============================================================================
// M763PrimaryFire.
//
// Powerful shotgun blast with moderate spread and fair range for a shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PugPrimaryFire extends BallisticProShotgunFire;

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
     TraceCount=7
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=2560.000000,Max=2560.000000)
	 DecayRange=(Min=1024,Max=1536)
     Damage=11.000000

     RangeAtten=0.250000
     DamageType=Class'BWBP_SKC_Pro.DTSKASShotgun'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgun'
     KickForce=400
     PenetrateForce=100
     bPenetrate=True
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     FireRecoil=450.000000
     FirePushbackForce=180.000000
     FireChaos=0.300000
     XInaccuracy=310.000000
     YInaccuracy=310.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Single',Volume=1.300000)
     FireAnim="Fire"
     FireEndAnim=
     FireAnimRate=1.500000
     FireRate=0.300000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_SKASShells'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.400000
}
