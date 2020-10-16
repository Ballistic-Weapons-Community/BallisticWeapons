//=============================================================================
// LS-14 Primary Fire.
//
// Laser weapon with overheating mechanism. Deals more damage the lower the weapon's heat level is.
// Does not cut out if maximum heat is reached.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20PrimaryFire extends BallisticRangeAttenFire;

var()	float			HeatPerShot;

simulated function bool AllowFire()
{
	if (XM20AutoLas(BW).bShieldUp)
		return false;
	return Super.AllowFire();
}

//The XM20 deals increased damage to targets which have already been heated up by a previous strike.
function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{	
	if (Pawn(Target) != None && Pawn(Target).bProjTarget)
		Damage += XM20AutoLas(BW).ManageHeatInteraction(Pawn(Target), HeatPerShot);
	
	if (Monster(Target) != None)
		Damage = Min(Damage, 40);

	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
}

defaultproperties
{
	HeatPerShot=8.000000
	CutOffDistance=3072.000000
	CutOffStartRange=1536.000000
	TraceRange=(Min=11000.000000,Max=12000.000000)
	WallPenetrationForce=64.000000

	Damage=12.000000
	DamageHead=18.000000
	DamageLimb=12.000000
	DamageType=Class'BWBPSomeOtherPack.DTXM20Body'
	DamageTypeHead=Class'BWBPSomeOtherPack.DTXM20Head'
	DamageTypeArm=Class'BWBPSomeOtherPack.DTXM20Body'
	PenetrateForce=500
	bPenetrate=True
	ClipFinishSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-LastShot',Volume=1.000000,Radius=48.000000,bAtten=True)
	DryFireSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-Empty',Volume=1.200000)
	MuzzleFlashClass=Class'BWBPSomeOtherPack.XM20FlashEmitter'
	FlashScaleFactor=0.400000
	FireRecoil=128.000000
	FireChaos=0.07000
	FireAnim="Fire"
	AimedFireAnim="SightFire"
	BallisticFireSound=(Sound=SoundGroup'PackageSounds4Pro.XM20.XM20-PulseFire',Volume=1.500000)
	FireEndAnim=
	FireRate=0.135000
	AmmoClass=Class'BWBPSomeOtherPack.Ammo_XM20Laser'
	ShakeRotMag=(X=200.000000,Y=16.000000)
	ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
	ShakeRotTime=1.000000
	ShakeOffsetMag=(X=-2.500000)
	ShakeOffsetRate=(X=-500.000000)
	ShakeOffsetTime=1.000000

	BotRefireRate=0.99
	WarnTargetPct=0.30000
	aimerror=800.000000
}
