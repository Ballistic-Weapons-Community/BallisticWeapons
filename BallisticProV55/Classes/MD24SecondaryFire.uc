//=============================================================================
// MD24SecondaryFire.
//
// A quick stab or scope sight depending on layout.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class MD24SecondaryFire extends BallisticMeleeFire;

simulated function bool HasAmmo()
{
	return true;
}

function PlayPreFire()
{
	super.PlayPreFire();

	MD24Pistol(Weapon).bStriking = true;
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
	SwipePoints(0)=(offset=(Pitch=2048,Yaw=2048))
	SwipePoints(1)=(Weight=1,offset=(Pitch=1000,Yaw=1000))
	SwipePoints(2)=(Weight=2)
	SwipePoints(3)=(Weight=1,offset=(Pitch=-1000,Yaw=-1000))
	SwipePoints(4)=(Weight=3,offset=(Pitch=-2048,Yaw=-2048))
	TraceRange=(Min=140.000000,Max=140.000000)
	Damage=70.000000


	DamageType=Class'BallisticProV55.DTMD24Melee'
	DamageTypeHead=Class'BallisticProV55.DTMD24Melee'
	DamageTypeArm=Class'BallisticProV55.DTMD24Melee'
	KickForce=100
	HookStopFactor=1.700000
	HookPullForce=100.000000
	bUseWeaponMag=False
	bReleaseFireOnDie=False
	bIgnoreReload=True
	ScopeDownOn=SDO_PreFire
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Melee',Volume=0.5,Radius=12.000000,bAtten=True)
	bAISilent=True
	bFireOnRelease=False
	bModeExclusive=True
	PreFireAnim=""
	FireAnim="Stab"
	FireRate=0.250000
	AmmoClass=Class'BallisticProV55.Ammo_MD24Clip'
	AmmoPerFire=0
	ShakeRotMag=(X=64.000000,Y=128.000000)
	ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
	ShakeRotTime=2.500000
	BotRefireRate=0.800000
	WarnTargetPct=0.050000
}
