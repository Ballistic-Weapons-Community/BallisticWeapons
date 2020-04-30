//=============================================================================
// A42SecondaryFire.
//
// Instant beam that varies in power depending on holdtime.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A42SecondaryFire extends BallisticProInstantFire;
var() float ChargeTime;
var() Sound	ChargeSound;

simulated function PlayPreFire()
{
	Weapon.AmbientSound = ChargeSound;
	Weapon.SoundPitch = 56;
	if (!BW.bScopeView)
		BW.SafeLoopAnim('SecIdle', 1.0, TweenTime, ,"IDLE");
}
function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	KickForce = (FMin(HoldTime, ChargeTime) / ChargeTime) * default.KickForce;
	return super.GetDamage (Other, HitLocation, Dir, Victim, DT) * (FMin(HoldTime, ChargeTime) / ChargeTime);
}
simulated event ModeDoFire()
{
	local float f;
	f = (FMin(HoldTime, ChargeTime) / ChargeTime) * default.AmmoPerFire;
	AmmoPerFire = f;
	Weapon.AmbientSound = None;
	A42SkrithPistol(Weapon).NextAmmoTickTime = Level.TimeSeconds + 2;
	super.ModeDoFire();
}

defaultproperties
{
	ChargeTime=1.000000
	ChargeSound=Sound'BallisticSounds2.A42.A42-Charge'
	TraceRange=(Min=8000.000000,Max=8000.000000)
	WallPenetrationForce=8.000000
	Damage=45.000000
	DamageHead=90.000000
	DamageLimb=45.000000
	DamageType=Class'BallisticProV55.DTA42SkrithBeam'
	DamageTypeHead=Class'BallisticProV55.DTA42SkrithBeam'
	DamageTypeArm=Class'BallisticProV55.DTA42SkrithBeam'
	KickForce=80000
	PenetrateForce=150
	MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
	RecoilPerShot=96.000000
	XInaccuracy=2.000000
	YInaccuracy=2.000000
	BallisticFireSound=(Sound=Sound'BallisticSounds3.A42.A42-SecFire',Volume=0.800000)
	bFireOnRelease=True
	FireAnim="SecFire"
	FireRate=0.300000
	AmmoClass=Class'BallisticProV55.Ammo_A42Charge'
	AmmoPerFire=6
	ShakeRotMag=(X=128.000000,Y=64.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-10.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	
	// AI
	bSplashDamage=False
    bRecommendSplashDamage=False
    BotRefireRate=0.7
    bTossed=False
    bLeadTarget=False
    bInstantHit=True
	AimError=600
    WarnTargetPct=0.500000
}
