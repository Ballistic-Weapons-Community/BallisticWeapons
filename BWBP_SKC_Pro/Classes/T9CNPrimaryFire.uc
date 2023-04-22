//=============================================================================
// MRDRPrimaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class T9CNPrimaryFire extends BallisticProInstantFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'IdleOpen';
		BW.ReloadAnim = 'ReloadOpen';
		FireAnim = 'FireOpen';
		AimedFireAnim = 'SightFireOpen';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		FireAnim = 'Fire';
		AimedFireAnim = 'SightFire';
	}
	super.PlayFiring();
}

defaultproperties
{
	DamageType=Class'BWBP_SKC_Pro.DTT9CN'
	DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
	DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
	PenetrateForce=0
	bPenetrate=False
	ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-2',Volume=0.800000,Radius=48.000000,bAtten=True)
	DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryPistol',Volume=0.700000)
	MuzzleFlashClass=Class'BWBP_SKC_Pro.T9CNFlashEmitter'
	FlashScaleFactor=0.600000
	BrassClass=Class'BallisticProV55.Brass_GRSNine'
	BrassOffset=(X=-25.000000,Z=-5.000000)
	FireRecoil=64.000000
	FireChaos=0.100000
	XInaccuracy=48.000000
	YInaccuracy=48.000000
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-FireOld',Volume=1.300000)
	bPawnRapidFireAnim=True
	FireRate=0.120000
	AmmoClass=Class'BallisticProV55.Ammo_GRSNine'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-60.000000)
	ShakeOffsetTime=2.000000
}
