//=============================================================================
// FC01PrimaryFire.
//
// Smart seeker projectile fire. Has various lock on methods.
// Extends instant fire to have a non-smart instant hit variant.
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FC01PrimaryFire extends BallisticProInstantFire;

var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor

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

simulated state SeekerFlechette
{
	simulated function ApplyFireEffectParams(FireEffectParams params)
	{
		local ProjectileEffectParams effect_params;

		super(BallisticFire).ApplyFireEffectParams(params);

		effect_params = ProjectileEffectParams(params);

		ProjectileClass =  effect_params.ProjectileClass;
		SpawnOffset = effect_params.SpawnOffset;    
		default.ProjectileClass =  effect_params.ProjectileClass;
		default.SpawnOffset = effect_params.SpawnOffset;
	}

	// Became complicated when acceleration came into the picture
	// Override for even weirder situations
	function float MaxRange()
	{
		if (ProjectileClass.default.MaxSpeed > ProjectileClass.default.Speed)
		{
			// We know BW projectiles have AccelSpeed
			if (class<BallisticProjectile>(ProjectileClass) != None && class<BallisticProjectile>(ProjectileClass).default.AccelSpeed > 0)
			{
				if (ProjectileClass.default.LifeSpan <= 0)
					return FMin(ProjectileClass.default.MaxSpeed, (ProjectileClass.default.Speed + class<BallisticProjectile>(ProjectileClass).default.AccelSpeed * 2) * 2);
				else
					return FMin(ProjectileClass.default.MaxSpeed, (ProjectileClass.default.Speed + class<BallisticProjectile>(ProjectileClass).default.AccelSpeed * ProjectileClass.default.LifeSpan) * ProjectileClass.default.LifeSpan);
			}
			// For the rest, just use the max speed
			else
			{
				if (ProjectileClass.default.LifeSpan <= 0)
					return ProjectileClass.default.MaxSpeed * 2;
				else
					return ProjectileClass.default.MaxSpeed * ProjectileClass.default.LifeSpan*0.75;
			}
		}
		else // Hopefully this proj doesn't change speed.
		{
			if (ProjectileClass.default.LifeSpan <= 0)
				return ProjectileClass.default.Speed * 2;
			else
				return ProjectileClass.default.Speed * ProjectileClass.default.LifeSpan;
		}
	}

	// Get aim then spawn projectile
	function DoFireEffect()
	{
		local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
		local Rotator Aim;
		local actor Other;

	    Weapon.GetViewAxes(X,Y,Z);
    	// the to-hit trace always starts right in front of the eye
	    Start = Instigator.Location + Instigator.EyePosition();

	    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    	if ( !Weapon.WeaponCentered() )
		    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

		Aim = GetFireAim(StartTrace);
		Aim = Rotator(GetFireSpread() >> Aim);

		End = Start + (Vector(Aim)*MaxRange());
		Other = Trace (HitLocation, HitNormal, End, Start, true);

		if (Other != None)
			Aim = Rotator(HitLocation-StartTrace);
	    SpawnProjectile(StartTrace, Aim);

		SendFireEffect(none, vect(0,0,0), StartTrace, 0);
		// Skip the instant fire version which would cause instant trace damage.
		Super(BallisticFire).DoFireEffect();
	}

	function SpawnProjectile (Vector Start, Rotator Dir)
	{
		Proj = Spawn (ProjectileClass,,, Start, Dir);
		if (Proj == None)
			return;
		Proj.Instigator = Instigator;
		if (FC01SmartProj(Proj) != None)
		{
			if (FC01SmartGun(Weapon).Target != None && FC01SmartGun(Weapon).TargetTime >= FC01SmartGun(Weapon).LockOnTime)
				FC01SmartProj(Proj).SetSmartProjTarget(FC01SmartGun(Weapon).Target);
			else
				FC01SmartProj(Proj).SetSmartProjTarget(None);
		}
		//FC01SmartProj(Proj).Master = FC01SmartGun(BW);
	}
}
/*

simulated function bool CheckCharge()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (PhotonCharge <= 0 && BW.CurrentWeaponMode == 1)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if (seq == FC01SmartGun(Weapon).PhotonLoadAnim || seq == FC01SmartGun(Weapon).PhotonLoadEmptyAnim)
			return false;
		FC01SmartGun(Weapon).LoadPhoton();
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
		
    if (!FC01SmartGun(Weapon).bSilenced && MuzzleFlash != None && BW.CurrentWeaponMode == 0)
        MuzzleFlash.Trigger(Weapon, Instigator);
		
	if (FC01SmartGun(Weapon).bSilenced && SMuzzleFlash != None && BW.CurrentWeaponMode == 0)
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
		FC01Attachment(Weapon.ThirdPersonActor).PhotonUpdateHit(Other, HitLocation, HitNormal, Surf, , WaterHitLoc);
	else
		BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, FC01SmartGun(Weapon).bSilenced, WaterHitLoc);
}

function ServerPlayFiring()
{
	if (FC01SmartGun(Weapon) != None && FC01SmartGun(Weapon).bSilenced && SilencedFireSound.Sound != None && BW.CurrentWeaponMode == 0)
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
	if (FC01SmartGun(Weapon).bSilenced)
		Weapon.SetBoneScale (0, 1.0, FC01SmartGun(Weapon).SilencerBone);
	else
		Weapon.SetBoneScale (0, 0.0, FC01SmartGun(Weapon).SilencerBone);
		
	// Slightly modified Code from original PlayFiring()
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else if(!BW.bScopeView || !Weapon.HasAnim(AimedFireAnim))
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	else BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "FIRE");
	// End code from normal PlayFiring()

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (FC01SmartGun(Weapon) != None && FC01SmartGun(Instigator.Weapon).bSilenced && SilencedFireSound.Sound != None && BW.CurrentWeaponMode == 0)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}*/

defaultproperties
{
	ProjectileClass="BWBP_OP_Pro.FC01SmartProj"
	SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
	
	PhotonCharge=20
	MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
	SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
	PhotonMuzzleFlashClass=Class'BWBP_OP_Pro.FC01PhotonFlashEmitter'
	SFlashBone="tip2"
	PhotonFlashBone="tipalt"
	FlashBone="tip"
	FlashScaleFactor=0.500000
	SFlashScaleFactor=1.000000
	PhotonFlashScaleFactor=0.400000
	SilencedFireSound=(Sound=SoundGroup'BWBP_OP_Sounds.FC01.FC01-SmartShot',Pitch=1.4,Volume=2.000000,Radius=192.000000,bAtten=True)
	DecayRange=(Min=1536,Max=3072)
	TraceRange=(Min=8000.000000,Max=12000.000000)
	WallPenetrationForce=24.000000

	Damage=28.000000

	RangeAtten=0.350000
	WaterRangeAtten=0.800000
	DamageType=Class'BWBP_OP_Pro.DT_FC01Body'
	DamageTypeHead=Class'BWBP_OP_Pro.DT_FC01Head'
	DamageTypeArm=Class'BWBP_OP_Pro.DT_FC01Body'
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
	AmmoClass=Class'BWBP_OP_Pro.Ammo_SmartAmmo'
	AltAmmoClass=Class'BWBP_OP_Pro.Ammo_FC01Alt'
	WarnTargetPct=0.200000
	aimerror=900.000000
	
	ShakeRotMag=(X=24.000000)
	ShakeRotRate=(X=360.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-5.00)
	ShakeOffsetRate=(X=-100.000000)
	ShakeOffsetTime=2.000000
}
