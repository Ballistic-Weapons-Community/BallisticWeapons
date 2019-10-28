//=====================================
// Used to implement fixes, now just does inaccuracy.
// Azarael
//=====================================
class BallisticProProjectileFire extends BallisticProjectileFire;

var bool bNoRandomFire; //don't use random spread by FireChaos because this is a shotgun or other multiple-trace weapon

// Returns normal for some random spread. This is seperate from GetFireDir for shotgun reasons mainly...
simulated function vector GetFireSpread()
{
	local float fX;
    	local Rotator R;

	if (bNoRandomFire || BW.bScopeView)
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
//		Weapon.ConsumeAmmo(ThisModeNum, Load);
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
//        Instigator.SpawnTime = -100000;
        Instigator.DeactivateSpawnProtection();
        if(BallisticTurret(Weapon.Owner) == None && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
			class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(load, BW.InventoryGroup);
    }
	if (!BW.bScopeView)
		BW.FireChaos = FClamp(BW.FireChaos + (FireChaos * InterpCurveEval(FireChaosCurve, BW.FireChaos)), 0, 1);
    	
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
    		NextFireTime += FireRate * (1 + (MaxBurst * 0.25));
    		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		BurstCount = 0;
    	}
    	else
    	{
    		NextFireTime += FireRate * 0.75;
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
}
