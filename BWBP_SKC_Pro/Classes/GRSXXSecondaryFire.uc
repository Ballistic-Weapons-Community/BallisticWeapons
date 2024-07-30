//=============================================================================
// GRS9SecondaryFire.
//
// Burning laser fire that fires while altfire is held. Uses a special recharging
// ammo counter with a small limiting delay after releasing fire.
// Switches on weapon's laser sight when firing for effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRSXXSecondaryFire extends BallisticProInstantFire;

var() sound		FireSoundLoop;
var   float		StopFireTime;
var   bool		bLaserFiring;

simulated function bool AllowFire()
{
	if (level.TimeSeconds - StopFireTime < 0.8 || GRSXXPistol(Weapon).LaserAmmo <= 0 || !super.AllowFire())
	{
		if (bLaserFiring)
			StopFiring();
		return false;
	}
	return true;
}

simulated function bool HasAmmo()
{
	return GRSXXPistol(Weapon).LaserAmmo > 0;
}

simulated function bool CheckWeaponMode()
{
	if (Weapon.IsInState('DualAction') || Weapon.IsInState('PendingDualAction'))
		return false;
	return true;
}

function DoFireEffect()
{
	GRSXXPistol(Weapon).LaserAmmo -= 0.15;
	GRSXXPistol(Weapon).ServerSwitchLaser(true);
	bLaserFiring=true;
	super.DoFireEffect();
}

function PlayFiring()
{
	super.PlayFiring();
	if (FireSoundLoop != None)
		Instigator.AmbientSound = FireSoundLoop;
	bLaserFiring=true;
}

function StopFiring()
{
	bLaserFiring=false;
	Instigator.AmbientSound = None;
	GRSXXPistol(Weapon).ServerSwitchLaser(false);
	StopFireTime = level.TimeSeconds;
}

simulated event ModeDoFire()
{
	if (GRSXXPistol(Weapon).bBigLaser)
		BallisticFireSound.Sound = default.BallisticFireSound.Sound;
	else
		BallisticFireSound.Sound = None;
	super.ModeDoFire();
}

simulated function ApplyRecoil ()
{
	if (BW != None)
		BW.AddRecoil(FireRecoil, ThisModeNum);
}

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	BallisticWeapon(Weapon).TargetedHurtRadius(7, 20, class'DTGRS9Laser', 0, HitLocation, Pawn(Other));
	return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}

simulated state AmpAttach
{
	simulated event ModeDoFire()
	{
		if (!Instigator.IsLocallyControlled())
			return;
		if (super(BallisticProInstantFire).AllowFire())
			GRSXXPistol(Weapon).ToggleAmplifier();
	}
}

defaultproperties
{
     FireSoundLoop=Sound'BWBP_SKC_Sounds.Glock_Gold.G-Glk-LaserBurn'    
     DamageType=Class'BWBP_SKC_Pro.DTGRSXXLaser'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXLaserHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXLaser'
     PenetrateForce=200
     bPenetrate=True
     bUseWeaponMag=False
     FlashBone="tip2"
     FireChaos=0.000000
     XInaccuracy=2.000000
     YInaccuracy=2.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Glock_Gold.G-Glk-LaserFire')
     FireAnim="Idle"
     FireRate=0.080000
     AmmoClass=Class'BallisticProV55.Ammo_GRSNine'
     AmmoPerFire=0
     BotRefireRate=0.999000
     WarnTargetPct=0.010000
     aimerror=900.000000
}
