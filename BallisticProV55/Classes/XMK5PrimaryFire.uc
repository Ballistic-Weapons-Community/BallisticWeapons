//=============================================================================
// XMK5PrimaryFire.
//
// Standard SubMachinegun bullets, bang bang!
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class XMK5PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=2560.000000
     CutOffStartRange=1024.000000
     TraceRange=(Min=7000.000000,Max=7000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=48.000000
     MaxWalls=2
     Damage=25.000000
     DamageHead=37.000000
     DamageLimb=25.000000
     RangeAtten=0.2500000
     WaterRangeAtten=0.300000
     DamageType=Class'BallisticProV55.DTXMK5SubMachinegun'
     DamageTypeHead=Class'BallisticProV55.DTXMK5SubMachinegunHead'
     DamageTypeArm=Class'BallisticProV55.DTXMK5SubMachinegun'
     PenetrateForce=175
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-2',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.XMk5FlashEmitter'
     FlashScaleFactor=0.800000
     BrassClass=Class'BallisticProV55.Brass_XMK5SMG'
     BrassOffset=(Y=10.000000)
     AimedFireAnim="AimedFire"
     RecoilPerShot=115.000000
     FireChaos=0.070000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds_25.OA-SMG.OA-SMG_Fire1',Volume=1.350000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.090000
     AmmoClass=Class'BallisticProV55.Ammo_XMK5Clip'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
