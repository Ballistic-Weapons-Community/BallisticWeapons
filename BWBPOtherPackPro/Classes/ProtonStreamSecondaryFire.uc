class ProtonStreamSecondaryFire extends BallisticProInstantFire;

var Actor 							LockedTarget;
var ProtonStreamer				PS;	
var int 								SuccessiveHits;
var Actor 							BoostMuzzleFlash;
var class<BallisticEmitter>	BoostMuzzleFlashClass;
var bool 							bNoAmmoConsumption;


simulated function SwitchWeaponMode(byte NewMode)
{
	if (NewMode == 1)
		GoToState('PowerAmp');
	else GoToState('');
}

	
//===========================================================================
// DoDamage
//
// Damage of stream ramps with successive hits
//===========================================================================
function StreamDoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir)
{
	local float Dmg;
	local class<DamageType>	HitDT;
	local actor Victim;
	local bool bWasAlive;
	
	if ( (Pawn(Other) != None && Pawn(Other).Controller != None && Pawn(Other).Controller.SameTeamAs(Instigator.Controller) ) 
		|| (DestroyableObjective(Other) != None && DestroyableObjective(Other).DefenderTeamIndex == Instigator.GetTeamNum()) ) 
	{
		if (Instigator.Controller.bFire == 0)
		{
			LockedTarget = Other;
			ProtonStreamAttachment(Weapon.ThirdPersonActor).SetLockedTarget(Other);
		}
	}
	
	else if (DestroyableObjective(Other.Owner) != None && DestroyableObjective(Other.Owner).DefenderTeamIndex == Instigator.GetTeamNum())
	{
		if (Instigator.Controller.bFire == 0)
		{
			LockedTarget = Other.Owner;
			ProtonStreamAttachment(Weapon.ThirdPersonActor).SetLockedTarget(Other.Owner);
		}
	}
	
	else
	{
		Dmg = GetDamage(Other, HitLocation, Dir, Victim, HitDT);
		
		if (xPawn(Victim) != None && Pawn(Victim).Health > 0)
		{
			if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
				bWasAlive = true;
		}
		else if (Vehicle(Victim) != None && Vehicle(Victim).Driver!=None && Vehicle(Victim).Driver.Health > 0)
			bWasAlive = true;
			
		class'BallisticDamageType'.static.GenericHurt (Victim, 0, Instigator, HitLocation, 10000 * Dir, HitDT);
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
	
	if (!bNoAmmoConsumption)
	{
		ConsumedLoad += FMin(Weapon.AmmoAmount(0), Load);
		SetTimer(FMin(0.1, FireRate/2), false);
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
	
	bNoAmmoConsumption=False;

}
	
//===========================================================================
// GetDamage
//
// Lacks locational damage
//===========================================================================
function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	local string	Bone;
	local float		Dmg, BoneDist;
	local Pawn		DriverPawn;

	Dmg = Damage;

	DT = DamageType;
	Victim = Other;
	
	//if (Monster(Other) != None)
		return Dmg;
		
	if (Pawn(Other) != None)
	{
		if (Vehicle(Other) != None)
		{
			// Try to relieve driver of his head...
			DriverPawn = Vehicle(Other).CheckForHeadShot(HitLocation, Dir, 1.0);
			if (DriverPawn != None)
			{
				Victim = DriverPawn;
				Dmg *= DamageModHead;
			}
		}
		
		else
		{
			// Check for head shot
			Bone = string(Other.GetClosestBone(HitLocation, Dir, BoneDist, 'head', 10));
			if (InStr(Bone, "head") > -1)
			{
				Dmg *= DamageModHead;
				return Dmg;
			}
			
			if (class'BallisticWeapon'.default.bEvenBodyDamage)
				return Dmg;
			
			// Torso shots
			if (HitLocation.Z > Other.GetBoneCoords('spine').Origin.Z - 14) //accounting for groin region here
			{
				HitLocation.Z = Other.Location.Z;
				// Torso radius
				if (VSize(HitLocation - Other.Location) <= 22)
					return Dmg;
			}
			
			//Anything else is limb
			if (class'BallisticWeapon'.default.bUseModifiers)
				Dmg *= DamageModLimb;
		}
	}
	return Dmg;
}
	
//===========================================================================
// MaintainConnection
//
// Called to check if stream can continue - if it can, handles damage or healing of target
//===========================================================================

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool StreamAllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading

	if (BW.AmmoAmount(0) - 1 < AmmoPerFire)
	{
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (BW.bNeedReload)
		return false;
    return true;
}

function bool MaintainConnection(vector AimVec)
{
	local Pawn P;

	if (Instigator.Controller.bFire == 1 || AimVec dot Normal(LockedTarget.Location - Instigator.Location) < 0.9 || !Weapon.FastTrace(LockedTarget.Location, Instigator.Location))
	{
		LockedTarget = None;
		ProtonStreamAttachment(Weapon.ThirdPersonActor).SetLockedTarget(None);
		return false;
	}

	P = Pawn(LockedTarget);
	
	if ( P != None && P.bProjTarget)
	{
		if (P.Health >= P.SuperHealthMax)
		{
			bNoAmmoConsumption = True;
			return true;
		}
		
		if (BallisticPawn(P) != None)
			BallisticPawn(LockedTarget).GiveAttributedHealth(Damage, Pawn(LockedTarget).HealthMax, Instigator);
		else if (Vehicle(LockedTarget) != None)
			Vehicle(LockedTarget).HealDamage(Damage, Instigator.Controller, DamageType);
		else Pawn(LockedTarget).GiveHealth(Damage, Pawn(LockedTarget).HealthMax);
	}
	else DestroyableObjective(LockedTarget).HealDamage(Damage * 3, Instigator.Controller, DamageType);

	return true;
}

function DoFireEffect()
{
	local Vector StartTrace;
	local Rotator Aim;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);
	
	
	if (LockedTarget == None || !MaintainConnection(vector(Aim)))
		DoTrace(StartTrace, Aim);
	
	if (ProtonStreamAttachment(Weapon.ThirdPersonActor).StreamEffect == None)
	{
		ProtonStreamAttachment(Weapon.ThirdPersonActor).bUseAlt=True;	
		ProtonStreamAttachment(Weapon.ThirdPersonActor).StartStream();
	}	
	ApplyRecoil();
}

state PowerAmp
{
	function StreamDoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir)
	{
		if ( Pawn(Other) != None && Pawn(Other).Controller != None && Pawn(Other).Controller.SameTeamAs(Instigator.Controller) )  
		{
			if (Instigator.Controller.bFire == 0)
			{
				LockedTarget = Other;
				ProtonStreamer(BW).BoostTarget = Pawn(Other);
				ProtonStreamAttachment(Weapon.ThirdPersonActor).SetLockedTarget(Other);
			}
		}
	}
	
	function DoFireEffect()
	{
		local Vector StartTrace;
		local Rotator Aim;

		Aim = GetFireAim(StartTrace);
		Aim = Rotator(GetFireSpread() >> Aim);
		
		if (LockedTarget == None || !MaintainConnection(vector(Aim)))
			DoTrace(StartTrace, Aim);
		
		if (ProtonStreamAttachment(Weapon.ThirdPersonActor).StreamEffect == None)
		{
			ProtonStreamAttachment(Weapon.ThirdPersonActor).bUseAlt=True;	
			ProtonStreamAttachment(Weapon.ThirdPersonActor).StartStream();
		}
		ApplyRecoil();
	}
	
	function bool MaintainConnection(vector AimVec)
	{
		if (Instigator.Controller.bFire == 1 || AimVec dot Normal(LockedTarget.Location - Instigator.Location) < 0.9 || !Weapon.FastTrace(LockedTarget.Location, Instigator.Location))
		{
			LockedTarget = None;
			ProtonStreamer(BW).BoostTarget = None;
			ProtonStreamAttachment(Weapon.ThirdPersonActor).SetLockedTarget(None);
			return false;
		}

		return true;
	}
	
	simulated function StopFiring()
	{
		Super.StopFiring();
		LockedTarget = None;
		ProtonStreamer(BW).BoostTarget = None;
		if (Instigator.Role == ROLE_Authority)
			ProtonStreamAttachment(Weapon.ThirdPersonActor).EndStream();
	}
	
	//Trigger muzzleflash emitter
	function FlashMuzzleFlash()
	{
		if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
			return;
		if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
			return;
		if (BoostMuzzleFlash != None)
			BoostMuzzleFlash.Trigger(Weapon, Instigator);

		if (!bBrassOnCock)
			EjectBrass();
	}
}
	
simulated function StopFiring()
{
	Super.StopFiring();
	LockedTarget = None;
	if (Instigator.Role == ROLE_Authority)
		ProtonStreamAttachment(Weapon.ThirdPersonActor).EndStream();
}
	
simulated function bool AllowFire()
{
	if (!StreamAllowFire())
	{
		if (Instigator.Role == ROLE_Authority && ProtonStreamAttachment(Weapon.ThirdPersonActor).bStreamOn)
			ProtonStreamAttachment(Weapon.ThirdPersonActor).EndStream();
		return false;
	}
	return true;
}
	
function float MaxRange()
{
	return 1500;
}
	
function DoTrace (Vector InitialStart, Rotator Dir)
{
	local Vector					End, X, HitLocation, HitNormal, Start, LastHitLoc;
	local Material					HitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	// Work out the range
	Dist = MaxRange();

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLoc = End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		// Do the trace
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Weapon.bTraceWater=false;
		Dist -= VSize(HitLocation - Start);
		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;
		if (Other != None)
		{
			// Water
			if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			{
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
				SuccessiveHits = 0;
				break;
			}
			LastHitLoc = HitLocation;
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{
				StreamDoDamage (Other, HitLocation, InitialStart, X);
				
				SuccessiveHits++;

				if (Vehicle(Other) != None)
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
				else if (Mover(Other) == None)
				{
					bHitWall = true;
					if (HitMaterial != None)
						SendFireEffect(Other, HitLocation, HitNormal, HitMaterial.SurfaceType);
					else SendFireEffect(Other, HitLocation, HitNormal, 0);
					break;
				}
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
				SuccessiveHits = 0;
				break;
			}
			
			SuccessiveHits = 0;
			break;
		}
		else
		{
			LastHitLoc = End;
			SuccessiveHits = 0;
			break;
		}
	}
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall)
		NoHitEffect(X, InitialStart, LastHitLoc);
}

// Effect related functions ------------------------------------------------
// Spawn the muzzleflash actor
function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
	class'BUtil'.static.InitMuzzleFlash (BoostMuzzleFlash, BoostMuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
}

defaultproperties
{
     BoostMuzzleFlashClass=Class'BWBPOtherPackPro.ProtonFlashEmitterBoost'
     Damage=5.000000
     DamageType=Class'BWBPOtherPackPro.DTProtonStreamer'
     MuzzleFlashClass=Class'BWBPOtherPackPro.ProtonFlashEmitterAlt'
     FireRecoil=1.000000
     FireChaos=0.000000
     FireChaosCurve=(Points=((InVal=0,OutVal=0.000000),(InVal=0.160000,OutVal=0.000000),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     bPawnRapidFireAnim=True
     FireAnim="FireLoop"
     FireRate=0.100000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_ProtonCharge'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     WarnTargetPct=0.200000
}
