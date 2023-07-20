//=============================================================================
// SK410PrimaryFire.
//
// Moderately strong shotgun blast with decent spread and fair range for a shotgun.
// Can do more damage than the M763, but requires more shots normally.
//
// Can fire its shells HE mode, however it's nowhere near as strong as a FRAG.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SK410SecondaryFire extends BallisticProProjectileFire;

// Returns normal for some random spread. This is seperate from GetFireDir for shotgun reasons mainly...
simulated function vector GetFireSpread()
{
	local float fX;
	local Rotator R;

	if (BW.bScopeView)
		return super.GetFireSpread();

	fX = frand();
	R.Yaw =  600 * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
	R.Pitch = 600 * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
	return Vector(R);
}

defaultproperties
{
     SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BWBP_SKC_Pro.Brass_ShotgunHE'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     AimedFireAnim="SightFire"
     FireRecoil=650.000000
     FirePushbackForce=180.000000
     FireChaos=0.450000
     XInaccuracy=384.000000
     YInaccuracy=384.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-FireFRAG',Volume=1.300000)
     FireEndAnim=
     FireAnimRate=1.250000
     FireRate=0.650000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_8GaugeHE'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-12.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_SKC_Pro.SK410HEProjectile'
	 
	 // AI
	 bInstantHit=False
	 bLeadTarget=True
	 bTossed=True
	 bSplashDamage=True
	 bRecommendSplashDamage=False
	 BotRefireRate=0.6
     WarnTargetPct=0.4
}
