//=============================================================================
// MGLSecondaryFire.
//
// Fires a sticky grenade that will adhere to a wall.
// The grenade can be detonated with another click.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MGLSecondaryFire extends BallisticProProjectileFire;

var MGLGrenadeRemote	LastGrenade; //remote det grenade
var float						DetonationInterval;

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	if (!bUseWeaponMag || BW.bNoMag)
	{
		if(!Super.AllowFire())
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
		
		if (MGLauncher(BW).bRemoteGrenadeOut)
			return true;

		else BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (BW.bNeedReload)
		return false;
	else if (BW.bNeedCock)
		return false;		// Is gun cocked
    return true;
}

// Detonates mines if one is out
simulated event ModeDoFire()
{
	if (MGLauncher(BW).bRemoteGrenadeOut)
	{
		if (Weapon.Role == ROLE_Authority)
		{
			if(LastGrenade != None)
				LastGrenade.RemoteDetonate();
			if(LastGrenade == None || LastGrenade.IsInState('NetTrapped'))
				MGLauncher(BW).UpdateGrenadeStatus(false); //Alert gun we've detonated grenade
		}
			
		BW.LastFireTime = Level.TimeSeconds;
		NextFireTime += FMax(0.1, FireRate - (Level.TimeSeconds - BW.LastFireTime));
		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);

		return;
	}
	
    if (!AllowFire())
        return;
    if (bIsJammed)
    {
    	if (BW.FireCount == 0)
    	{
    		bIsJammed=false;
			if (bJamWastesAmmo && Weapon.Role == ROLE_Authority)
			{
				ConsumedLoad += Load;
				Timer();
			}
	   		if (UnjamMethod == UJM_FireNextRound)
	   		{
		        NextFireTime += FireRate;
   			    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
				BW.FireCount++;
    			return;
    		}
    		if (!AllowFire())
    			return;
    	}
    	else
    	{
	        NextFireTime += FireRate;
   		    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		return;
   		}
    }
	
	else
	{
		if (BW != None)
		{
			BW.bPreventReload=true;
			BW.FireCount++;

			if (BW.ReloadState != RS_None)
			{
				if (weapon.Role == ROLE_Authority)
					BW.bServerReloading=false;
				BW.ReloadState = RS_None;
			}
		}

		if (MaxHoldTime > 0.0)
			HoldTime = FMin(HoldTime, MaxHoldTime);

		ConsumedLoad += Load;
		SetTimer(FMin(0.1, FireRate/2), false);
		
		// server
		if (Weapon.Role == ROLE_Authority)
		{
			DoFireEffect();
			if ( (Instigator == None) || (Instigator.Controller == None) )
				return;
			if ( AIController(Instigator.Controller) != None )
				AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
			Instigator.DeactivateSpawnProtection();
		}
		else if (!BW.bUseNetAim && !BW.bScopeView)
			ApplyRecoil();
		
		BW.LastFireTime = Level.TimeSeconds;

		if (Instigator.IsLocallyControlled())
		{
			ShakeView();
			PlayFiring();
			FlashMuzzleFlash();
			StartMuzzleSmoke();
		}
		else // server
		{
			ServerPlayFiring();
		}

		// set the next firing time. must be careful here so client and server do not get out of sync
		if (bFireOnRelease)
		{
			if (bIsFiring)
				NextFireTime += MaxHoldTime + FireRate;
			else
				NextFireTime = Level.TimeSeconds + FireRate;
		}
		else
		{
			NextFireTime += DetonationInterval;
			NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
		}
		
		Load = AmmoPerFire;
		HoldTime = 0;

		if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
		{
			bIsFiring = false;
			Weapon.PutDown();
		}

		if (BW != None)
		{
			BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
			if (bCockAfterFire || (bCockAfterEmpty && BW.MagAmmo - ConsumedLoad < 1))
				BW.bNeedCock=true;
		}
	}
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	Proj.Instigator = Instigator;
	LastGrenade=MGLGrenadeRemote(Proj);
	MGLauncher(BW).UpdateGrenadeStatus(true); //Alert gun we've fired grenade
}

defaultproperties
{
     DetonationInterval=0.100000
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     AimedFireAnim="SightFire"
     FireRecoil=768.000000
     FireChaos=0.650000
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.MGL.MGL-Fire',Volume=9.200000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bWaitForRelease=True
     FireForce="AssaultRifleAltFire"
     AmmoClass=Class'BWBPRecolorsPro.Ammo_MGL'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPRecolorsPro.MGLGrenadeRemote'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
