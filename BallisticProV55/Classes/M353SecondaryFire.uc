class M353SecondaryFire extends BallisticFire;

function PlayFiring()
{
	if (BallisticTurret(Instigator) != None)
	{
		if(!BW.HasAnim('Undeploy'))
		{
			BW.Notify_Undeploy();
			return;
		}
		super.PlayFiring();
	}
	else if (BW != None)
	{
		BW.SafePlayAnim('Deploy', 1.0, 0.0, ,"FIRE");
	}
}

function ServerPlayFiring()
{
	if (BallisticTurret(Instigator) != None)
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	else if (BW != None)
		BW.SafePlayAnim('Deploy', 1.0, 0.0, ,"FIRE");
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
        if (Instigator == None || Instigator.Controller == None)
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
    }
	
	if (BW != None)
		BW.LastFireTime = Level.TimeSeconds;


    // client
    if (Instigator != None && Instigator.IsLocallyControlled())
    {
        ShakeView();
        PlayFiring();
        if (Weapon == None)
            return;
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

    if (Instigator != None && Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
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
	{
		if (!Weapon.HasAnim('Deploy'))
			BW.Notify_Deploy();
	}
}

simulated function bool AllowFire()
{
	local name Anim;
	local float Frame, Rate;

	Weapon.GetAnimParams(0, Anim, Frame, Rate);
	if (Anim == 'Deploy' || Anim == 'Undeploy')
		return false;

	if (BallisticTurret(Instigator) != None)
		return Level.TimeSeconds - BallisticTurret(Instigator).DriverEnterTime >= 0.3;
	if (Instigator.HeadVolume.bWaterVolume)
		return false;
	if (BW != None && BW.LastTurretDeployTime > 0 && Level.TimeSeconds - BW.LastTurretDeployTime < 0.3)
		return false;
	return super.AllowFire();
}

defaultproperties
{
	bUseWeaponMag=False
	bWaitForRelease=True
	bModeExclusive=False
	FireAnim="Undeploy"
	FireRate=0.700000
	AmmoClass=Class'BallisticProV55.Ammo_556mmBelt'
	AmmoPerFire=0
	BotRefireRate=0.300000
}
