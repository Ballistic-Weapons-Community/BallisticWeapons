//=============================================================================
// MRS138PrimaryFire.
//
// Stronger than the M763, but has a shorter range, wider spread and slower fire rate.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MRS138PrimaryFire extends BallisticProShotgunFire;

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1 )
	{
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	else
	{
		if (class'BallisticReplicationInfo'.static.IsClassic()) //Slow cock anims
		{
			AimedFireAnim='AimedFire';
			FireAnim = 'Fire';
		}
		else
		{
			AimedFireAnim='SightFireCombined';
			FireAnim = 'FireCombined';
		}
	}
	super.PlayFiring();
}

function ServerPlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1 )
	{
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	else
	{
		if (class'BallisticReplicationInfo'.static.IsClassic())
		{
			AimedFireAnim='AimedFire';
			FireAnim = 'Fire';
		}
		else
		{
			AimedFireAnim='SightFireCombined';
			FireAnim = 'FireCombined';
		}
	}
	super.ServerPlayFiring();
}

defaultproperties
{
	HipSpreadFactor=1.500000
	TraceCount=8
	TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
	ImpactManager=Class'BallisticProV55.IM_Shell'
	TraceRange=(Min=2048.000000,Max=2048.000000)
	DamageType=Class'BallisticProV55.DTMRS138Shotgun'
	DamageTypeHead=Class'BallisticProV55.DTMRS138ShotgunHead'
	DamageTypeArm=Class'BallisticProV55.DTMRS138Shotgun'
	KickForce=400
	PenetrateForce=0
	bPenetrate=False
	MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
	BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
	BrassOffset=(X=45.000000,Y=-20.000000,Z=35.000000)
	bBrassOnCock=True
	FireRecoil=512.000000
	FireChaos=0.400000
	XInaccuracy=256.000000
	YInaccuracy=256.000000
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-Fire',Volume=1.500000)
	FireAnim="FireCombined"
	FireEndAnim=
	FireRate=0.550000
	AmmoClass=Class'BallisticProV55.Ammo_MRS138Shells'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-15.00)
	ShakeOffsetRate=(X=-300.000000)
	ShakeOffsetTime=2.000000

	// AI
	bInstantHit=True
	bLeadTarget=False
	bTossed=False
	bSplashDamage=False
	bRecommendSplashDamage=False
	BotRefireRate=0.7
	WarnTargetPct=0.5
}
