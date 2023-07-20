class XOXOSecondaryFire extends BallisticProInstantFire;

var Actor LockedTarget;

var int SuccessiveHits;

simulated function bool AllowFire()
{
	if (!StreamAllowFire())
	{
		if (Instigator.Role == ROLE_Authority && XOXOAttachment(Weapon.ThirdPersonActor).bStreamOn)
			XOXOAttachment(Weapon.ThirdPersonActor).EndStream();
		return false;
	}
	return true;
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool StreamAllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading

	if (BW.MagAmmo < AmmoPerFire)
	{
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (BW.bNeedReload)
		return false;
    return true;
}

//===========================================================================
// DoDamage
//
// Damage of stream ramps with successive hits
//===========================================================================
function StreamDoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir)
{
	local float Dmg;
	local actor Victim;
	local bool bWasAlive;
	local class<DamageType> HitDT;
	local Vector ClosestLocation, BoneTestLocation;
	
	if ( (Pawn(Other) != None && Pawn(Other).Controller != None && Pawn(Other).Controller.SameTeamAs(Instigator.Controller) ) 
		|| (DestroyableObjective(Other) != None && DestroyableObjective(Other).DefenderTeamIndex == Instigator.GetTeamNum()) ) 
	{
		if (Instigator.Controller.bFire == 0)
		{
			LockedTarget = Other;
			XOXOAttachment(Weapon.ThirdPersonActor).SetLockedTarget(Other);
		}
	}
	
	else if (DestroyableObjective(Other.Owner) != None && DestroyableObjective(Other.Owner).DefenderTeamIndex == Instigator.GetTeamNum())
	{
		if (Instigator.Controller.bFire == 0)
		{
			LockedTarget = Other.Owner;
			XOXOAttachment(Weapon.ThirdPersonActor).SetLockedTarget(Other.Owner);
		}
	}
	
	else
	{
		//Locational damage code from Mr Evil
		if(Other.IsA('xPawn') && !Other.IsA('Monster'))
		{
			//Find a point on the victim's Z axis at the same height as the HitLocation.
			ClosestLocation = Other.Location;
			ClosestLocation.Z += (HitLocation - Other.Location).Z;
			
			//Extend the shot along its direction to a point where it is closest to the victim's Z axis.
			BoneTestLocation = Dir;
			BoneTestLocation *= VSize(ClosestLocation - HitLocation);
			BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(HitLocation - TraceStart);
			BoneTestLocation += HitLocation;
	
			Dmg = GetDamage(Other, BoneTestLocation, TraceStart, Dir, Victim, HitDT);
		}

		else Dmg = GetDamage(Other, HitLocation, TraceStart, Dir, Victim, HitDT);
		
		if (xPawn(Victim) != None && Pawn(Victim).Health > 0)
		{
			if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
				bWasAlive = true;
		}
		else if (Vehicle(Victim) != None && Vehicle(Victim).Driver!=None && Vehicle(Victim).Driver.Health > 0)
			bWasAlive = true;
			
		class'BallisticDamageType'.static.GenericHurt (Victim, Min(Dmg + SuccessiveHits, 30), Instigator, HitLocation, 10000 * Dir, HitDT);

		if (bWasAlive && Pawn(Victim).Health <= 0)
			class'XOXOLewdness'.static.DistributeLewd(HitLocation, Instigator, Pawn(Victim), Weapon);
	}
}

//===========================================================================
// MaintainConnection
//
// Called to check if stream can continue - if it can, handles damage or healing of target
//===========================================================================
function bool MaintainConnection(vector AimVec)
{
	local int HealAmount;
	
	HealAmount = 2;

	if (XOXOStaff(BW).bLoveMode)
		HealAmount *= 2;
		
	if (Instigator.Controller.bFire == 1 || AimVec dot Normal(LockedTarget.Location - Instigator.Location) < 0.9 || !Weapon.FastTrace(LockedTarget.Location, Instigator.Location))
	{
		LockedTarget = None;
		XOXOAttachment(Weapon.ThirdPersonActor).SetLockedTarget(None);
		return false;
	}
	
	if (Pawn(LockedTarget) != None && LockedTarget.bProjTarget)
	{
		if (BallisticPawn(LockedTarget) != None)
			BallisticPawn(LockedTarget).GiveAttributedHealth(HealAmount, Pawn(LockedTarget).HealthMax, Instigator);
		else if (Vehicle(LockedTarget) != None)
			Vehicle(LockedTarget).HealDamage(HealAmount, Instigator.Controller, DamageType);
		else Pawn(LockedTarget).GiveHealth(HealAmount, Pawn(LockedTarget).HealthMax);
	}
	else DestroyableObjective(LockedTarget).HealDamage(HealAmount * 3, Instigator.Controller, DamageType);
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
	
	if (XOXOAttachment(Weapon.ThirdPersonActor).StreamEffect == None)
		XOXOAttachment(Weapon.ThirdPersonActor).StartStream();

	ApplyRecoil();
}
	
simulated function StopFiring()
{
	Super.StopFiring();
	LockedTarget = None;
	if (Instigator.Role == ROLE_Authority)
		XOXOAttachment(Weapon.ThirdPersonActor).EndStream();
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
				
				if (Pawn(Other) != None)
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

defaultproperties
{
	MaxWaterTraceRange=5000
	DamageType=Class'BWBP_OP_Pro.DTXOXOStream'
	DamageTypeHead=Class'BWBP_OP_Pro.DTXOXOStream'
	DamageTypeArm=Class'BWBP_OP_Pro.DTXOXOStream'
	MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
	FireRecoil=0.000000
	FireChaos=0.000000
	FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
	bPawnRapidFireAnim=True
	FireAnim="SecFireLoop"
	FireEndAnim="SecFireEnd"
	FireRate=0.070000
	AmmoClass=Class'BWBP_OP_Pro.Ammo_XOXO'
	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-5.00)
	ShakeOffsetRate=(X=-100.000000)
	ShakeOffsetTime=2.000000
	WarnTargetPct=0.200000
}
