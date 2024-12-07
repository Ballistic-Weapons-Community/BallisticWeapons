//=============================================================================
// MD24PrimaryFire.
//
// Decent pistol shots that are accurate if the gun is steady enough
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class MD24PrimaryFire extends BallisticProInstantFire;

simulated function OnEffectParamsChanged(int EffectIndex)
{
	super.OnEffectParamsChanged(EffectIndex);
	
    if (MD24Pistol(Weapon).bHasKnife)
        ApplyTacKnifeEffectParams();
}

simulated function ApplyTacKnifeEffectParams()
{
	FireRecoil *= 1.5;
	FireChaos = 1;
    XInaccuracy	= 256;
    YInaccuracy = 256;
}

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		AimedFireAnim = 'SightOpenFire';
		FireAnim = 'NewOpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		AimedFireAnim = 'SightFire';
		FireAnim = 'NewFire';
	}
	super.PlayFiring();
}

defaultproperties
{
	TraceRange=(Min=4000.000000,Max=4000.000000)
	WallPenetrationForce=8.000000
	WaterRangeAtten=0.500000
	DamageType=Class'BallisticProV55.DTMD24Pistol'
	DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
	DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
	PenetrateForce=150
	bPenetrate=True
	MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
	FlashScaleFactor=0.750000
	BrassClass=Class'BallisticProV55.Brass_Pistol'
	BrassOffset=(X=-10.000000)
	AimedFireAnim="SightFire"
	FireRecoil=140.000000
	FireChaos=0.200000
	XInaccuracy=96.000000
	YInaccuracy=96.000000
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Fire',Volume=4.000000)
	FireEndAnim=
	FireAnimRate=1.450000
	FireRate=0.13000
	AmmoClass=Class'BallisticProV55.Ammo_MD24Clip'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-60.000000)
	ShakeOffsetTime=2.000000

	BotRefireRate=0.900000
	WarnTargetPct=0.300000
}
