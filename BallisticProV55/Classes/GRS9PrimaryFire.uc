//=============================================================================
// GRS9PrimaryFire.
//
// Low power, low range, low recoil pistol fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRS9PrimaryFire extends BallisticProInstantFire;

simulated function OnEffectParamsChanged(int EffectIndex)
{
	super.OnEffectParamsChanged(EffectIndex);
	
    if (GRS9Pistol(Weapon).bHasKnife)
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
	if (BW.MagAmmo - ConsumedLoad < 2)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		//AimedFireAnim = 'SightFireOpen';
		AimedFireAnim = 'OpenFire';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		//AimedFireAnim = 'SightFire';
		AimedFireAnim = 'Fire';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}

defaultproperties
{
    TraceRange=(Min=4000.000000,Max=4000.000000)
    DamageType=Class'BallisticProV55.DTGRS9Pistol'
    DamageTypeHead=Class'BallisticProV55.DTGRS9PistolHead'
    DamageTypeArm=Class'BallisticProV55.DTGRS9Pistol'
    PenetrateForce=100
    bPenetrate=True
    MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
    FlashScaleFactor=2.500000
    BrassClass=Class'BallisticProV55.Brass_GRSNine'
    BrassBone="tip"
    BrassOffset=(X=-30.000000,Y=1.000000)
    FireRecoil=120.000000
    FireChaos=0.120000
    XInaccuracy=64.000000
    YInaccuracy=64.000000
    BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-Fire',Volume=1.200000)
    FireEndAnim=
    AimedFireAnim='SightFire'
    FireAnimRate=1.700000
    FireRate=0.050000
    AmmoClass=Class'BallisticProV55.Ammo_GRSNine'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-60.000000)
	ShakeOffsetTime=2.000000

    // AI
    bInstantHit=True
    bLeadTarget=False
    bTossed=False
    bSplashDamage=False
    bRecommendSplashDamage=False
    BotRefireRate=0.99
    WarnTargetPct=0.2
}
