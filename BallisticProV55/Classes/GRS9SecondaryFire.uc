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
class GRS9SecondaryFire extends BallisticProInstantFire;

var() sound		FireSoundLoop;
var   float		StopFireTime;
var   bool		bLaserFiring;

var() Sound			ChargeSound;
var()	byte		ChargeSoundPitch;
var() float			DecayCharge;



simulated function bool CheckWeaponMode()
{
	if (Instigator != None && AIController(Instigator.Controller) != None)
		return true;
	if (GRS9Pistol(Weapon).bHasKnife)
		return true;
	return BW.CheckWeaponMode(ThisModeNum);
}

simulated state CombatLaser
{
	simulated function bool AllowFire()
	{
		if (level.TimeSeconds - StopFireTime < 0.8 || GRS9Pistol(Weapon).LaserAmmo <= 0 || !super.AllowFire())
		{
			if (bLaserFiring)
				StopFiring();
			return false;
		}
		return true;
	}

	simulated function bool HasAmmo()
	{
		return GRS9Pistol(Weapon).LaserAmmo > 0;
	}

	simulated function bool CheckWeaponMode()
	{
		if (Weapon.IsInState('DualAction') || Weapon.IsInState('PendingDualAction'))
			return false;
		return true;
	}

	function DoFireEffect()
	{
		if (class'BallisticReplicationInfo'.static.IsClassicOrRealism())
			GRS9Pistol(Weapon).LaserAmmo -= 0.08;
		else
			GRS9Pistol(Weapon).LaserAmmo -= 0.15;
		GRS9Pistol(Weapon).ServerSwitchLaser(true);
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
		GRS9Pistol(Weapon).ServerSwitchLaser(false);
		StopFireTime = level.TimeSeconds;
	}

	simulated event ModeDoFire()
	{
		if (GRS9Pistol(Weapon).bBigLaser)
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
}
simulated state LaserSight
{
	simulated function ApplyFireEffectParams(FireEffectParams effect_params)
	{
		//super(BallisticFire).ApplyFireEffectParams(effect_params);
		bUseWeaponMag=False;
		bFireOnRelease=true;
		bWaitForRelease=true;
		bModeExclusive=False;
		FireRate=0.200000;
		
		if (bFireOnRelease)
			bWaitForRelease = true;

		if (bWaitForRelease)
			bNowWaiting = true;
	}
	
	event ModeDoFire()
	{
		if (Weapon.Role == ROLE_Authority)
			GRS9Pistol(Weapon).ServerSwitchlaser(!GRS9Pistol(Weapon).bLaserOn);
	}
}

simulated state Flash
{
	simulated function ApplyFireEffectParams(FireEffectParams effect_params)
	{
		super(BallisticFire).ApplyFireEffectParams(effect_params);
		
		bFireOnRelease=True;
		bModeExclusive=False;
		bWaitForRelease=True;
	 
		if (bFireOnRelease)
			bWaitForRelease = true;

		if (bWaitForRelease)
			bNowWaiting = true;
	}
	

	function float MaxRange()
	{
		return 1200;
	}

	function PlayStartHold()
	{
		HoldTime = FMax(DecayCharge,0.1);
		
		Weapon.AmbientSound = ChargeSound;
		Weapon.ThirdPersonActor.AmbientSound = ChargeSound;
		
		Weapon.SoundVolume = 48 + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * 128;
		Weapon.SoundPitch = ChargeSoundPitch + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * ChargeSoundPitch;
		
		Weapon.ThirdPersonActor.SoundVolume = 48 + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * 128;
		Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * ChargeSoundPitch;
		
		BW.bPreventReload=True;
	}

	function ModeTick(float DeltaTime)
	{
		Super.ModeTick(DeltaTime);
		
		if (bIsFiring)
		{
			Weapon.ThirdPersonActor.SoundVolume = 48 + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * 128;
			Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * ChargeSoundPitch;
			
			Weapon.SoundVolume = 48 + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * 128;
			Weapon.SoundPitch = ChargeSoundPitch + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * ChargeSoundPitch;
		}
		else if (DecayCharge > 0)
		{
			Weapon.ThirdPersonActor.SoundVolume = 48 + FMin(MaxHoldTime, DecayCharge)/MaxHoldTime * 128;
			Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch + FMin(MaxHoldTime, DecayCharge)/MaxHoldTime * ChargeSoundPitch;
			
			Weapon.SoundVolume = 48 + FMin(MaxHoldTime, DecayCharge)/MaxHoldTime * 128;
			Weapon.SoundPitch = ChargeSoundPitch + FMin(MaxHoldTime, DecayCharge)/MaxHoldTime * ChargeSoundPitch;
			DecayCharge -= DeltaTime * 2.5;
			
			if (DecayCharge < 0)
			{
				DecayCharge = 0;
				Weapon.ThirdPersonActor.AmbientSound = None;
				Weapon.AmbientSound = None;
			}
		}
	}	

	simulated event ModeDoFire()
	{
		if (HoldTime >= MaxHoldTime || (Level.NetMode == NM_DedicatedServer && HoldTime >= MaxHoldTime - 0.1))
		{
			super(BallisticFire).ModeDoFire();
			Weapon.ThirdPersonActor.AmbientSound = None;
			Weapon.AmbientSound = None;
			DecayCharge = 0;
		}
		else
		{
			DecayCharge = HoldTime;
			NextFireTime = Level.TimeSeconds + (DecayCharge * 0.35);
		}

		HoldTime = 0;
	}

	//// server propagation of firing ////
	function ServerPlayFiring()
	{
		if (BallisticFireSound.Sound != None)
			Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

		CheckClipFinished();
	}

	//Do the spread on the client side
	function PlayFiring()
	{
		ClientPlayForceFeedback(FireForce);  // jdf
		FireCount++;

		if (BallisticFireSound.Sound != None)
			Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

		CheckClipFinished();
	}

	function DoFireEffect()
	{
		local Controller C;
		local Vector StartTrace, Dir, EnemyEye;
		local float DF, Dist, EnemyDF;
		local int i;
		local GRS9ViewMesser VM;

		Dir = GetFireSpread() >> GetFireAim(StartTrace);

		for (C=Level.ControllerList;C!=None;C=C.NextController)
		{
			if (C.Pawn == None || C.Pawn.Health <= 0)
				continue;
			EnemyEye = C.Pawn.EyePosition() + C.Pawn.Location;
			Dist = VSize(EnemyEye - StartTrace);
			DF = Dir Dot Normal(EnemyEye - StartTrace);
			if (DF > 0.8 && Dist < 1200 && Weapon.FastTrace(EnemyEye, StartTrace))
			{
				EnemyDF = Normal(StartTrace - EnemyEye) Dot vector(C.Pawn.GetViewRotation());
				EnemyDF = (EnemyDF+1)/2;
				if (EnemyDF < -0.7)
					EnemyDF = 0.1;
				DF = (DF-0.8)*5;
				if (Dist > 500)
					DF /= 1+(Dist-500)/700;
				DF *= EnemyDF;
				if (PlayerController(C) != None)
				{
					for (i=0;i<C.Attached.length;i++)
						if (GRS9ViewMesser(C.Attached[i]) != None)
						{
							VM = GRS9ViewMesser(C.Attached[i]);
							break;
						}
					if (VM == None)
					{
						VM = Spawn(class'GRS9ViewMesser', C);
						VM.SetBase(C);
					}
					VM.AddImpulse(DF);
				}
				else if (AIController(C) != None && DF > 0.1)
				{
					class'BC_BotStoopidizer'.static.DoBotStun(AIController(C), 2*DF, 12*DF);
				}
			}
		}

		SendFireEffect(None, StartTrace + Dir * 1000, -Dir, 0);
		Super(BallisticFire).DoFireEffect();
	}
}

simulated state Scope
{
	simulated function ApplyFireEffectParams(FireEffectParams effect_params)
	{
		super(BallisticFire).ApplyFireEffectParams(effect_params);
		bUseWeaponMag=False;
		bFireOnRelease=True;
		bModeExclusive=False;
		if (bFireOnRelease)
			bWaitForRelease = true;

		if (bWaitForRelease)
			bNowWaiting = true;
	}
	
	// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
	simulated function bool AllowFire()
	{
		if (!CheckReloading())
			return false;		// Is weapon busy reloading
		if (!CheckWeaponMode())
			return false;		// Will weapon mode allow further firing

		if (!bUseWeaponMag || BW.bNoMag)
		{
			if(!Super(WeaponFire).AllowFire())
			{
				if (DryFireSound.Sound != None)
					Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
				return false;	// Does not use ammo from weapon mag. Is there ammo in inventory
			}
		}
		else if (BW.MagAmmo < AmmoPerFire)
		{
			if (!bPlayedDryFire && DryFireSound.Sound != None)
			{
				Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
				bPlayedDryFire=true;
			}
			if (bDryUncock)
				BW.bNeedCock=true;
			BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

			BW.EmptyFire(ThisModeNum);
			return false;		// Is there ammo in weapon's mag
		}
		else if (BW.bNeedReload)
			return false;
		else if (BW.bNeedCock)
			return false;		// Is gun cocked
		return true;
	}

	// Match ammo to other mode
	simulated function PostBeginPlay()
	{
		if (ThisModeNum == 0 && Weapon.AmmoClass[1] != None)
			AmmoClass = Weapon.AmmoClass[1];
		else if (Weapon.AmmoClass[0] != None)
			AmmoClass = Weapon.AmmoClass[0];
		super.PostBeginPlay();
	}

	// Allow scope down when cocking
	simulated function bool CheckReloading()
	{
		if (BW.bScopeView && BW.ReloadState == RS_Cocking)
			return true;
		return super.CheckReloading();
	}

	// Send sight key release event to weapon
	simulated event ModeDoFire()
	{
		if (Instigator.IsLocallyControlled() && BW != None)
			BW.ScopeViewRelease();
	}

	// Send sight key press event to weapon
	simulated function PlayPreFire()
	{
		if (Instigator.IsLocallyControlled() && BW != None)
		{
			BW.ScopeView();

			if(!BW.bNoTweenToScope)
				BW.TweenAnim(BW.IdleAnim, BW.SightingTime);
		}
	}
}

defaultproperties
{
	ChargeSound=Sound'BW_Core_WeaponSound.A73.A73ProjFly'
	ChargeSoundPitch=32
	 
	FireSoundLoop=Sound'BW_Core_WeaponSound.Glock.Glk-LaserBurn'
	DamageType=Class'BallisticProV55.DTGRS9Laser'
	DamageTypeHead=Class'BallisticProV55.DTGRS9LaserHead'
	DamageTypeArm=Class'BallisticProV55.DTGRS9Laser'
	PenetrateForce=200
	bPenetrate=True
	bUseWeaponMag=False
	FlashBone="tip2"
	FireChaos=0.000000
	XInaccuracy=2.000000
	YInaccuracy=2.000000
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-LaserFire')
	FireAnim="Idle"
	FireRate=0.080000
	AmmoClass=Class'BallisticProV55.Ammo_GRSNine'
	AmmoPerFire=0
	BotRefireRate=0.999000
	WarnTargetPct=0.010000
	aimerror=900.000000
}
