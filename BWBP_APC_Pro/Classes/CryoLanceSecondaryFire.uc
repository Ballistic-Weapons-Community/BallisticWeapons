//=============================================================================
// CryoLanceSecondaryFire.
//
// A 40mm shockwave grenade that does damage over time
// Will deonate after 3 shockwaves.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CryoLanceSecondaryFire extends BallisticProProjectileFire;

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FlashBone="tip2"
     FireRecoil=1024.000000
     FireChaos=0.500000
     XInaccuracy=8.000000
     YInaccuracy=8.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bModeExclusive=False
	 PreFireAnim="GLPrepFire"	 
     FireAnim="GLFire"
     FireForce="AssaultRifleAltFire"
	 AimedFireAnim="GLSightFireFromPrep"	 
     FireRate=0.800000
     AmmoClass=Class'BallisticProV55.Ammo_556mm'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_APC_Pro.CryoLanceGrenade'
     BotRefireRate=0.300000
     WarnTargetPct=0.600000
}
