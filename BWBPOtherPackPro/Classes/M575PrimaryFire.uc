//=============================================================================
// M353PrimaryFire.
//
// Extremely automatic, bullet style instant hit. Shots are long ranged,
// powerful and sort of accurate when gun is mountued and used carefully.
// Accuracy decreases very quickly especially if player is moving and the
// ridiculous fire rate makes it even worse. Mounting the gun can solve the
// problem though.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M575PrimaryFire extends BallisticProInstantFire;

defaultproperties
{
	 FlashBone="MuzzleFlash"
     TraceRange=(Min=15000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     WallPenetrationForce=48.000000
     
     Damage=15.000000
     DamageHead=30.000000
     DamageLimb=12.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTM353MG'
     DamageTypeHead=Class'BallisticProV55.DTM353MGHead'
     DamageTypeArm=Class'BallisticProV55.DTM353MG'
     KickForce=2000
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M353FlashEmitter'
     FlashScaleFactor=0.700000
     BrassClass=Class'BallisticProV55.Brass_MG'
     BrassOffset=(X=6.000000,Y=10.000000)
     RecoilPerShot=128.000000
     FireChaosCurve=(Points=(,(InVal=0.240000),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=16.000000
     YInaccuracy=16.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.M353.M353-Fire1',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.085000
     AmmoClass=Class'BallisticProV55.Ammo_556mmBelt'
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-10.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     WarnTargetPct=0.200000
     aimerror=900.000000
	 AimedFireAnim="ScopeOut"
}
