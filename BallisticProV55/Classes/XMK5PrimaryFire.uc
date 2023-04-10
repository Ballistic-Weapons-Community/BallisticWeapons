//=============================================================================
// XMK5PrimaryFire.
//
// Standard SubMachinegun bullets, bang bang!
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class XMK5PrimaryFire extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=4096.000000,Max=4096.000000)
     WallPenetrationForce=8.000000
     
     Damage=22.000000
     HeadMult=1.4f
     LimbMult=0.6f
     
     RangeAtten=0.200000
     WaterRangeAtten=0.200000
     DamageType=Class'BallisticProV55.DTXMK5SubMachinegun'
     DamageTypeHead=Class'BallisticProV55.DTXMK5SubMachinegunHead'
     DamageTypeArm=Class'BallisticProV55.DTXMK5SubMachinegun'
     PenetrateForce=175
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-2',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.XMk5FlashEmitter'
     FlashScaleFactor=0.800000
     BrassClass=Class'BallisticProV55.Brass_XMK5SMG'
     AimedFireAnim="AimedFire"
     FireRecoil=110.000000
     FireChaos=0.035000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=64.000000
     YInaccuracy=64.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_Fire1',Volume=1.350000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.085000
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
