//=============================================================================
// MRLPrimaryFire.
//
// JL21-MRL average speed fire. Fires rockets at a normal, steady fire rate.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MRLPrimaryFire extends BallisticProjectileFire;

var MRocketLauncher MRL;
var int ConsumedLoadTwo;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	MRL = MRocketLauncher(Weapon);
}

// Check if there is ammo in mag if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	/*if (Instigator.Physics != PHYS_Walking)
		return false;*/
		
	if (MRL.LoadedFrontBarrels < AmmoPerFire && MRL.LoadedBackBarrels < AmmoPerFire)
	{
		if (MRL.MagAmmo+MRL.BigMagAmmo < AmmoPerFire)
		{
			if (Weapon.ClientState == WS_ReadyToFire && BW.FireCount < 1 && Instigator.IsLocallyControlled())
				BW.ServerStartReload();
		}
		return false;
	}
	
	if (!CheckReloading())
		return false;// Is weapon busy reloading
		
	if (!CheckWeaponMode())
		return false;// Will weapon mode allow further firing
		
	if (!bUseWeaponMag || BW.bNoMag)
	{
		if(!Super.AllowFire())
		{
			if (DryFireSound.Sound != None)
				Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			return false;	// Does not use ammo from weapon mag. Is there ammo in inventory
		}
	}
	
	else if (MRL.MagAmmo+MRL.BigMagAmmo < AmmoPerFire)
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
		return false;	// Is gun cocked
		
    return true;
}

function DoFireEffect()
{
	Super.DoFireEffect();
	
    if(InStr(Level.Game.GameName, "Freon") != -1 && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
		class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(load, 1);

	if (MRL.LoadedBackBarrels > 0 && (MRL.LoadedFrontBarrels < 1 || MRL.BigMagAmmo < 1 || float(MRL.BarrelIndex) / 3.0 == MRL.BarrelIndex / 3))
	{
		MRL.LoadedBackBarrels--;
		if (MRL.LoadedFrontBarrels < 1)
			MRL.BarrelIndex = (MRL.BarrelIndex/3 + 1) * 3.0;
		else
			MRL.BarrelIndex++;
	}
	else
	{
		MRL.LoadedFrontBarrels--;
		ConsumedLoad-=Load;
		ConsumedLoadTwo+=Load;
		MRL.BarrelIndex++;
	}
	if (MRL.BarrelIndex >= 18)
		MRL.BarrelIndex=0;
}

function PlayFiring()
{
	if (weapon.Role < Role_Authority)
	{
	if (MRL.LoadedBackBarrels > 0 && (MRL.LoadedFrontBarrels < 1 || MRL.BigMagAmmo < 1 || float(MRL.BarrelIndex) / 3.0 == MRL.BarrelIndex / 3))
	{
		MRL.LoadedBackBarrels--;
		if (MRL.LoadedFrontBarrels < 1)
			MRL.BarrelIndex = (MRL.BarrelIndex/3 + 1) * 3.0;
		else
			MRL.BarrelIndex++;
	}
	else
	{
		MRL.LoadedFrontBarrels--;
		MRL.BarrelIndex++;
	}
	if (MRL.BarrelIndex >= 18)
		MRL.BarrelIndex=0;
	}
	
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

/// server propagation of firing ////
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
}

simulated event Timer()
{
	if (Weapon.Role == ROLE_Authority)
		MRL.ConsumeMRLAmmo(ThisModeNum, ConsumedLoad, ConsumedLoadTwo);
	ConsumedLoad=0;
	ConsumedLoadTwo=0;
}

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
    {
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    	MRLFlashEmitter(MuzzleFlash).InitMRLFlash(MuzzleFlash.DrawScale);
	}
}

function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (MuzzleFlash != None)
    {
    	MRLFlashEmitter(MuzzleFlash).SetBarrelIndex(MRL.BarrelIndex);
        MuzzleFlash.Trigger(Weapon, Instigator);
    }
}

defaultproperties
{
     SpawnOffset=(X=28.000000,Y=10.000000,Z=-8.000000)
     MuzzleFlashClass=Class'BallisticProV55.MRLFlashEmitter'
     FireRecoil=0.000000
     FireChaos=0.170000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-Fire',Volume=1.200000,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.110000
	 XInaccuracy=128
	 YInaccuracy=128
     AmmoClass=Class'BallisticProV55.Ammo_MRL'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BallisticProV55.MRLRocket'
     WarnTargetPct=0.200000
}
