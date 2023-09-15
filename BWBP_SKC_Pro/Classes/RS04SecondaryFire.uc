//=============================================================================
// Rs04SecondaryFire.
//
// Activates flashlight, or stabs
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RS04SecondaryFire extends BallisticMeleeFire;

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

defaultproperties
{
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
	FireAnim="Stab"
	FireRate=0.250000
	AmmoPerFire=0
	ShakeRotMag=(X=64.000000,Y=128.000000)
	ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
	ShakeRotTime=2.500000
	BotRefireRate=0.300000
	WarnTargetPct=0.050000


	bWaitForRelease=false
	AmmoClass=Class'BallisticProV55.Ammo_45HV'
}
