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
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'AimedFire';
		FireAnim = 'Fire';
	}
	else
	{
		AimedFireAnim='SightFireCombined';
		FireAnim = 'FireCombined';
	}
	super.PlayFiring();
}

function ServerPlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'AimedFire';
		FireAnim = 'Fire';
	}
	else
	{
		AimedFireAnim='SightFireCombined';
		FireAnim = 'FireCombined';
	}
	super.ServerPlayFiring();
}

defaultproperties
  {
  HipSpreadFactor=3.000000
  MaxSpreadFactor=3.000000
  CutOffDistance=1536.000000
  CutOffStartRange=768.000000
  TraceCount=10
  TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
  ImpactManager=Class'BallisticProV55.IM_Shell'
  TraceRange=(Min=7000.000000,Max=7000.000000)
  MaxWalls=1
  Damage=11.000000
  DamageHead=16.000000
  DamageLimb=11.000000
  RangeAtten=0.200000
  DamageType=Class'BallisticProV55.DTMRS138Shotgun'
  DamageTypeHead=Class'BallisticProV55.DTMRS138ShotgunHead'
  DamageTypeArm=Class'BallisticProV55.DTMRS138Shotgun'
  KickForce=4000
  PenetrateForce=120
  bPenetrate=True
  MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
  BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
  BrassOffset=(X=45.000000,Y=-20.000000,Z=35.000000)
  RecoilPerShot=1280.000000
  FireChaos=0.400000
  XInaccuracy=250.000000
  YInaccuracy=250.000000
  BallisticFireSound=(Sound=Sound'BWAddPack-RS-Sounds.MRS38.RSS-Fire',Volume=1.500000)
  FireAnim="FireCombined"
  FireEndAnim=
  FireRate=0.450000
  AmmoClass=Class'BallisticProV55.Ammo_MRS138Shells'
  ShakeRotMag=(X=128.000000,Y=64.000000)
  ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
  ShakeRotTime=2.000000
  ShakeOffsetMag=(X=-30.000000)
  ShakeOffsetRate=(X=-1000.000000)
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
