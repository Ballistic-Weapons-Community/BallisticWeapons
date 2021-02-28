//===========================================================================
// Akeron Secondary Fire
//
// Guidance component is just Redeemer code.
//===========================================================================
class AkeronSecondaryFire extends BallisticProProjectileFire;

var BUtil.FullSound LockOffSound;

simulated function bool AllowFire()
{
	if (AIController(Instigator.Controller) != None)
		return false;

	return Super.AllowFire();
}

function SpawnProjectile(Vector Start, Rotator Dir)
{
    local AkeronWarhead Warhead;
	local PlayerController Possessor;
    local class<AkeronWarhead> WarheadClass;

    if (BW.CurrentWeaponMode == 1)
        WarheadClass = class'AkeronWarheadFast';
    else
        WarheadClass = class'AkeronWarhead';
	
    Warhead = Weapon.Spawn(WarheadClass, Instigator,, Start, Dir);

    if (Warhead == None)
		Warhead = Weapon.Spawn(WarheadClass, Instigator,, Instigator.Location, Dir);
    
    if (Warhead != None)
    {
		AkeronLauncher(BW).ActiveWarhead = Warhead;
		Warhead.OldPawn = Instigator;
		Warhead.PlaySound(BallisticFireSound.Sound);
		Possessor = PlayerController(Instigator.Controller);
		Possessor.bAltFire = 0;
		if ( Possessor != None )
		{
			if ( Instigator.InCurrentCombo() )
				Possessor.Adrenaline = 0;
			Possessor.UnPossess();
			Instigator.SetOwner(Possessor);
			Instigator.PlayerReplicationInfo = Possessor.PlayerReplicationInfo;
			Possessor.Possess(Warhead);
		}
		Warhead.Velocity = Warhead.AirSpeed * Vector(Warhead.Rotation);
		Warhead.Acceleration = Warhead.Velocity;
		WarHead.MyTeam = Possessor.PlayerReplicationInfo.Team;
		Warhead.Master = AkeronLauncher(BW);
    }

	bIsFiring = false;
    StopFiring();
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
		BW.AddFireChaos(FireChaos);	

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
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
}

defaultproperties
{
     LockOffSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-TargetOff',Volume=0.500000,Radius=128.000000,Pitch=1.000000)
     SpawnOffset=(X=50.000000,Y=10.000000,Z=-3.000000)
     MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
     FireRecoil=64.000000
     FireChaos=0.500000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Fire1')
     bSplashDamage=True
     bRecommendSplashDamage=True
     bWaitForRelease=True
     FireEndAnim=
     FireRate=0.800000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_Akeron'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.500000
     ProjectileClass=Class'BWBP_OP_Pro.AkeronRocket'
     BotRefireRate=0.500000
     WarnTargetPct=0.300000
}
