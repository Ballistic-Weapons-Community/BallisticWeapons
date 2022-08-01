//=============================================================================
// AM67SecondaryLaserFire.
//
// Burning laser fire that fires while altfire is held. Uses a special recharging
// ammo counter with a small limiting delay after releasing fire.
// Switches on weapon's laser sight when firing for effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AM67SecondaryLaserFire extends BallisticInstantFire;

var() sound		FireSoundLoop;
var   bool		bLaserFiring;
var   float		StopFireTime;
var()   float     LaserAmmoPerFire;

simulated function PreBeginPlay()
{
	super(WeaponFire).PreBeginPlay();
	BW = BallisticWeapon(Weapon);
}

simulated function bool AllowFire()
{
	if ((AM67Pistol(Weapon).LaserAmmo < AM67Pistol(Weapon).default.LaserAmmo &&
        !bLaserFiring) || level.TimeSeconds - StopFireTime < 0.75 ||
        AM67Pistol(Weapon).LaserAmmo <= 0 || !super.AllowFire())
	{
		if (bLaserFiring)
			StopFiring();
		return false;
	}
	return true;
}

simulated function bool HasAmmo()
{
	return AM67Pistol(Weapon).LaserAmmo > 0;
}

simulated function bool CheckWeaponMode()
{
	if (Weapon.IsInState('DualAction') || Weapon.IsInState('PendingDualAction'))
		return false;
	return true;
}

function DoFireEffect()
{
	AM67Pistol(Weapon).LaserAmmo -= LaserAmmoPerFire;
	AM67Pistol(Weapon).ServerSwitchLaser(true);
	bLaserFiring=true;
	super.DoFireEffect();
}

//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

    // Loud zappy sound only plays when the laser starts firing.
	if (BallisticFireSound.Sound != none)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	if (FireSoundLoop != None)
		Weapon.AmbientSound = FireSoundLoop;
	bLaserFiring=true;
}
function StopFiring()
{
    bLaserFiring=false;
	Weapon.AmbientSound = None;
	AM67Pistol(Weapon).ServerSwitchLaser(false);
	StopFireTime = level.TimeSeconds;
}

simulated event ModeDoFire()
{
	if (!bLaserFiring)
		BallisticFireSound.Sound = default.BallisticFireSound.Sound;
	else
		BallisticFireSound.Sound = None;
     //Laser eats up more ammo at first, then slows down.  This prevents cherry-tapping.
     LaserAmmoPerFire = default.LaserAmmoPerFire * (1 + 5*FMax(0, AM67Pistol(Weapon).LaserAmmo - 0.5));

	super.ModeDoFire();
}

simulated function ApplyRecoil ()
{
	if (BW != None)
		BW.AddRecoil(FireRecoil, ThisModeNum);
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim.bProjTarget)
	{
		BW.TargetedHurtRadius(3 * (1 + 5*FMax(0, AM67Pistol(Weapon).LaserAmmo - 0.5)), 10, class'DTAM67Laser', 0, HitLocation, Pawn(Victim));
	}
}



defaultproperties
{
     LaserAmmoPerFire=0.050000
     FireSoundLoop=Sound'BW_Core_WeaponSound.Glock.Glk-LaserBurn'
     Damage=(Min=8.000000,Max=9.000000)
     RangeAtten=0.10000
     DamageType=Class'BallisticProV55.DTAM67Laser'
     DamageTypeHead=Class'BallisticProV55.DTAM67LaserHead'
     DamageTypeArm=Class'BallisticProV55.DTAM67Laser'
     PenetrateForce=10
     bPenetrate=True
     bUseWeaponMag=False
     FlashBone="tip2"
     XInaccuracy=2.000000
     YInaccuracy=2.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-LaserFire')
     bModeExclusive=False
     FireAnim="Idle"
     TweenTime=0.000000
     FireRate=0.050000
     FireChaos=0.000000
     AmmoClass=Class'BallisticProV55.Ammo_50HV'
     AmmoPerFire=0
     BotRefireRate=0.999000
     WarnTargetPct=0.010000
     aimerror=400.000000
}
