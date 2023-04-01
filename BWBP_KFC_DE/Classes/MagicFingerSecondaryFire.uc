//=============================================================================
// FIRE THE LASERS
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MagicFingerSecondaryFire extends BallisticProjectileFire;

var   float RailPower;
var   float ChargeRate;
var   float PowerLevel;
var   int SoundAdjust;
var   float MaxCharge;
var   sound	ChargeSound;


defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000) //SPAWN THE OFFSET
     bCockAfterFire=True //Cock the AFTERFIRE
     MuzzleFlashClass=Class'BallisticDE.M50M900FlashEmitter'
     XInaccuracy=4.000000
     YInaccuracy=4.000000
     BallisticFireSound=(Sound=SoundGroup'PackageSounds4F.FART.FAR-AltFire',Volume=9.700000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bFireOnRelease=True
     bWaitForRelease=True
     bModeExclusive=False //PROPRIETARY
     FireEndAnim=
     FireAnim="Altfier"
     AmmoClass=Class'BWBP_KFC_DE.Ammo_Imagination'
     AmmoPerFire=52//PYES
     TweenTime=0.000000
     FireRate=0.800000
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_KFC_DE.MagicFingerSoul'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
