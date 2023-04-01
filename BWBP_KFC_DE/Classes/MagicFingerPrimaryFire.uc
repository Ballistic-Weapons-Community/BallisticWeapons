//=============================================================================
// Who killed the president?
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MagicFingerPrimaryFire extends BallisticInstantFire;

defaultproperties
{
     TraceRange=(Min=12.000000,Max=1200.000000)
     RangeAtten=0.350000
     WaterRangeAtten=0.300000
     DamageType=Class'BWBP_KFC_DE.DTMagicFingerHit'
     DamageTypeHead=Class'BWBP_KFC_DE.DTMagicFingerHit'
     DamageTypeArm=Class'BWBP_KFC_DE.DTMagicFingerHit'
     KickForce=3000000
     PenetrateForce=200
     bPenetrate=True
     DryFireSound=(Sound=Sound'PackageSounds4F.FART.FAR-Fire5',Volume=0.700000)
     MuzzleFlashClass=Class'BallisticDE.D49FlashEmitter'
     FlashScaleFactor=0.100000
     bDryUncock=True
     XInaccuracy=20.000000
     YInaccuracy=1.000000
     FireChaos=60.300000
     BallisticFireSound=(Sound=SoundGroup'PackageSounds4F.FART.FAR-Fire',Volume=1.700000,Radius=128.000000,bAtten=True)
     bWaitForRelease=False
     FireEndAnim=
     FireAnim="BangBang"
     TweenTime=0.000000
     AmmoClass=Class'BWBP_KFC_DE.Ammo_Imagination'
     AmmoPerFire=12
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
