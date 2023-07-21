//=============================================================================
// SARSecondaryFire.
//
// States:
// - Laser Sight - toggles sight on gun
// - Combat Laser - lethal laser weapon with recharge
// - Flash - Chargeable blinding flash bulb
//
// by Nolan "Dark Carnivour" Richert, SK, Aza, Kab
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class SARSecondaryFire extends BallisticInstantFire;

//Laser
var() sound		FireSoundLoop;
var   float		StopFireTime;
var   bool		bLaserFiring;
var() float     LaserAmmoPerFire;

//flash
var() Sound	ChargeSound;
var()	byte		ChargeSoundPitch;
var() float		DecayCharge;

simulated state CombatLaser
{
	simulated function bool AllowFire()
	{
		if ((SARAssaultRifle(Weapon).LaserAmmo < SARAssaultRifle(Weapon).default.LaserAmmo && !bLaserFiring) || level.TimeSeconds - StopFireTime < 0.75 || SARAssaultRifle(Weapon).LaserAmmo <= 0 || !super.AllowFire())
		{
			if (bLaserFiring)
				StopFiring();
			return false;
		}
		return true;
	}

	simulated function bool HasAmmo()
	{
		return SARAssaultRifle(Weapon).LaserAmmo > 0;
	}

	simulated function bool CheckWeaponMode()
	{
		return true;
	}

	function DoFireEffect()
	{
		SARAssaultRifle(Weapon).LaserAmmo -= LaserAmmoPerFire;
		SARAssaultRifle(Weapon).ServerSwitchLaser(true);
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
		SARAssaultRifle(Weapon).ServerSwitchLaser(false);
		StopFireTime = level.TimeSeconds;
	}

	simulated event ModeDoFire()
	{
		if (!bLaserFiring)
			BallisticFireSound.Sound = default.BallisticFireSound.Sound;
		else
			BallisticFireSound.Sound = none;
		//Laser eats up more ammo at first, then slows down.  This prevents cherry-tapping.
		LaserAmmoPerFire = default.LaserAmmoPerFire * (1 + 4*FMax(0, SARAssaultRifle(Weapon).LaserAmmo - 0.5));
		super.ModeDoFire();
	}

	function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
	{
		super.ApplyDamage (Victim, Damage * (1 + 4*FMax(0, SARAssaultRifle(Weapon).LaserAmmo - 0.4)), Instigator, HitLocation, MomentumDir, DamageType);
		
		if (Victim.bProjTarget)
		{
			BW.TargetedHurtRadius(5 * (1 + 4*FMax(0, SARAssaultRifle(Weapon).LaserAmmo - 0.4)), 20, class'DTSARLaser', 0, HitLocation, Pawn(Victim));
		}
	}

	simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
	{
		if (Other == None || Other.bWorldGeometry)
			BW.TargetedHurtRadius(5 * (1 + 4*FMax(0, SARAssaultRifle(Weapon).LaserAmmo - 0.4)), 20, class'DTSARLaser', 50, HitLocation);
		return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
	}
}
simulated state LaserSight
{
	simulated function ApplyFireEffectParams(FireEffectParams effect_params)
	{
		super(BallisticFire).ApplyFireEffectParams(effect_params);
	}
	
	event ModeDoFire()
	{
		if (Weapon.Role == ROLE_Authority)
			SARAssaultRifle(Weapon).ServerSwitchlaser(!SARAssaultRifle(Weapon).bLaserOn);
	}
}
simulated state Flash
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
	function float MaxRange()
	{
		return 1250;
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
		local AM67ViewMesser VM;

		Dir = GetFireSpread() >> GetFireAim(StartTrace);

		for (C=Level.ControllerList;C!=None;C=C.NextController)
		{
			if (C.Pawn == None || C.Pawn.Health <= 0)
				continue;
			EnemyEye = C.Pawn.EyePosition() + C.Pawn.Location;
			Dist = VSize(EnemyEye - StartTrace);
			DF = Dir Dot Normal(EnemyEye - StartTrace);
			if (DF > 0.8 && Dist < 1250 && Weapon.FastTrace(EnemyEye, StartTrace))
			{
				EnemyDF = Normal(StartTrace - EnemyEye) Dot vector(C.Pawn.GetViewRotation());
				EnemyDF = (EnemyDF+1)/2;
				if (EnemyDF < -0.7)
					EnemyDF = 0.1;
				DF = (DF-0.8)*5;
				if (Dist > 800)
					DF /= 1+(Dist-800)/800;
				DF *= EnemyDF;
				if (PlayerController(C) != None)
				{
					for (i=0;i<C.Attached.length;i++)
						if (AM67ViewMesser(C.Attached[i]) != None)
						{
							VM = AM67ViewMesser(C.Attached[i]);
							break;
						}
					if (VM == None)
					{
						VM = Spawn(class'AM67ViewMesser', C);
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

defaultproperties
{
	//Flash
	ChargeSound=Sound'BW_Core_WeaponSound.A73.A73ProjFly'
	ChargeSoundPitch=32
	MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
	MaxHoldTime=0.500000
	//Laser
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
	bModeExclusive=True
	FireAnim="Idle"
	TweenTime=0.000000
	FireRate=0.050000
	FireChaos=0.000000
	AmmoClass=Class'BallisticProV55.Ammo_556mm'
	AmmoPerFire=0
	BotRefireRate=0.999000
	WarnTargetPct=0.010000
	aimerror=400.000000
	//bWaitForRelease=True
	//FireRate=0.700000
	//BotRefireRate=0.300000
}
