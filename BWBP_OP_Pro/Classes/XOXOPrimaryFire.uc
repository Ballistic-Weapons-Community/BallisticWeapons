class XOXOPrimaryFire extends BallisticProProjectileFire;

#exec OBJ LOAD File=BW_Core_WeaponSound.uax

state Bomb
{
	simulated function vector GetFireSpread()
	{
		local float fX;
		local Rotator R;

		if (BW.bScopeView)
			return super.GetFireSpread();
		else
		{
			fX = frand();
			R.Yaw =  2048 * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
			R.Pitch = 2048 * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
			return Vector(R);
		}
	}
}

state Shockwave
{
	simulated function bool AllowFire()
	{
		if ((!XOXOStaff(BW).bLoveMode && XOXOStaff(BW).Lewdness < 1) || XOXOStaff(BW).Lewdness < 0.5)
			return false;
		return Super.AllowFire();
	}
	function DoFireEffect()
	{
		XOXOStaff(BW).Shockwave();
		XOXOAttachment(BW.ThirdPersonActor).Shockwave3rd();
		XOXOStaff(BW).AddLewd(-1.5);
		Super(BallisticFire).DoFireEffect();
	}
}

state Sexplosion
{
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
		{
			BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
			if (bCockAfterFire || (bCockAfterEmpty && BW.MagAmmo - ConsumedLoad < 1))
				BW.bNeedCock=true;
		}

		XOXOStaff(Weapon).ArousalDepleted();
	}
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;

    FS = Super.GetStats();
    
	FS.RangeOpt = "Max dmg: 0.6s";
	
	return FS;
}

defaultproperties
{
     SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
     FireModes(0)=(mProjClass=Class'BWBP_OP_Pro.XOXOBomb',mFireRate=1.350000,mFireChaos=0.750000,mFireSound=Sound'BWBP_OP_Sounds.XOXO.XOXO-FireBig',mFireAnim="Fire",mRecoil=1024.000000,mAmmoPerFire=16,TargetState="Bomb",bModeLead=True,bModeSplash=True)
     FireModes(1)=(mFireRate=0.900000,mFireSound=Sound'BWBP_OP_Sounds.XOXO.XOXO-Shockwave',mFireAnim="LustWave",TargetState="Shockwave",bModeInstantHit=True,bModeRecommendSplash=True)
     FireModes(2)=(mProjClass=Class'BWBP_OP_Pro.XOXONukeProjectile',mFireRate=0.500000,mFireChaos=1.000000,mFireSound=Sound'BWBP_OP_Sounds.XOXO.XOXO-Sexplosion-Fire',mFireAnim="Fire",mRecoil=1024.000000,mAmmoPerFire=1,TargetState="Sexplosion",bModeLead=True,bModeSplash=True,bModeRecommendSplash=True)
     MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
     FireRecoil=160.000000
     FireChaos=0.060000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.XOXO.XOXO-Fire',Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireAnim="Fire2"
     FireEndAnim=
     FireRate=0.170000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_XOXO'
     AmmoPerFire=3
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBP_OP_Pro.XOXOProjectile'
     WarnTargetPct=0.200000
}
