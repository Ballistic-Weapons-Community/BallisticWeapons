//=============================================================================
// FM14 Nail Slug
//
// Fires slug that detonates on impact with shrapnel
//
// by Azarael
//=============================================================================
class FM14SecondaryFire extends BallisticProjectileFire;

//===========================================================================
// AllowFire
//
// Handles cocking
//===========================================================================
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	if (!FM14Shotgun(BW).bAltLoaded)
		return false;
    return true;
}

simulated function ModeDoFire()
{
	Super.ModeDoFire();
	FM14Shotgun(BW).bAltLoaded=False;
	FM14Shotgun(BW).PrepPriFire();
}

defaultproperties
{
     bUseWeaponMag=False
     FlashScaleFactor=2.000000
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     AimedFireAnim="SightFire"
     FireRecoil=1280.000000
     FireChaos=0.500000
     BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-Fire',Volume=1.300000)
     FireAnim="Fire"
     FireEndAnim=
     FireAnimRate=1.100000
     FireRate=0.750000
     AmmoClass=Class'BWBP_APC_Pro.Ammo_FM13Gas'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
	 ProjectileClass=Class'BWBP_APC_Pro.FM14FlakGrenade'
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=True
	 bRecommendSplashDamage=False
	 BotRefireRate=0.3
     WarnTargetPct=0.75
}
