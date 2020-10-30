//=============================================================================
// LAWSecondaryFire.
//
// An unignited missile that will do area damage over time.
// Will deonate after 5 shockwaves.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LAWSecondaryFire extends BallisticProProjectileFire;

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FireRecoil=3096.000000
     XInaccuracy=256.000000
     YInaccuracy=256.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.LAW.LAW-Fire',Volume=4.200000,Slot=SLOT_Interact,bNoOverride=False)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     FireForce="AssaultRifleAltFire"
     FireRate=0.600000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_LAW'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPRecolorsPro.LAWGrenade'
     BotRefireRate=0.300000
     WarnTargetPct=1.000000
}
