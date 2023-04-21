//=============================================================================
// MRT6PrimaryFire.
//
// Double barreld fire for MRT6. Huge spread, low range and high damage. must
// be cocked after each of these shots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MRT6PrimaryFire extends BallisticProShotgunFire;

event ModeDoFire()
{
	if (!MRT6Shotgun(Weapon).bLeftLoaded && MRT6Shotgun(Weapon).bRightLoaded)
		BW.BFireMode[1].ModeDoFire();
	else
		super.ModeDoFire();
}

function EjectBrass()
{
	BrassBone='EjectorL';
	BrassClass=Class'Brass_MRT6Left';
	super.EjectBrass();
	BrassBone='EjectorR';
	BrassClass=Class'Brass_MRT6Right';
	super.EjectBrass();
}

function InitEffects()
{
}

function FlashMuzzleFlash()
{
	local Coords C;
	local vector Start;
	local Actor MuzzleSmoke;

    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

	BW.BFireMode[1].MuzzleFlash.Trigger(Weapon, Instigator);
	MRT6SecondaryFire(BW.BFireMode[1]).MuzzleFlash2.Trigger(Weapon, Instigator);

	if (!class'BallisticMod'.default.bMuzzleSmoke)
		return;
	C = Weapon.GetBoneCoords('tip2');
	Start = C.Origin + C.XAxis * -5 + C.YAxis * 3 + C.ZAxis * 0;
	MuzzleSmoke = Spawn(class'MRT6Smoke', weapon,, Start, Rotator(C.XAxis));
	C = Weapon.GetBoneCoords('tip');
	Start = C.Origin + C.XAxis * -5 + C.YAxis * 3 + C.ZAxis * 0;
	MuzzleSmoke = Spawn(class'MRT6Smoke', weapon,, Start, Rotator(C.XAxis));

	if (!bBrassOnCock)
		EjectBrass();
}

defaultproperties
{
	HipSpreadFactor=1.250000
	TraceCount=14
	TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
	ImpactManager=Class'BallisticProV55.IM_Shell'
	TraceRange=(Min=2048.000000,Max=2048.000000)
	DamageType=Class'BallisticProV55.DTMRT6Shotgun'
	DamageTypeHead=Class'BallisticProV55.DTMRT6ShotgunHead'
	DamageTypeArm=Class'BallisticProV55.DTMRT6Shotgun'
	KickForce=400
	PenetrateForce=0
	bPenetrate=False
	WallPenetrationForce=0
	bCockAfterFire=True
	MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
	FlashScaleFactor=1.200000
	BrassClass=Class'BallisticProV55.Brass_Shotgun'
	BrassBone="EjectorR"
	bBrassOnCock=True
	BrassOffset=(X=15.000000,Y=-13.000000,Z=7.000000)
	FireRecoil=1024.000000
	FirePushbackForce=1200.000000
	FireChaos=0.450000
	XInaccuracy=600.000000
	YInaccuracy=378.000000
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6Fire')
	FireRate=0.800000
	AmmoClass=Class'BallisticProV55.Ammo_12Gauge'
	AmmoPerFire=2

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
	WarnTargetPct=0.75
}
