//=============================================================================
// XM20PrimaryFire.
//
// Automatic laser fire. Low recoil, easy to control. Pew pew.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20PrimaryFire extends BallisticProInstantFire;

simulated function bool AllowFire()
{
	if (XM20Carbine(BW).bShieldUp)
		return false;
	
    if (super.AllowFire())
	{ 
		if (XM20Carbine(BW).bIsCharging)
			return false;
		else
			return true;
	}
    return super.AllowFire();
}

//The XM20 deals increased damage to targets which have already been heated up by a previous strike.
function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{	
	if (Pawn(Target) != None && Pawn(Target).bProjTarget)
		Damage += XM20Carbine(BW).ManageHeatInteraction(Pawn(Target), HeatPerShot);
	
	if (Monster(Target) != None)
		Damage = Min(Damage, 35);

	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
}

defaultproperties
{
	HeatPerShot=8.000000
	TraceRange=(Min=5000.000000,Max=7500.000000)
	MaxWaterTraceRange=5000
	DamageType=Class'BWBP_SKC_Pro.DT_XM20_Body'
	DamageTypeHead=Class'BWBP_SKC_Pro.DT_XM20_Head'
	DamageTypeArm=Class'BWBP_SKC_Pro.DT_XM20_Body'
	PenetrateForce=600
	bPenetrate=False
	FlashScaleFactor=0.300000
	MuzzleFlashClass=Class'BWBP_SKC_Pro.XM20FlashEmitter'
	FireRecoil=96.000000
	YInaccuracy=16.000000
	BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.XM20.XM20-PulseFire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	FireEndAnim=None
	AimedFireAnim="SightFire"
	TweenTime=0.000000
	FireRate=0.150000
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_Laser'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-70.000000)
	ShakeOffsetTime=2.000000

	BotRefireRate=0.900000
	WarnTargetPct=0.100000
	aimerror=800.000000
}
