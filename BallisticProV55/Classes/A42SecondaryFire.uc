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

function float ResolveDamageFactors(Actor Other, vector TraceStart, vector HitLocation, int PenetrateCount, int WallCount, int WallPenForce, Vector WaterHitLocation)
{
	KickForce = (FMin(HoldTime, ChargeTime) / ChargeTime) * InstantEffectParams(Params.FireEffectParams[0]).MomentumTransfer;
    
	return super.ResolveDamageFactors(Other, TraceStart, HitLocation, PenetrateCount, WallCount, WallPenForce, WaterHitLocation) * (FMin(HoldTime, ChargeTime) / ChargeTime);
}

simulated event ModeDoFire()
{
	local float f;
	
	f = (FMin(HoldTime, ChargeTime) / ChargeTime) * AmmoPerFire;

	Load = Max(1, f);
	
	Weapon.AmbientSound = None;
	
	A42SkrithPistol(Weapon).NextAmmoTickTime = Level.TimeSeconds + 2;
	
	super.ModeDoFire();
}

defaultproperties
{
	ChargeTime=1.000000
	ChargeSound=Sound'BW_Core_WeaponSound.A42.A42-Charge'

	AmmoClass=Class'BallisticProV55.Ammo_A42Charge'

	ShakeRotMag=(X=128.000000,Y=64.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-10.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000

    bFireOnRelease=True
	
	// AI
    BotRefireRate=0.7
    bTossed=False
    bLeadTarget=False
    bInstantHit=True
	AimError=600
}
