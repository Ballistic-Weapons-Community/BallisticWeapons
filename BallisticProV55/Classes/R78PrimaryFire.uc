//=============================================================================
// R78PrimaryFire.
//
// Very accurate, long ranged and powerful bullet fire. Headshots are
// especially dangerous.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class R78PrimaryFire extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=96.000000
     MaxWalls=2
     Damage=100.000000
     DamageHead=145.000000
     DamageLimb=100.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTR78Rifle'
     DamageTypeHead=Class'BallisticProV55.DTR78RifleHead'
     DamageTypeArm=Class'BallisticProV55.DTR78Rifle'
     KickForce=6000
     PenetrateForce=150
     bPenetrate=True
     PDamageFactor=0.800000
     bCockAfterFire=True
     MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     bBrassOnCock=True
     BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
     RecoilPerShot=1024.000000
     FireChaos=0.500000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.R78.R78-Fire',Radius=256.000000)
     FireEndAnim=
     FireRate=1.000000
     AmmoClass=Class'BallisticProV55.Ammo_42Rifle'
     ShakeRotMag=(X=400.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.300000
     WarnTargetPct=0.050000
     aimerror=800.000000
}
