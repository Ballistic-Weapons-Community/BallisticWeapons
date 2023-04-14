//=============================================================================
// MG36PrimaryFire.
//
// Rapid fire CQC fire. Uses up ammo very quickly. 
// Very controllable, and packs a decent punch.
//
// Has accuracy and damage drop off issues due to CQC Barrel.
// Rounds detonate on target and do not penetrate.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MG36PrimaryFire extends BallisticProInstantFire;

var() sound	FireSoundLoop;
var() sound	FireSoundLoopBegin;
var() sound	FireSoundLoopEnd;

var bool bFiring;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>			SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;


simulated function bool AllowFire()
{
	if (!super.AllowFire())
	{
		if (bFiring)
		{
			StopFiring();
			Instigator.AmbientSound = BW.UsedAmbientSound;
		}
		return false;
	}
	return super.AllowFire();
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!MG36Machinegun(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (MG36Machinegun(Weapon).bSilenced && SMuzzleFlash != None)
        SMuzzleFlash.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (SMuzzleFlash);
}

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((SMuzzleFlashClass != None) && ((SMuzzleFlash == None) || SMuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (SMuzzleFlash, SMuzzleFlashClass, Weapon.DrawScale*SFlashScaleFactor, weapon, SFlashBone);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, MG36Machinegun(Weapon).bSilenced, WaterHitLoc);
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (MG36Machinegun(Weapon) != None && MG36Machinegun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	PlayFireAnimations();
}

//Do the spread on the client side
function PlayFiring()
{
	PlayFireAnimations();
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (MG36Machinegun(Weapon) != None && MG36Machinegun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

simulated function SwitchSilencerMode (bool bNewMode)
{
	if (bNewMode)
	{
		Damage *= 0.7;
		FireRecoil *= 0.9;
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
		DamageType=Class'DT_MG36SilAssault';
     	DamageTypeHead=Class'DT_MG36SilAssaultHead';
     	DamageTypeArm=Class'DT_MG36SilAssault';
	}
	
	else
	{
		Damage =default.Damage;
     	DamageType=Class'DT_MG36Assault';
     	DamageTypeHead=Class'DT_MG36AssaultHead';
     	DamageTypeArm=Class'DT_MG36Assault';
		FireRecoil = default.FireRecoil;
		RangeAtten = default.RangeAtten;
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
	}
}

//FIXME
simulated event ModeDoFire()
{
	if (MG36Machinegun(Weapon).bSilenced)
	{
    		if (!AllowFire())
		{
			StopFiring();
       			return;
		}
	}

	Super.ModeDoFire();
}

function StopFiring()
{
	bFiring=false;
    Instigator.AmbientSound = BW.UsedAmbientSound;
	Super.StopFiring();
}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);

	if (bIsFiring && MG36Machinegun(Weapon).bSilenced && MG36Machinegun(Weapon).CurrentWeaponMode != 0 && MG36Machinegun(Weapon).CurrentWeaponMode != 1)
		Instigator.AmbientSound = FireSoundLoop;
	else
		Instigator.AmbientSound = BW.UsedAmbientSound;
}


function DoFireEffect()
{
	Super.DoFireEffect();
	bFiring=true;
}

defaultproperties
{
     SMuzzleFlashClass=Class'BWBP_SKC_Pro.MG36SilencedFlash'
     SFlashBone="tip2"
     SFlashScaleFactor=0.750000
	 DecayRange=(Min=7680.000000,Max=15872.000000)
     TraceRange=(Min=9000.000000,Max=11000.000000)
     WallPenetrationForce=16.000000
     Damage=28.000000 
     RangeAtten=0.400000
     WaterRangeAtten=0.700000
     DamageType=Class'BWBP_SKC_Pro.DT_MG36Assault'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_MG36AssaultHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_MG36Assault'
     PenetrateForce=150
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=0.100000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassBone="tip"
     BrassOffset=(X=-80.000000,Y=1.000000)
     FireRecoil=128.000000
     FireChaos=0.180000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=4
	 YInaccuracy=4
     SilencedFireSound=(Sound=Sound'BWBP_SKC_Sounds.JSOC.JSOC-SuppressedFire',Volume=1.000000,Radius=192.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.JSOC.JSOC-Fire',Volume=1.000000)
     bPawnRapidFireAnim=True
     FireAnim="Fire"
	 FireEndAnim=
     FireRate=0.100000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_68mm'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
