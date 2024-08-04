//=============================================================================
// Rs04SecondaryFire.
//
// Activates flashlight, or stabs, or launches a tracker dart
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RS04SecondaryFire extends BallisticMeleeFire;

//sensor
var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor
var   bool		bLoaded;

//flash
var() Sound				ChargeSound;
var()	byte			ChargeSoundPitch;
var() float				DecayCharge;

simulated function bool HasAmmo()
{
	return true;
}

function PlayPreFire()
{
	super.PlayPreFire();

	RS04Pistol(Weapon).bStriking = true;
}

function PlayFiring()
{
	if (BW.MagAmmo == 0)
	{
		FireAnim = 'StabOpen';
	}
	else
	{
		FireAnim = 'Stab';
	}
	super.PlayFiring();
}


simulated state Light
{
	simulated function ApplyFireEffectParams(FireEffectParams effect_params)
	{
		super(BallisticFire).ApplyFireEffectParams(effect_params);
		
		 bWaitForRelease=True;
		 bModeExclusive=False;
	 
		if (bFireOnRelease)
			bWaitForRelease = true;

		if (bWaitForRelease)
			bNowWaiting = true;
	}

	event ModeDoFire()
	{
		if (!Instigator.IsLocallyControlled())
			return;
		if (AllowFire())
			RS04Pistol(Weapon).WeaponSpecial();
	}
}

simulated state FlashbangLight
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
			super.ModeDoFire();
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
		if (BW.MagAmmo == 0)
		{
			FireAnim = 'FlashLightToggleOpen';
		}
		else
		{
			FireAnim = 'FlashLightToggle';
		}
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
		Super.DoFireEffect();
	}
}

simulated state Projectile
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

	// Match ammo to other mode
	//simulated function PostBeginPlay()
	//{
	//	AmmoClass = class'Ammo_G51Grenades';
	//	super.PostBeginPlay();
	//}

	simulated function bool CheckSensor()
	{
		local int channel;
		local name seq;
		local float frame, rate;

		if (!bLoaded)
		{
			weapon.GetAnimParams(channel, seq, frame, rate);
			if (seq == RS04Pistol(Weapon).SensorLoadAnim)
				return false;
			RS04Pistol(Weapon).LoadSensor();
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

		if(!Super.AllowFire() || !bLoaded)
		{
			if (DryFireSound.Sound != None)
				Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			BW.EmptyFire(1);
			return false;	// Does not use ammo from weapon mag. Is there ammo in inventory
		}

		return true;
	}

	simulated event ModeDoFire()
	{
		if (!AllowFire())
			return;

		if (!CheckSensor())
			return;
			
		Super.ModeDoFire();
		
		bLoaded = false;
		RS04Pistol(Weapon).AltCharge = 0;
		PreFireTime = 0;
	}
	
	function PlayFiring()
	{
		if (BW.MagAmmo == 0)
		{
			FireAnim = 'FlashLightToggleOpen';
		}
		else
		{
			FireAnim = 'FlashLightToggle';
		}
		super.PlayFiring();
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
		Proj.Instigator = Instigator;
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
	//proj
    SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
	//flash
	ChargeSound=Sound'BW_Core_WeaponSound.A73.A73ProjFly'
	ChargeSoundPitch=32
	//melee
	SwipePoints(0)=(offset=(Pitch=2048,Yaw=2048))
	SwipePoints(1)=(Weight=1,offset=(Pitch=1000,Yaw=1000))
	SwipePoints(2)=(Weight=2)
	SwipePoints(3)=(Weight=1,offset=(Pitch=-1000,Yaw=-1000))
	SwipePoints(4)=(Weight=3,offset=(Pitch=-2048,Yaw=-2048))
	TraceRange=(Min=140.000000,Max=140.000000)
	Damage=70.000000

	DamageType=Class'BWBP_SKC_Pro.DTRS04Stab'
	DamageTypeHead=Class'BWBP_SKC_Pro.DTRS04Stab'
	DamageTypeArm=Class'BWBP_SKC_Pro.DTRS04Stab'
	KickForce=100
	HookStopFactor=1.700000
	HookPullForce=100.000000
	bUseWeaponMag=False
	bReleaseFireOnDie=False
	bIgnoreReload=True
	ScopeDownOn=SDO_PreFire
	BallisticFireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Knife.KnifeSlash',Radius=378.000000,bAtten=True)
	bAISilent=True
	bFireOnRelease=False
	bModeExclusive=True
	PreFireAnim=""
	FireAnim="FlashLightToggle"
	FireRate=0.250000
	AmmoPerFire=0
	ShakeRotMag=(X=64.000000,Y=128.000000)
	ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
	ShakeRotTime=2.500000
	BotRefireRate=0.300000
	WarnTargetPct=0.050000


	bWaitForRelease=false
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_G51Grenades'
}
