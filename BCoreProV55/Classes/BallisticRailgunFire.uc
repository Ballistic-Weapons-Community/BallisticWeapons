//=============================================================================
// BallisticRailgunFire.
//
// Cut down since wall penetrates were added to InstantFire, but still uses the
// alternative and more thorough way of doing the penetrate effects...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticRailgunFire extends BallisticInstantFire;

//General Vars ----------------------------------------------------------------
var   array<vector>	WallEntrys;			// List of wall entry locations. Created when shot goes through wall and sent to attachment
var   array<vector>	WallExits;			// List of wall exit locations
//-----------------------------------------------------------------------------

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
    else if (!BW.bUseNetAim)
    	FireRecoil();

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

// Check if bullet should got through enemy
function bool CanPenetrate (Actor Other, vector HitLocation, vector Dir, int PenCount)
{
	local float Resistance;

	if (!bPenetrate || Other == None || Other.bWorldGeometry || Mover(Other) != None)
		return false;

	if (BallisticShield(Other) != None)
		return BallisticShield(Other).EffectiveThickness < MaxWallSize;

	// Resistance is random between 0 and enemy max health
	if (Pawn(Other) != None)
	{
		Resistance = FRand() * Pawn(Other).HealthMax;
		// Add target shield to resistance
		if (xPawn(Other) != None)
			Resistance += xPawn(Other).ShieldStrength;
		else
		{
			// Half resistance for legs
			if (Vehicle(Other) == None && HitLocation.Z < Other.Location.Z)
				Resistance *= 0.5;
			// half resitance for head
			else if (Vehicle(Other) == None && Normal(Dir).Z > -0.5 && (HitLocation.Z > Other.Location.Z + Other.CollisionHeight*0.8) )
				Resistance *= 0.5;
		}
	}
	else if (DestroyableObjective(Other) != None)
		Resistance = DestroyableObjective(Other).Health;

	if (PenetrateForce/(PenCount+1) > Resistance)
		return true;
	return false;
}

// Do the trace to find out where bullet really goes
function DoTrace (Vector InitialStart, Rotator Dir)
{
	local int						PenCount, WallCount, HitSameCount;
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, ExitNorm, LastHitLocation;
	local Material					HitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLocation = End;
	Weapon.bTraceWater=true;
	WallEntrys.length=0;
	WallExits.length=0;
	while (Dist > 0 && HitSameCount < 10)		// Loop traces in case we need to go through stuff
	{
		// Do the trace
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Dist -= VSize(HitLocation - Start);
		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			continue;
		if (Other != None)
		{
			// Water
			if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			{
				if (VSize(HitLocation - Start) > 1)
					WaterHitLoc=HitLocation;
				Start = HitLocation;
				End = Start + X * Dist;
				Weapon.bTraceWater=false;
				continue;
			}
			else
				LastHitLocation=HitLocation;
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{
				OnTraceHit(Other, HitLocation, InitialStart, X, PenCount, WallCount, WaterHitLoc);
				LastOther = Other;
				HitSameCount = 0;

				if (Vehicle(Other) != None)
					ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);

				if (CanPenetrate(Other, HitLocation, X, PenCount))
				{
					PenCount++;
					Start = HitLocation + (X * FMax(Other.CollisionRadius * 2, 8.0));
					End = Start + X * Dist;
					continue;
				}
				else if (Mover(Other) == None)
					break;
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
				WallCount++;
				ExitNorm = X;
				if (Other.bCanBeDamaged)
				{
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
					OnTraceHit(Other, HitLocation, InitialStart, X, PenCount, WallCount, WaterHitLoc);
					break;
				}
				if (WallCount < 5 && GoThroughWall(Other, HitLocation, HitNormal, MaxWallSize, X, Start, ExitNorm))
				{
					End = Start + X * Dist;
					if (WallEntrys.Length < 1 || VSize(HitLocation - WallEntrys[WallEntrys.Length-1]) > 80)
						WallEnterEffect(HitLocation, HitNormal, X, Other, HitMaterial);
					if (VSize(Start-HitLocation) > 50 && (WallExits.Length < 1 || VSize(HitLocation - WallExits[WallExits.Length-1]) > 80))
						WallExitEffect(Start, ExitNorm, X, Other, HitMaterial);
					continue;
				}
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				break;
			}
			// Still in the same guy
			if (Other == Instigator || Other == LastOther)
			{
				HitSameCount++;
				Start = HitLocation + (X * FMax(Other.CollisionRadius * 2, 16.0) * 2);
				End = Start + X * Dist;
				continue;
			}
			break;
		}
		else
		{
			LastHitLocation = End;
			break;
		}
	}
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall)
		NoHitEffect(X, InitialStart, LastHitLocation, WaterHitLoc);
	Weapon.bTraceWater=false;
}

function WallEnterEffect (vector HitLocation, vector HitNormal, vector X, actor other, Material HitMat)
{
	local int Surf;
	if (!Other.bWorldGeometry && Mover(Other) == None && Vehicle(Other) == None)
		return;
	WallEntrys[WallEntrys.length] = HitLocation;
	if (HitMat == None)Surf = int(Other.SurfaceType); else Surf = int(HitMat.SurfaceType);
	RailgunAttachment(Weapon.ThirdPersonActor).RailgunWallEnter(HitLocation, HitNormal, Surf, X, Other);
}
function WallExitEffect (vector HitLocation, vector HitNormal, vector X, actor other, Material HitMat)
{
	local int Surf;
	if (!Other.bWorldGeometry && Mover(Other) == None && Vehicle(Other) == None)
		return;
	WallExits[WallExits.length] = HitLocation;
	if (HitMat == None)Surf = int(Other.SurfaceType); else Surf = int(HitMat.SurfaceType);
	RailgunAttachment(Weapon.ThirdPersonActor).RailgunWallExit(HitLocation, HitNormal, Surf, X, Other);
}
simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	RailgunAttachment(Weapon.ThirdPersonActor).UpdateWallEntrys(WallEntrys);
	RailgunAttachment(Weapon.ThirdPersonActor).UpdateWallExits(WallExits);
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, (ThisModeNum > 0), WaterHitLoc);
}

defaultproperties
{
     TraceRange=(Min=10000.000000,Max=10000.000000)
     MaxWallSize=256.000000
     PDamageFactor=0.950000
}
