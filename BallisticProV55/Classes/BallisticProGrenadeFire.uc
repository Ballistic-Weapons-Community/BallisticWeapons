//=============================================================================
// Adjusted to throw non-Karma grenades.
//=============================================================================
class BallisticProGrenadeFire extends BallisticGrenadeFire;

function SpawnProjectile (Vector Start, Rotator Dir)
{
	local float Speed, DetonateDelay;
	local vector EnemyDir;

	Proj = Spawn (ProjectileClass,,, Start, Dir);
	Proj.Instigator = Instigator;
	if (BallisticProPineapple(Proj) != None)
	{
		if (AIController(Instigator.Controller) == None)
		{
			if (BW != None && BW.WeaponModes[BW.CurrentWeaponMode].Value == 0)
				Speed = Proj.Speed * FClamp(HoldTime-0.5, 0, 2) / 2;
			else if (BW != None)
				Speed = Proj.Speed / BW.WeaponModes[BW.CurrentWeaponMode].Value;
		}
		else if (Instigator.Controller.Enemy != None)
		{
			EnemyDir = Instigator.Controller.Enemy.Location - Instigator.Location;
			Speed = FMin( Proj.Speed, (1+Normal(EnemyDir).Z) * (VSize(EnemyDir)/1.5) + VSize(Instigator.Controller.Enemy.Velocity) * (Normal(Instigator.Controller.Enemy.Velocity) Dot Normal(EnemyDir)) );
		}
		else
			Speed = Proj.Speed;
		if (BallisticHandGrenade(Weapon).ClipReleaseTime > 0.0)
			DetonateDelay = BallisticProPineapple(Proj).DetonateDelay - (Level.TimeSeconds - BallisticHandGrenade(Weapon).ClipReleaseTime);
		else
			DetonateDelay = BallisticProPineapple(Proj).DetonateDelay;
			
		BallisticProPineapple(Proj).InitProPineapple(Speed, DetonateDelay);
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
        if(BallisticTurret(Weapon.Owner) == None  && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
			class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(load, BW.InventoryGroup);
    }
	else if (!BW.bScopeView)
	{
		FireRecoil();
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

defaultproperties
{
}
