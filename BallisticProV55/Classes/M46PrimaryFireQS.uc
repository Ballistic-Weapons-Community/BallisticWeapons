//=============================================================================
// M46PrimaryFireQS.
//=============================================================================
class M46PrimaryFireQS extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=12000.000000,Max=15000.000000)
     WallPenetrationForce=24.000000
     Damage=30.000000
     
     
     RangeAtten=0.40000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTM46AssaultQS'
     DamageTypeHead=Class'BallisticProV55.DTM46AssaultQSHead'
     DamageTypeArm=Class'BallisticProV55.DTM46AssaultQS'
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M46FlashEmitter'
     FlashScaleFactor=0.450000
     BrassClass=Class'BallisticProV55.Brass_M46AR'
     BrassOffset=(Y=10.000000)
     AimedFireAnim="AimedFire"
     FireRecoil=170.000000
     FireChaos=0.032000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_Fire1',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.135000
     AmmoClass=Class'BallisticProV55.Ammo_M46Clip'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=700.000000
}
