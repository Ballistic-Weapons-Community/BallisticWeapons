//===================================
// Hipfire spread modification
//===================================
class BallisticProInstantFire extends BallisticInstantFire;

var bool bNoRandomFire;

// Returns normal for some random spread. This is seperate from GetFireDir for shotgun reasons mainly...
simulated function vector GetFireSpread()
{
	local float fX;
    local Rotator R;

	if (BW.bScopeView || bNoRandomFire || class'BCReplicationInfo'.static.IsClassicOrRealism())
		return super.GetFireSpread();

	fX = frand();
	R.Yaw =  BallisticWeapon(Weapon).GetConeInaccuracy() * sin (FMin(sqrt(frand()), 1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
	if (frand() > 0.5)
		R.Yaw = -R.Yaw;
	R.Pitch = BallisticWeapon(Weapon).GetConeInaccuracy() *sin (FMin(sqrt(frand()), 1)  * 1.5707963267948966) * cos(fX*1.5707963267948966);
	if (frand() > 0.5)
		R.Pitch = -R.Pitch;
	return Vector(R);
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
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
        if(BallisticTurret(Weapon.Owner) == None  && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
			class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(load, BW.InventoryGroup);
    }
	
	if (!BW.bScopeView)
		BW.AddFireChaos(FireChaos * InterpCurveEval(FireChaosCurve, BW.GetFireChaos()));
	
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

    else if (bBurstMode)
    {
		BurstCount++;
		
    	if (BurstCount >= MaxBurst)
    	{
    		NextFireTime += FireRate * (1 + (MaxBurst * (1.0f - BurstFireRateFactor)));
    		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		BurstCount = 0;
    	}
    	else
    	{
    		NextFireTime += FireRate * BurstFireRateFactor;
  			NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
  		}
	}

    else
    {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }

    Load = AmmoPerFire;
    HoldTime = 0;
	
	if (BallisticHandgun(Weapon) != None && BallisticHandgun(Weapon).OtherGun != None && BallisticHandgun(Weapon).CanSynch(ThisModeNum))
		BallisticHandgun(BW).OtherGun.ForceFire(ThisModeNum);

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

defaultproperties
{
     FireChaos=0.100000
}
