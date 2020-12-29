//=============================================================================
// XM20PrimaryFire.
//
// Automatic laser fire. Low recoil, easy to control. Pew pew.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20BPrimaryFire extends BallisticProInstantFire;

var()	float			HeatPerShot;

simulated function bool AllowFire()
{
    if (super.AllowFire())
	{ 
		if (XM20BCarbine(BW).bIsCharging)
			return false;
		else
			return true;
	}
    return super.AllowFire();
}

//The XM20B deals increased damage to targets which have already been heated up by a previous strike.
function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{	
	if (Pawn(Target) != None && Pawn(Target).bProjTarget)
		Damage += XM20BCarbine(BW).ManageHeatInteraction(Pawn(Target), HeatPerShot);
	
	if (Monster(Target) != None)
		Damage = Min(Damage, 35);

	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
}

defaultproperties
{
     HeatPerShot=8.000000
     TraceRange=(Min=5000.000000,Max=7500.000000)
     Damage=16
     RangeAtten=0.900000
     WaterRangeAtten=0.700000
     DamageType=Class'BWBPOtherPackPro.DT_XM20B_Body'
     DamageTypeHead=Class'BWBPOtherPackPro.DT_XM20B_Head'
     DamageTypeArm=Class'BWBPOtherPackPro.DT_XM20B_Body'
     PenetrateForce=600
     bPenetrate=False
     FlashScaleFactor=0.300000
     MuzzleFlashClass=Class'BWBPOtherPackPro.XM20BFlashEmitter'
     FireRecoil=96.000000
     YInaccuracy=16.000000
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.XM20.XM20-PulseFire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     FireEndAnim=None
     TweenTime=0.000000
     FireRate=0.150000
     AmmoPerFire=2
     AmmoClass=Class'BWBPOtherPackPro.Ammo_XM20B'
     ShakeRotMag=(X=200.000000,Y=8.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=0.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-500.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
     aimerror=800.000000
}
