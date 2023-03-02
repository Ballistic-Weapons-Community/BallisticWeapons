//=============================================================================
// M50SecondaryFire.
//
// A grenade that bonces off walls and detonates a certain time after impact
// Good for scaring enemies out of dark corners and not much else
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HB4PrimaryFire extends BallisticProProjectileFire;

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BWBP_APC_Pro.HB4FlashEmitter'
     AimedFireAnim="SightFire"
     FireRecoil=768.000000
     FireChaos=0.650000
     BallisticFireSound=(Sound=Sound'BWBP_CC_Sounds.EP110.EP110-Fire',Volume=9.500000,Slot=SLOT_Interact,bNoOverride=False)
	 bModeExclusive=False
     FireForce="AssaultRifleAltFire"
     FireRate=0.850000
     AmmoClass=Class'BWBP_APC_Pro.Ammo_HB4'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
	 FlashScaleFactor=0.400000
     ProjectileClass=Class'BWBP_APC_Pro.HB4PulseProjectile'
	 
	 // AI
	 bInstantHit=False
	 bLeadTarget=True
	 bTossed=True
	 bSplashDamage=True
	 bRecommendSplashDamage=True
	 BotRefireRate=0.5
     WarnTargetPct=0.75
}
