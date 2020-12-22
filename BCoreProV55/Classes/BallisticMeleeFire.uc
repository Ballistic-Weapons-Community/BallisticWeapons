//=============================================================================
// BallisticMeleeFire.
//
// Fire class for swipe type melee attacks.
// This uses several traces each pointed in a predetermined direction to check
// for actors. SwipePoints is a list of offsets for the traces. These could be
// set to form a line shaped pattern for the traces to trace the path of a
// swinging sword or whatever. Only one of the traces will be used to do damage
// to each seperate actor found in the path, unlike a shotgun. Each point has
// an associated weight value used to dermine which trace is better to do
// damage to an actor if multiple hit the same actor. The WallHitPoint sets
// which point if used for impact effects and other wall like hit.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticMeleeFire extends BallisticInstantFire;

//General Vars ----------------------------------------------------------------
struct SwipePoint
{
	var() int		Weight;		// Weight of this point opposed to other points that hit the same victim
	var() Rotator	Offset;		// Rotational offset from standard fire trace.
};
struct SwipeHit
{
	var() int		Weight;		// Weight of this hit
	var() Actor		Victim;		// Guy that got hit
	var() Vector	HitLoc;		// The hitloc of the trace
	var() Vector	HitDir;		// Direction of the trace
};
var() array<SwipePoint>		SwipePoints;	// The rotational offset points used to determin the path of the swipe
var() int					WallHitPoint;	// Which of the points should be sued for wall hits
var() int					NumSwipePoints;	// Which of the points should be sued for wall hits
var   array<SwipeHit>		SwipeHits;		// Temporary(per fire) record of hits. For comparing multiple hits on same targets

var	float	HoldStartTime;		//Used if this weapon's mode is 2, which means it's being used for its ModeDoFire function.
var() float MaxBonusHoldTime;	//Max hold time for bonus damage
var() float FlankDamageMult;
var() float BackDamageMult;
var() float ChargeDamageBonusFactor;

var float	FatiguePerStrike;

var bool bCanBackstab;


//-----------------------------------------------------------------------------

simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading

    return true;
}

//return spread in radians
simulated function float GetCrosshairInaccAngle()
{
	return SwipePoints[0].offset.Yaw * 0.000095873799;
}

function float MaxRange()
{
	return TraceRange.Max;
}

simulated function SetInstigator(Pawn P)
{
	Instigator = P;
}

//================================================
// ResolveDamageFactors
//
// Reduce damage when using non-Booster combo 
// Implement hold time damage
// Implement backstab damage
//================================================
function float ResolveDamageFactors(Actor Victim, vector TraceStart, vector HitLocation, int PenetrateCount, int WallCount, int WallPenForce, Vector WaterHitLocation)
{
	local float DamageFactor;
	local Vector testDir;
	local Combo combo;

	DamageFactor = Super.ResolveDamageFactors(Victim, TraceStart, HitLocation, PenetrateCount, WallCount, WallPenForce, WaterHitLocation);
	// Reduce damage if using Speed or MiniMe (hits unknown combos as well)
	combo = xPawn(Instigator).CurrentCombo;

	if(combo != None && ComboDefensive(combo) == None && ComboBerserk(combo) == None)
		DamageFactor *= 0.5;

	// Damage increases with hold time
	if (HoldTime > 0)
		DamageFactor *= 1 + ChargeDamageBonusFactor * (FMin(HoldTime, MaxBonusHoldTime)/MaxBonusHoldTime);
	else if (ThisModeNum == 2 && HoldStartTime != 0) // check for BallisticWeapon MeleeFireMode
	{
		DamageFactor *= 1 + ChargeDamageBonusFactor * (FMin(Level.TimeSeconds - HoldStartTime, MaxBonusHoldTime)/MaxBonusHoldTime);
		HoldStartTime = 0.0f;
	}
	
	// Most weapons can backstab
	if (bCanBackstab)
	{
		testDir = Normal(HitLocation - TraceStart);
		testDir.Z = 0;
	
		if (Vector(Victim.Rotation) Dot testDir > 0.6)
			DamageFactor *= BackDamageMult;
		else if (Vector(Victim.Rotation) Dot testDir > 0.25)
			DamageFactor *= FlankDamageMult;
	}

	DamageFactor = FMin(3f, DamageFactor);

	return DamageFactor;
}

// Get aim then run trace...
function DoFireEffect()
{
    local Vector StartTrace;
    local Rotator Aim, PointAim;
    local int i;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

    if (Level.NetMode == NM_DedicatedServer)
        BW.RewindCollisions();

	// Do trace for each point
	for	(i=0; i<NumSwipePoints; i++)
	{
		if (SwipePoints[i].Weight < 0)
			continue;
		PointAim = Rotator(Vector(SwipePoints[i].Offset) >> Aim);
		MeleeDoTrace(StartTrace, PointAim, i==WallHitPoint, SwipePoints[i].Weight);
	}

    if (Level.NetMode == NM_DedicatedServer)
        BW.RestoreCollisions();

	// Do damage for each victim
	for (i=0; i<SwipeHits.length; i++)
	{
		OnTraceHit(SwipeHits[i].Victim, SwipeHits[i].HitLoc, StartTrace, SwipeHits[i].HitDir, 0, 0, 0);
		SwipeHits[i].Victim = None;
	}

	SwipeHits.Length = 0;

	Super(BallisticFire).DoFireEffect();
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	if (ThisModeNum == 2)
		BallisticAttachment(Weapon.ThirdPersonActor).MeleeUpdateHit(Other, HitLocation, HitNormal, Surf);
	else Super.SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
}

// Do the trace to find out where bullet really goes
function MeleeDoTrace (Vector InitialStart, Rotator Dir, bool bWallHitter, int Weight)
{
	local int							i;
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLocation;
	local Material					HitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLocation=End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		// Do the trace
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Dist -= VSize(HitLocation - Start);
		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;
		if (Other != None)
		{
			LastHitLocation=HitLocation;
			// Water
			if (bWallHitter && ((FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume)))
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
				for(i=0;i<SwipeHits.length;i++)
					if (SwipeHits[i].Victim == Other)
					{
						if(SwipeHits[i].Weight < Weight)
						{
							SwipeHits.Remove(i, 1);
							i--;
						}
						else
							break;
					}
				if (i>=SwipeHits.length)
				{
					SwipeHits.Length = SwipeHits.length + 1;
					SwipeHits[SwipeHits.length-1].Victim = Other;
					SwipeHits[SwipeHits.length-1].Weight = Weight;
					SwipeHits[SwipeHits.length-1].HitLoc = HitLocation;
					SwipeHits[SwipeHits.length-1].HitDir = X;
					LastOther = Other;

					if (bWallHitter && Vehicle(Other) != None)
					{
						bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
					}
				}
				if (Mover(Other) == None)
					Break;
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
				if (Other.bCanBeDamaged)
				{
					for(i=0;i<SwipeHits.length;i++)
						if (SwipeHits[i].Victim == Other)
						{
							if(SwipeHits[i].Weight < Weight)
							{
								SwipeHits.Remove(i, 1);
								i--;
							}
							else
								break;
						}
					if (i>=SwipeHits.length)
					{
						SwipeHits.Length = SwipeHits.length + 1;
						SwipeHits[SwipeHits.length-1].Victim = Other;
						SwipeHits[SwipeHits.length-1].Weight = Weight;
						SwipeHits[SwipeHits.length-1].HitLoc = HitLocation;
						SwipeHits[SwipeHits.length-1].HitDir = X;
						LastOther = Other;
					}
				}
				if (bWallHitter)
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				break;
			}
			// Still in the same guy
			if (Other == Instigator || Other == LastOther)
			{
				Start = HitLocation + (X * Other.CollisionRadius * 2);
				End = Start + X * Dist;
				continue;
			}
			break;
		}
		else
			break;
	}
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall && bWallHitter)
		NoHitEffect(X, InitialStart, LastHitLocation, WaterHitLoc);
	Weapon.bTraceWater=false;
}

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
		NextFireTime += FireRate * (1 + FMax(0, BW.MeleeFatigue - 0.15f));
		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
	}
	
	if (!BW.bBerserk)
		BW.MeleeFatigue = FMin(BW.MeleeFatigue + FatiguePerStrike, 1);
	
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
	BW.GunLength = BW.default.GunLength;
	if (BW.SprintControl != None && BW.SprintControl.bSprinting)
		BW.PlayerSprint(true);
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate / (1 + BW.MeleeFatigue * 0.75), 0.0, ,"FIRE");
	else BW.SafePlayAnim(FireAnim, FireAnimRate / (1 + BW.MeleeFatigue * 0.75), TweenTime, ,"FIRE");
}

//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate / (1 + BW.MeleeFatigue * 0.75), 0.0, ,"FIRE");
	else BW.SafePlayAnim(FireAnim, FireAnimRate / (1 + BW.MeleeFatigue * 0.75), TweenTime, ,"FIRE");
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

simulated event ModeHoldFire()
{
	BW.GunLength=1;
	if (BW.SprintControl != None && BW.SprintControl.bSprinting)
		BW.PlayerSprint(false);
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;
	
	FS.DamageInt = default.Damage;
	if (default.bFireOnRelease)
		FS.Damage = String(FS.DamageInt)@"-"@String(int(FS.DamageInt * 1.33));
	else	FS.Damage = String(FS.DamageInt);


    FS.HeadMult = default.HeadMult;
    FS.LimbMult = default.LimbMult;

	FS.DPS = default.Damage / default.FireRate;
	FS.TTK = default.FireRate * (Ceil(175/default.Damage) - 1);
	FS.RPM = 1/default.FireRate@"attacks/second";
	FS.RangeOpt = "Max range: "@(default.TraceRange.Max / 52.5)@"metres";
	
	return FS;
}

defaultproperties
{
     SwipePoints(0)=(Weight=3,offset=(Yaw=2560))
     SwipePoints(1)=(Weight=5,offset=(Yaw=1280))
     SwipePoints(2)=(Weight=6)
     SwipePoints(3)=(Weight=4,offset=(Yaw=-1280))
     SwipePoints(4)=(Weight=2,offset=(Yaw=-2560))
     WallHitPoint=2
	 NumSwipePoints=5
	 WallPenetrationForce=0
     HeadMult=1f 
     LimbMult=1f
     MaxBonusHoldTime=1.500000
     bCanBackstab=True
     TraceRange=(Min=145.000000,Max=145.000000)

     Damage=50.000000
     ChargeDamageBonusFactor=1f
     FlankDamageMult=1.15f
     BackDamageMult=1.3f

     PDamageFactor=0.500000
     RunningSpeedThresh=1000.000000
     bNoPositionalDamage=True
     ShotTypeString="attacks"
     TweenTime=0.100000
     FireRate=0.800000
}
