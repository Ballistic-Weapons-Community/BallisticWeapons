//=============================================================================
// BOGPPrimaryFire.
//
// Fires either an explode on impact grenade, or a burning hot flare to set players ablaze!
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class ThumperSecondaryFire extends BallisticProProjectileFire;

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FlashBone="tip"
     FireChaos=0.700000
     XInaccuracy=64.000000
     YInaccuracy=64.000000
	 BallisticFireSound=(Sound=Sound'BWBP_SKC_SoundsExp.M780.M780-Fire',Volume=1.750000) bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bModeExclusive=True
     PreFireAnim=
     FireForce="AssaultRifleAltFire"
     AmmoClass=Class'BWBP_SKCExp_Pro.Ammo_ThumperGrenades'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_SKCExp_Pro.ThumperSmokeGrenade'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
