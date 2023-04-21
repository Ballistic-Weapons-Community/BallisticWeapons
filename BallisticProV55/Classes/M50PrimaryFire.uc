//=============================================================================
// M50PrimaryFire.
//
// Very automatic, bullet style instant hit. Shots are long ranged, powerful
// and accurate when used carefully. The dissadvantages are severely screwed up
// accuracy after firing a shot or two and the rapid rate of fire means ammo
// dissapeares quick.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M50PrimaryFire extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=12000.000000,Max=15000.000000)
     WallPenetrationForce=16.000000
     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTM50Assault'
     DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
     DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=1.25
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassBone="tip"
     BrassOffset=(X=-80.000000,Y=1.000000)
     AimedFireAnim="AimedFire"
     FireRecoil=118.000000
     FireChaos=0.02
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Fire2',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.090000
     AmmoClass=Class'BallisticProV55.Ammo_556mm'

     ShakeRotMag=(X=48.000000)
     ShakeRotRate=(X=960.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-7.00)
     ShakeOffsetRate=(X=-100.000000)
     ShakeOffsetTime=2.000000
	 
     WarnTargetPct=0.200000
     aimerror=900.000000
}
