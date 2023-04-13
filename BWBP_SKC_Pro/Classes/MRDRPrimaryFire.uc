//=============================================================================
// MRDRPrimaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MRDRPrimaryFire extends BallisticProInstantFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 2)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}

defaultproperties
{
     DamageType=Class'BWBP_SKC_Pro.DT_MRDR88Body'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_MRDR88Head'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_MRDR88Body'
     PenetrateForce=0
     bPenetrate=False
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-2',Volume=0.800000,Radius=24.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryPistol',Volume=0.700000)
     MuzzleFlashClass=Class'BWBP_SKC_Pro.MRDRFlashEmitter'
     FlashScaleFactor=0.600000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-25.000000,Z=-5.000000)
     FireRecoil=64.000000
     FireChaos=0.100000
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.MRDR.MRDR-Fire')
     bPawnRapidFireAnim=True
     FireRate=0.120000
     AmmoClass=Class'BallisticProV55.Ammo_9mm'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
}
