class XMV500MinigunSecondaryFire extends BallisticFire;

//for some reason XMV doesn't deploy using the original commented out code below - the notify isn't called properly, even though set correctly in the files.
//the HAMR uses very similar code but works just fine. wtf?
//temporary fix: xmv will deploy immediately, like m353/m925/etc (hamr will do the same for consistency)

/*function PlayFiring()
{
	if (BallisticTurret(Instigator) != None)
		FireAnim='Undeploy';
	else
		FireAnim='Drop';
	super.PlayFiring();
}

function ServerPlayFiring()
{
	if (BallisticTurret(Instigator) != None)
		FireAnim='Undeploy';
	else
		FireAnim='Drop';
	super.ServerPlayFiring();
}

function DoFireEffect();

simulated function bool AllowFire()
{
	if (BallisticTurret(Instigator) == None && Instigator.HeadVolume.bWaterVolume)
		return false;
	return super.AllowFire();
}*/

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//new code

function PlayFiring()
{
	if (BallisticTurret(Instigator) != None)
	{
		super.PlayFiring();
	}
}

function ServerPlayFiring()
{
	if (BallisticTurret(Instigator) != None)
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
}


// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
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
        if ( (BallisticTurret(Instigator) == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
    }
	
	BW.LastFireTime = Level.TimeSeconds;


    // client
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

//    Weapon.IncrementFlashCount(ThisModeNum);

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
        NextFireTime += FireRate;
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


function DoFireEffect()
{
	if (BallisticTurret(Instigator) == None)
		XMV500Minigun(Weapon).Notify_Deploy();
}

simulated function bool AllowFire()
{
	if (BallisticTurret(Instigator) == None && Instigator.HeadVolume.bWaterVolume)
		return false;
	return super.AllowFire();
}

defaultproperties
{
     bUseWeaponMag=False
     //EffectString="Deploy weapon"
     bModeExclusive=False
	 //FireAnim="Drop"
     FireAnim="Undeploy"
     FireRate=0.700000
     AmmoClass=Class'BWBP_APC_Pro.Ammo_MinigunInc'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
