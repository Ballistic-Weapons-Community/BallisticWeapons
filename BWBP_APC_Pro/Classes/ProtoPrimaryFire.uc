//=============================================================================
// CYLOPrimaryFire.
//
// For some really odd reason my UDE isn't liking the class names, so I have to
// change the names for UDE to recognize them every once in a while...
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ProtoPrimaryFire extends BallisticProInstantFire;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() Actor						PhotonMuzzleFlash;
var() class<Actor>				SMuzzleFlashClass;
var() class<Actor>				PhotonMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;
var() Name						PhotonFlashBone;
var() float						PhotonFlashScaleFactor;

var   int						PhotonCharge;
var   class<Ammunition>			AltAmmoClass;

simulated function bool CheckCharge()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (PhotonCharge <= 0 && BW.CurrentWeaponMode == 1)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if (seq == ProtoSMG(Weapon).PhotonLoadAnim || seq == ProtoSMG(Weapon).PhotonLoadEmptyAnim)
			return false;
		ProtoSMG(Weapon).LoadPhoton();
		bIsFiring=false;
		return false;
	}
	
	return true;
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing

	if((BW.CurrentWeaponMode == 0 && !Super.AllowFire()) || (BW.CurrentWeaponMode == 1 && PhotonCharge <= 0))
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			bPlayedDryFire=true;
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
		}
		BW.EmptyFire(1);
		return false;	// Does not use ammo from weapon mag. Is there ammo in inventory
	}

    return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;

	if (!CheckCharge())
		return;
		
	Super.ModeDoFire();
	
	if (BW.CurrentWeaponMode == 1 && PhotonCharge > 0)
		PhotonCharge--;
}

function StopFiring()
{
	local int channel;
	local name seq;
	local float frame, rate;
	
	weapon.GetAnimParams(channel, seq, frame, rate);
	if (Seq == PreFireAnim)
		Weapon.PlayAnim(Weapon.IdleAnim, 1.0, 0.5);
}

simulated function SwitchWeaponMode(byte NewMode)
{
	if (NewMode == 1)
	{
		AmmoClass = AltAmmoClass;
		bUseWeaponMag = false;
	}
	else
	{
		AmmoClass = default.AmmoClass;
		bUseWeaponMag = true;
	}
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
		
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
		
    if (!ProtoSMG(Weapon).bSilenced && MuzzleFlash != None && BW.CurrentWeaponMode == 0)
        MuzzleFlash.Trigger(Weapon, Instigator);
		
	if (ProtoSMG(Weapon).bSilenced && SMuzzleFlash != None && BW.CurrentWeaponMode == 0)
        SMuzzleFlash.Trigger(Weapon, Instigator);
		
	if (PhotonMuzzleFlash != None && BW.CurrentWeaponMode == 1)
		PhotonMuzzleFlash.Trigger(Weapon,Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

function SetSuppressed(bool bSilenced)
{
	if (bSilenced)
	{
		FireRecoil *= 0.8;
		RangeAtten *= 1.2;
		XInaccuracy *= 0.75;
		YInaccuracy *= 0.75;
	}
	else
	{
		FireRecoil = default.FireRecoil;
		RangeAtten = default.RangeAtten;
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
	}
}

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
	if ((PhotonMuzzleFlashClass != None) && ((PhotonMuzzleFlash == None) || PhotonMuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (PhotonMuzzleFlash, PhotonMuzzleFlashClass, Weapon.DrawScale*PhotonFlashScaleFactor, weapon, PhotonFlashBone);
    if ((SMuzzleFlashClass != None) && ((SMuzzleFlash == None) || SMuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (SMuzzleFlash, SMuzzleFlashClass, Weapon.DrawScale*SFlashScaleFactor, weapon, SFlashBone);
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (SMuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (PhotonMuzzleFlash);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	if (BW.CurrentWeaponMode == 1)
		ProtoAttachment(Weapon.ThirdPersonActor).PhotonUpdateHit(Other, HitLocation, HitNormal, Surf, , WaterHitLoc);
	else
		BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, ProtoSMG(Weapon).bSilenced, WaterHitLoc);
}

function ServerPlayFiring()
{
	if (ProtoSMG(Weapon) != None && ProtoSMG(Weapon).bSilenced && SilencedFireSound.Sound != None && BW.CurrentWeaponMode == 0)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	// Slightly modified Code from original PlayFiring()
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else if(!BW.bScopeView || !Weapon.HasAnim(AimedFireAnim))
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	else BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "FIRE");
	// End code from normal PlayFiring()

	CheckClipFinished();
}

function PlayFiring()
{
	if (ProtoSMG(Weapon).bSilenced)
		Weapon.SetBoneScale (0, 1.0, ProtoSMG(Weapon).SilencerBone);
	else
		Weapon.SetBoneScale (0, 0.0, ProtoSMG(Weapon).SilencerBone);
		
	// Slightly modified Code from original PlayFiring()
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else if(!BW.bScopeView || !Weapon.HasAnim(AimedFireAnim))
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	else BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "FIRE");
	// End code from normal PlayFiring()

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (ProtoSMG(Weapon) != None && ProtoSMG(Instigator.Weapon).bSilenced && SilencedFireSound.Sound != None && BW.CurrentWeaponMode == 0)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}

defaultproperties
{
	 PhotonCharge=20
	 MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
	 PhotonMuzzleFlashClass=Class'BWBP_APC_Pro.ProtoPhotonFlashEmitter'
     SFlashBone="tip2"
     PhotonFlashBone="tipalt"
	 FlashBone="tip"
     FlashScaleFactor=0.500000
	 SFlashScaleFactor=1.000000
     PhotonFlashScaleFactor=0.400000
	 SilencedFireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.P90.P90SilFire',Volume=2.000000,Radius=192.000000,bAtten=True)
	 DecayRange=(Min=1536,Max=3072)
     TraceRange=(Min=8000.000000,Max=12000.000000)
     WallPenetrationForce=24.000000
     
     Damage=28.000000
    
     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBP_SKC_Pro.DTCYLORifle'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLORifleHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLORifle'
     PenetrateForce=180
     bPenetrate=True
     RunningSpeedThresh=1000.000000
     //ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     FireRecoil=220.000000
     FireChaos=0.032000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     PreFireAnim=
     FireEndAnim=
     FireRate=0.1050000
     AmmoClass=Class'BWBP_APC_Pro.Ammo_Proto'
	 AltAmmoClass=Class'BWBP_APC_Pro.Ammo_ProtoAlt'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
