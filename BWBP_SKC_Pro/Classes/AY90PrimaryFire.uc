//=============================================================================
// AY90PrimaryFire.
//
// Uncharged: Projectile with gravity that sticks and explodes after impact
// Charged: Instant hit that spawns sticky projectile with timed explosion
// Full Charge: Instant hit and instant explosion
//
// by Sarge based on code by RS and Jiffy
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90PrimaryFire extends BallisticProjectileFire;

var() byte OverrideMode;
var() float ChargeTime;
var() Sound	ChargeSound;
var() float AutoFireTime;

var() sound		ChargeFireSound;
var() sound		MaxChargeFireSound;


// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if(Super.AllowFire() && AY90SkrithBoltcaster(BW).MagAmmo >= 10)
		return true;
	else
		return false;
}

simulated function PlayPreFire()
{
	Weapon.AmbientSound = ChargeSound;
	//if (!BW.bScopeView)
		BW.SafeLoopAnim('PreFire', 0.15, TweenTime, ,"IDLE");
}

function ModeHoldFire()
{
    if ( BW.HasMagAmmo(ThisModeNum))
    {
        Super.ModeHoldFire();
		BW.bPreventReload = True;
    }
}

simulated event ModeDoFire()
{

	if (HoldTime >= ChargeTime && AY90SkrithBoltcaster(BW).MagAmmo >= 40)
	{
		AY90SkrithBoltcaster(BW).ParamsClasses[AY90SkrithBoltcaster(BW).GameStyleIndex].static.OverrideFireParams(AY90SkrithBoltcaster(BW),2);
		OverrideMode=2;
		AmmoPerFire=40;
		Load=40;
	}
	else if (HoldTime >= (ChargeTime/2) && AY90SkrithBoltcaster(BW).MagAmmo >= 20)
	{
		AY90SkrithBoltcaster(BW).ParamsClasses[AY90SkrithBoltcaster(BW).GameStyleIndex].static.OverrideFireParams(AY90SkrithBoltcaster(BW),1);
		OverrideMode=1;
		AmmoPerFire=20;
		Load=20;
	}
	else
	{
		AY90SkrithBoltcaster(BW).ParamsClasses[AY90SkrithBoltcaster(BW).GameStyleIndex].static.OverrideFireParams(AY90SkrithBoltcaster(BW),0);
		OverrideMode=0;
		AmmoPerFire=10;
		Load=10;
	}

	Weapon.AmbientSound = Weapon.default.AmbientSound;
	
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
        //Weapon.ConsumeAmmo(ThisModeNum, Load);
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
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
		AY90SkrithBoltcaster(BW).UpdateScreen();
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
		BW.bPreventReload = False;
	}
	
	AmmoPerFire=10;
	Load=10;
	
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	BallisticProjectile(Proj).Override(OverrideMode);
	if (Proj != None)
		Proj.Instigator = Instigator;
}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);
	
	if (bIsFiring && BW.MagAmmo >= 10)
		AY90SkrithBoltcaster(BW).UpdateScreen();

    if (bIsFiring && HoldTime >= AutoFireTime)
    {
        Weapon.StopFire(ThisModeNum);
		Weapon.AmbientSound = None;
    }
}

defaultproperties
{
     ChargeTime=4.000000
     AutoFireTime=5.000000
     ChargeSound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltCharge'
     ChargeFireSound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltBlast'
     MaxChargeFireSound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltBlastMax'
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BWBP_SKC_Pro.A73BFlashEmitter'
     //RecoilPerShot=256.000000
     //XInaccuracy=9.000000
     //YInaccuracy=6.000000
     AmmoPerFire=10
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltShot',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	 bFireOnRelease=True
     FireEndAnim=
     TweenTime=0.000000
     FireRate=1.000000
     AmmoClass=Class'BallisticProV55.Ammo_Cells'
     ShakeRotMag=(X=32.000000,Y=10.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.750000
     ShakeOffsetMag=(X=-8.00)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.750000
     ProjectileClass=Class'BWBP_SKC_Pro.AY90BoltProjectile'
     WarnTargetPct=0.200000
}
