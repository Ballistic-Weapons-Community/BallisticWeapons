//=============================================================================
// RS04PrimaryFire.
//
// Med power, med range, low recoil pistol fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RS04PrimaryFire extends BallisticProInstantFire;


simulated function OnEffectParamsChanged(int EffectIndex)
{
	super.OnEffectParamsChanged(EffectIndex);
	
    if (RS04Pistol(Weapon).bHasKnife)
        ApplyTacKnifeEffectParams();
}

simulated function ApplyTacKnifeEffectParams()
{
	FireRecoil *= 1.5;
	FireChaos = 1;
    XInaccuracy	= 256;
    YInaccuracy = 256;
}

simulated function PlayFireAnimations()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'IdleOpen';
		BW.ReloadAnim = 'ReloadOpen';

		if (BW.CurrentWeaponMode == 1)
		{
			AimedFireAnim = 'FireOpen';
			FireAnim = 'FireDualOpen';
		}
		else
		{
			AimedFireAnim = 'SightFireOpen';
			FireAnim = 'FireOpen';
		}
	}
	
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';

		if (BW.CurrentWeaponMode == 1)
		{
			FireAnim = 'FireDual';
			AimedFireAnim = 'Fire';
		}
		else
		{
			AimedFireAnim = 'SightFire';
			FireAnim = 'Fire';
		}
	}

	Super.PlayFireAnimations();
}

defaultproperties
{
	TraceRange=(Max=5500.000000)
	DamageType=Class'BWBP_SKC_Pro.DTRS04Pistol'
	DamageTypeHead=Class'BWBP_SKC_Pro.DTRS04PistolHead'
	DamageTypeArm=Class'BWBP_SKC_Pro.DTRS04Pistol'
	KickForce=15000
	PenetrateForce=150
	bPenetrate=True
	MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
	BrassClass=Class'BallisticProV55.Brass_Pistol'
	BrassOffset=(X=-25.000000)
	FireRecoil=215.000000
	//SilencedFireSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.M1911-FireSil',Volume=0.800000,Radius=24.000000,bAtten=True)
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.M1911-Fire',Volume=1.200000)
	bModeExclusive=False
	FireEndAnim=
	FireRate=0.180000
	FireAnimRate=1.75
	FireChaos=0.200000
	XInaccuracy=16.000000
	YInaccuracy=16.000000
	AmmoClass=Class'BallisticProV55.Ammo_45HV'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-60.000000)
	ShakeOffsetTime=2.000000

	BotRefireRate=0.300000
	WarnTargetPct=0.100000
	aimerror=900.000000
}
