class ProtonStreamPrimaryFire extends BallisticProInstantFire;

var Actor LockedTarget;
var   ProtonStreamer			PS;	
var int SuccessiveHits;

simulated function SwitchWeaponMode(byte NewMode)
{
	if (NewMode == 1)
		GoToState('PowerDrain');
	else GoToState('');
}
	
//===========================================================================
// GetDamage
//
// Lacks locational damage
//===========================================================================
function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	DT = DamageType;
	Victim = Other;

	return Damage;
}
	
simulated function StopFiring()
{
	Super.StopFiring();
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

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool StreamAllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading

	if (BW.AmmoAmount(0) >= AmmoClass.default.MaxAmmo)
	{
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (BW.bNeedReload)
		return false;
    return true;
}


function StreamDoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir)
{
	local float Dmg;
	local class<DamageType>	HitDT;
	local actor Victim;
	local bool bWasAlive;
	
	Dmg = GetDamage(Other, HitLocation, Dir, Victim, HitDT);
	
	if (xPawn(Victim) != None && Pawn(Victim).Health > 0 && Pawn(Victim).bProjTarget)
	{
		if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
			bWasAlive = true;
	}
	else if (Vehicle(Victim) != None && Vehicle(Victim).Driver!=None && Vehicle(Victim).Driver.Health > 0)
		bWasAlive = true;
		
	if (SuccessiveHits > 1)
		class'BallisticDamageType'.static.GenericHurt (Victim, Min(Dmg + SuccessiveHits, 12), Instigator, HitLocation, vect(0,0,0), HitDT);
	else class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, vect(0,0,0), HitDT);
	if (bWasAlive && (Pawn(Victim).Controller == None || !Pawn(Victim).Controller.SameTeamAs(Instigator.Controller)))
		ProtonStreamer(BW).BonusAmmo(1);
}

function DoFireEffect()
{
	local Vector StartTrace;
	local Rotator Aim;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);
	

	DoTrace(StartTrace, Aim);
	
	if (ProtonStreamAttachment(Weapon.ThirdPersonActor).StreamEffect == None)
	{
		ProtonStreamAttachment(Weapon.ThirdPersonActor).bUseAlt=False;	
		ProtonStreamAttachment(Weapon.ThirdPersonActor).StartStream();
	}
	ApplyRecoil();
}

state PowerDrain
{
	function StreamDoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir)
	{
		if ( Pawn(Other) != None && Pawn(Other).Controller != None && !Pawn(Other).Controller.SameTeamAs(Instigator.Controller) )  
		{
			if (Instigator.Controller.bAltFire == 0)
			{
				LockedTarget = Other;
				ProtonStreamer(BW).DrainTarget = Pawn(Other);
				ProtonStreamAttachment(Weapon.ThirdPersonActor).SetLockedTarget(Other);
			}
		}
		
		if (LockedTarget != None && LockedTarget.bProjTarget)
			ProtonStreamer(BW).BonusAmmo(1);
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
			ProtonStreamAttachment(Weapon.ThirdPersonActor).bUseAlt=False;	
			ProtonStreamAttachment(Weapon.ThirdPersonActor).StartStream();
		}
		ApplyRecoil();
	}
	
	function bool MaintainConnection(vector AimVec)
	{
		if (Instigator.Controller.bAltFire == 1 || !LockedTarget.bProjTarget || AimVec dot Normal(LockedTarget.Location - Instigator.Location) < 0.9 || !Weapon.FastTrace(LockedTarget.Location, Instigator.Location))
		{
			LockedTarget = None;
			ProtonStreamer(BW).DrainTarget = None;
			ProtonStreamAttachment(Weapon.ThirdPersonActor).SetLockedTarget(None);
			return false;
		}
		
		ProtonStreamer(BW).BonusAmmo(1);

		return true;
	}
	
	simulated function StopFiring()
	{
		Super.StopFiring();
		LockedTarget = None;
		ProtonStreamer(BW).DrainTarget = None;
		if (Instigator.Role == ROLE_Authority)
			ProtonStreamAttachment(Weapon.ThirdPersonActor).EndStream();
	}
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

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     Damage=6.000000
     DamageType=Class'BWBPOtherPackPro.DTProtonStreamer'
     MuzzleFlashClass=Class'BWBPOtherPackPro.ProtonFlashEmitter'
     FireRecoil=1.000000
     FireChaos=0.000000
     FireChaosCurve=(Points=((InVal=0,OutVal=0.000000),(InVal=0.160000,OutVal=0.000000),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     bPawnRapidFireAnim=True
     FireAnim="FireLoop"
     FireRate=0.070000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_ProtonCharge'
     AmmoPerFire=0
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     WarnTargetPct=0.200000
}
