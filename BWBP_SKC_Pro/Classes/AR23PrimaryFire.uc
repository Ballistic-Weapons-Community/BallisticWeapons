//=============================================================================
// AR23PrimaryFire.
//
// Very automatic, bullet style instant hit. Shots are long ranged, powerful
// and accurate when used carefully. The dissadvantages are severely screwed up
// accuracy after firing a shot or two and the rapid rate of fire means ammo
// dissapeares quick.
//
// by Marc "Sgt Kelly" Moylan.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AR23PrimaryFire extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=12000.000000,Max=15000.000000)
     //WaterRangeFactor=0.800000
     //WallPenetrationForce=48.000000
     //MaxWalls=3
	 //PenetrateForce=250
	 
	 Damage=60.000000
     HeadMult=1.4f
     LimbMult=0.5f
	 
     WaterRangeAtten=0.800000
     KickForce=16000
     bPenetrate=True
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticProV55.Brass_M46AR'
     BrassOffset=(Y=10.000000)
     FireRecoil=512.000000
     FirePushbackForce=250.000000
     XInaccuracy=1.500000
     YInaccuracy=1.500000
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-HFire',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
	 FireAnim="Fire"
	 AimedFireAnim="Fire"
     TweenTime=0.000000
     FireRate=0.170000
     AmmoClass=Class'BallisticProV55.Ammo_50CalBelt'
     ShakeRotMag=(X=256.000000,Y=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1500.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
