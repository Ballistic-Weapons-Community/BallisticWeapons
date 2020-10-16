//=============================================================================
// R9 Secondary Fire
//
// Multi-shot.
// Water: Freeze rounds, slow.
// Fire: Explosive rounds, damage to nearby enemies.
// Alternative Fire: Heat shot, like a laser bullet - like LS-14
// Air: Phosphorous shell attack. Hits the target and all nearby enemies for a DoT. DoT duration increases
// with successive hits.
// Earth: Poison, DoT + viewflash.
//
// Charged version of the fires.
//=============================================================================
class R9SecondaryFire extends R9PrimaryFire;

var float BurstInterval;

simulated function FireRecoil ()
{
	local Vector VelRecoilVect;
	if (BW != None)
	{
		if (!BW.bReaiming)
			BW.Reaim(level.TimeSeconds-Weapon.LastRenderTime, , , , , FireChaos);
		if (BurstCount > 0)
			BW.AddRecoil(FireRecoil * 1.5, ThisModeNum);
		else BW.AddRecoil(FireRecoil, ThisModeNum);
	}
	if (FirePushbackForce != 0 && Instigator!= None)
	{
		VelRecoilVect = Vector(Instigator.GetViewRotation()) * FirePushbackForce;
		VelRecoilVect.Z *= 0.25;
		
		if (Instigator.Physics == PHYS_Falling)
			Instigator.Velocity -= VelRecoilVect * 0.5;
		else
			Instigator.Velocity -= VelRecoilVect;
	}
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
    }
    else if (!BW.bUseNetAim && !BW.bScopeView)
    	ApplyRecoil();
	
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

	BurstCount++;
	
	//log("ModeDoFire: BurstCount:"@BurstCount);
	if (BurstCount >= MaxBurst)
	{
		//log("End");
		NextFireTime += FireRate;
		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
		BurstCount = 0;
	}
	else
	{
		//log("Continue");
		NextFireTime +=	BurstInterval;
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

function StopFiring()
{	
	//log("STOP");
	BurstCount = 0;
	NextFireTime = Level.TimeSeconds + FireRate;
}

defaultproperties
{
     BurstInterval=0.125000
     MaxBurst=2
     FireRecoil=512.000000
     FireRate=0.900000
}
