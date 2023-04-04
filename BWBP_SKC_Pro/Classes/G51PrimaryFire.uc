//=============================================================================
// G51PrimaryFire.
//
// 3-Round burst. Shots are powerful and easy to follow up.
// Not very accurate at range, and hindered by burst fire up close.
// Excels at mid range combat.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class G51PrimaryFire extends BallisticProInstantFire;

simulated event ModeDoFire()
{
	if (G51Carbine(Weapon).bLoaded)
	{
		G51Carbine(Weapon).IndirectLaunch();
		return;
	}
	if (!AllowFire())
		return;
		
	super.ModeDoFire();
}

defaultproperties
{
     TraceRange=(Min=10000.000000,Max=13000.000000)
     WallPenetrationForce=18.000000
     Damage=26.000000
     RangeAtten=0.900000
     WaterRangeAtten=0.700000
     DamageType=Class'BWBP_SKC_Pro.DT_G51Assault'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_G51AssaultHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_G51AssaultLimb'
     KickForce=18000
     PenetrateForce=150
     bPenetrate=True
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-20.000000,Y=1.000000)
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     MuzzleFlashClass=Class'BWBP_SKC_Pro.G51FlashEmitter'
     FlashScaleFactor=0.500000
     AimedFireAnim="SightFire"
     FireRecoil=128.000000
     FireChaos=0.040000
     XInaccuracy=16.000000
     YInaccuracy=16.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ55-Fire')
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.100000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_556mmSTANAG'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
}
