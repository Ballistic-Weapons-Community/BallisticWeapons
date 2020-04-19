//=============================================
// More spread from hip.
// Recoil fix.
// Different range atten.
// Azarael
//=============================================
class BallisticProShotgunFire extends BallisticShotgunFire;

var float HipSpreadFactor;
var float AdjustedHipSpreadFactor;
var() float CutOffDistance;
var() float CutOffStartRange;
var int	 MaxSpreadFactor;

function float ResolveDamageFactors(Actor Other, vector TraceStart, vector HitLocation, int PenetrateCount, int WallCount, Vector WaterHitLocation)
{
	local float  DamageFactor;

	DamageFactor = 1;

	if (WaterRangeAtten < 1.0 && WaterHitLocation != vect(0,0,0))
		DamageFactor *= class'BallisticRangeAttenFire'.static.GetRangeAttenFactor(TraceStart, HitLocation, CutOffStartRange, CutOffDistance, WaterRangeAtten);
	else if (RangeAtten != 1.0)
		DamageFactor *= class'BallisticRangeAttenFire'.static.GetRangeAttenFactor(TraceStart, HitLocation, CutOffStartRange, CutOffDistance, RangeAtten);
	
	if (PenetrateCount > 0)
		DamageFactor *= PDamageFactor ** PenetrateCount;

	if (WallCount > 0)
		DamageFactor *= WallPDamageFactor ** WallCount;

	return DamageFactor;
}

//return spread in radians
simulated function float GetCrosshairInaccAngle()
{
	return YInaccuracy * HipSpreadFactor;
}

// Returns normal for some random spread. This is seperate from GetFireDir for shotgun reasons mainly...
simulated function vector GetFireSpread()
{
	local float fX;
    local Rotator R;
	
	if (BW.BCRepClass.default.bRelaxedHipFire)
		AdjustedHipSpreadFactor = default.HipSpreadFactor * 0.5;
	else
		AdjustedHipSpreadFactor = default.HipSpreadFactor;

	if (BW.bScopeView || BW.bAimDisabled)
		return super.GetFireSpread();
	else
	{
		fX = frand();
		R.Yaw =  XInaccuracy * AdjustedHipSpreadFactor * Lerp(BW.FireChaos, 1, MaxSpreadFactor) * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
		R.Pitch = YInaccuracy * AdjustedHipSpreadFactor * Lerp(BW.FireChaos, 1, MaxSpreadFactor) * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
		return Vector(R);
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
			class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(TraceCount, BW.InventoryGroup);
    }
    
	if (!BW.bScopeView)
		BW.FireChaos = FClamp(BW.FireChaos + FireChaos, 0, 1);
		
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

static function float GetAttachmentDispersionFactor()
{
	return default.HipSpreadFactor;
}

defaultproperties
{
     HipSpreadFactor=3.00000
     MaxSpreadFactor=3
     FireSpreadMode=FSM_Circle
}
