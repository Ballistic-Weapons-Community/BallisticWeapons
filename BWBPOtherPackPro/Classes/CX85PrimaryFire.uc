class CX85PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=6144.000000
     CutOffStartRange=3072.000000
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WallPenetrationForce=16.000000
     
     Damage=21.000000
     
     
     RangeAtten=0.350000

     DamageType=Class'BWBPOtherPackPro.DTCX85Bullet'
     DamageTypeHead=Class'BWBPOtherPackPro.DTCX85BulletHead'
     DamageTypeArm=Class'BWBPOtherPackPro.DTCX85Bullet'
     KickForce=4000
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=0.800000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassBone="tip"
     BrassOffset=(X=-80.000000,Y=1.000000)
     FireRecoil=120.000000
     FireChaos=0.080000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,Pitch=1.500000,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.090000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_CX85Bullets'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
