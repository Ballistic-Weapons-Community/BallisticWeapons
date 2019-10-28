//=============================================================================
// BallisticInstantFire.
//
// Versatile WeaponFire for instant-hit weapons, e.g. bullets, melee, railguns
//
// Features:
// -Random TraceRange between Min and Max values
// -Random Damage between min and max values
// -Variable Damage for Head, Limb and Normal shots
// -Alternate DamageTypes for Head and limb shots
// -Actor penetration (bullets can go through enemies)
// -Geometry penetration (bullets can go through walls)
// -Charging damage (running towards/away from enemies changes damage)
//
// Bullets have positional damage so that damage may be adjusted for
// heads, limbs or default.
//
// Azarael modifications: Inserted Mr Evil code for finding closest point to pawn's centre
// along shot's vector. 
// Modified system: head uses biased radius check, torso is considered a cylinder of
// radius 17 (pawn radius is 25) with lower Z bound at bottom of groin. Anything else is limb damage.
//
// Fire can penetrate and go right through actors depending on PenetrateForce.
// Penetrate force is checked aginst resistance of enemy
// which is adjusted randomly according to max health + shield and weakened for
// head and leg shots.
//
// Wall Penetration also moved here...
// Goes through BSP, Statics and terrain by testing at its max penetrate range
// beyond the initial impact. If it finds a solid, it tries closer. If it finds
// space, it checks back to make sure it exited a static mesh, bsp or terrain.
// Also uses a shortcut to check for non world actors within the max penetrate
// range. This prenvents it from missing any enemies and also skips the normal
// checks by placing the next fire trace in the space with the actor.
// This is a fairly tricky piece of code...
//
// Damage can be made to vary when instigator is running towards or away from
// the enemy. This is good for some melee weapons. The calculation for this
// takes into account instigator velocity relative to enemy velocity and if the
// instigator is running toward or away from the enemy. Damage added will be:
// Damage * (relative speed / RunningSpeedThresh) * (1 to -1: Toward or Away)
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticInstantFire extends BallisticFire
	config(BallisticProV55);

//General Vars ----------------------------------------------------------------
var() Range				TraceRange;			// Min and Max range of trace
var() float				WaterRangeFactor;	// Remaining range is multiplied by this when going under water
var() float				MaxWallSize;		// Maximum thickness of the walls that this bullet gan go through
var() byte				MaxWalls;			// Max number of walls this fire can penetrate
struct TraceInfo					// This holds info about a trace
{
	var() Vector 	Start, End, HitNormal, HitLocation, Extent;
	var() Material	HitMaterial;
	var() Actor		HitActor;
};
//-----------------------------------------------------------------------------

//Damage Vars -----------------------------------------------------------------
var() float						Damage;			// Damage for nomal shots
var() float						DamageHead;		// Damage for Headshots
var() float						DamageLimb;		// Damage for Limbshots
var() float						RangeAtten;		// Attenuates damage depending on range. At max range, damage is multiplied by this.
var() float						WaterRangeAtten;// Extra attenuation applied when bullet goes through water. Damage *= Lerp(WaterDist / (MaxRange*WaterRangeFactor), 1, This)
var() class<DamageType>		DamageType;		// Damage type to use
var() class<DamageType>		DamageTypeHead;	// Damage type to use for head
var() class<DamageType>		DamageTypeArm;	// Damage type to use for unimportant limbs
var() int							KickForce;		// Strength of momentum
var() float						HookStopFactor;	// How much force is applied to counteract victim running. This * Victim.GroundSpeed
var() float						HookPullForce;	// Velocity amount added to pull victim towards instigator
var() int							PenetrateForce;	// The penetrating power of these bullets.
var() bool						bPenetrate;		// Bullets can go though enemies
var() float						PDamageFactor;	// Damage multiplied by this with each penetration
var() float						WallPDamageFactor;	// Damage multiplied by this for each wall penetration
var() bool						bUseRunningDamage;	// Enable damage variations when running towards/away from enemies
var() float						RunningSpeedThresh;	// Instigator speed divided by this to figure out Running damage bonus
var() globalconfig float		DamageModHead, DamageModLimb; //Configurable damage modifiers for base damage
var	bool						bNoPositionalDamage;
//-----------------------------------------------------------------------------

// Mode info - Azarael
// Added here to simplify the process a bit as well as for BWStats support
struct InstantFireModeInfo
{
	var int mDamage;
	var class<DamageType> mDamageType;
	var class<DamageType> mDamageTypeHead;
	var float mFireRate;
	var float mFireChaos;
	var Sound mFireSound;
	var Name mFireAnim;
	var bool bLoopedAnim; // If true, ModeFireAnim is set to FireLoopAnim and FireAnim is cleared.
	var Name mFireEndAnim;
	var float mRecoil;
	var int mAmmoPerFire;
	var Name TargetState; // Name of the state to switch to.
	//AI info
	var bool bModeLead;
	var bool bModeInstantHit;
	Var bool bModeSplash;
	var bool bModeRecommendSplash;
};

var array<InstantFireModeInfo> FireModes;

// Maximum range. Used by AI and such...
function float MaxRange()	{	return TraceRange.Max;	}

// Returns the amount by which MaxWallSize should be scaled for each surface type. Override in subclasses to change...
function float SurfaceScale (int Surf)
{
	switch (Surf)
	{
		Case 0:/*EST_Default*/	return 1.0;
		Case 1:/*EST_Rock*/		return 1.0;
		Case 2:/*EST_Dirt*/		return 4.0;
		Case 3:/*EST_Metal*/	return 0.5;
		Case 4:/*EST_Wood*/		return 2.0;
		Case 5:/*EST_Plant*/	return 4.0;
		Case 6:/*EST_Flesh*/	return 2.0;
		Case 7:/*EST_Ice*/		return 1.5;
		Case 8:/*EST_Snow*/		return 2.0;
		Case 9:/*EST_Water*/	return 8.0;
		Case 10:/*EST_Glass*/	return 1.0;
		default:				return 1.0;
	}
}
// Finds the surface type and returns returns SurfaceScale() for that surface...
function float ScaleBySurface(Actor Other, Material HitMaterial)
{
	local int Surf;
	if (Vehicle(Other) != None)
		Surf = 3;
	else if (HitMaterial == None)
		Surf = int(Other.SurfaceType);
	else
		Surf = int(HitMaterial.SurfaceType);
	return SurfaceScale(Surf);
}

// Get aim then run trace...
function DoFireEffect()
{
    local Vector StartTrace;
    local Rotator Aim;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

	DoTrace(StartTrace, Aim);

	Super.DoFireEffect();
}

// Check if bullet should go through enemy
function bool CanPenetrate (Actor Other, vector HitLocation, vector Dir, int PenCount)
{
	local float Resistance;

	if (!bPenetrate || Other == None || Other.bWorldGeometry || Mover(Other) != None || BallisticShield(Other) != None)
		return false;

	// Resistance is random between 0 and enemy max health
	if (Pawn(Other) != None)
		Resistance = FRand() * Pawn(Other).HealthMax;
	// Add target shield to resistance
	if (xPawn(Other) != None)
		Resistance += xPawn(Other).ShieldStrength;
	// Half resistance for legs
	if (Vehicle(Other) == None && HitLocation.Z < Other.Location.Z)
		Resistance *= 0.5;
	// half resitance for head
	else if (Vehicle(Other) == None && Normal(Dir).Z > -0.5 && (HitLocation.Z > Other.Location.Z + Other.CollisionHeight*0.8) )
		Resistance *= 0.5;

	if (PenetrateForce/(PenCount+1) > Resistance)
		return true;
}

// Figure out the damage, damagetype and potentially change victim, e.g. driver instead of vehicle
function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	local string	Bone;
	local float		Dmg, BoneDist;
	local Pawn		DriverPawn;

	Dmg = Damage;

	DT = DamageType;
	Victim = Other;
	
	if (bNoPositionalDamage || Monster(Other) != None)
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
				Dmg = DamageHead;
				DT = DamageTypeHead;
			}
		}
		
		else
		{
			// Check for head shot
			Bone = string(Other.GetClosestBone(HitLocation, Dir, BoneDist, 'head', 10));
			if (InStr(Bone, "head") > -1)
			{
				if (class'BallisticWeapon'.default.bUseModifiers)
					Dmg *= DamageModHead;
				else Dmg = DamageHead;
				DT = DamageTypeHead;
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
			
			else Dmg = DamageLimb;
			
			DT = DamageTypeArm;
		}
	}
	return Dmg;
}
// This is called to DoDamage to an actor found by this fire.
// Adjusts damage based on Range, Penetrates, WallPenetrates, relative velocities and runs Hurt() to do the deed...
function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	local float				Dmg;
	local float				RangeReduction;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local Vector			RelativeVelocity, ForceDir, BoneTestLocation, ClosestLocation;
		
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
		
		Dmg = GetDamage(Other, BoneTestLocation, Dir, Victim, HitDT);
	}
	
	else Dmg = GetDamage(Other, HitLocation, Dir, Victim, HitDT);
	//End locational damage code test
	
	if (BW.AimDisplacementEndTime > Level.TimeSeconds)
		Damage *= 1 - BW.AimDisplacementFactor;
	
	if (RangeAtten != 1.0)
	{
		RangeReduction = Lerp(VSize(HitLocation-TraceStart)/TraceRange.Max, 1, RangeAtten);
		Dmg *= RangeReduction;
	}
	if (WaterRangeAtten != 1.0 && WaterHitLocation != vect(0,0,0))
		Dmg *= Lerp(VSize(HitLocation-WaterHitLocation) / (TraceRange.Max*WaterRangeFactor), 1, WaterRangeAtten);
	if (PenetrateCount > 0)
		Dmg *= PDamageFactor ** PenetrateCount;
	if (WallCount > 0)
		Dmg *= WallPDamageFactor ** WallCount;
	if (bUseRunningDamage)
	{
		RelativeVelocity = Instigator.Velocity - Other.Velocity;
		Dmg += Dmg * (VSize(RelativeVelocity) / RunningSpeedThresh) * (Normal(RelativeVelocity) Dot Normal(Other.Location-Instigator.Location));
	}
	if (HookStopFactor != 0 && HookPullForce != 0 && Pawn(Victim) != None && Pawn(Victim).bProjTarget)
	{
		ForceDir = Normal(Other.Location-TraceStart);
		ForceDir.Z *= 0.3;

		Pawn(Victim).AddVelocity( Normal(Victim.Acceleration) * HookStopFactor * -FMin(Pawn(Victim).GroundSpeed, VSize(Victim.Velocity)) - ForceDir * HookPullForce );
	}

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, KickForce * Dir * RangeReduction, HitDT);
}

// Do the trace to find out where bullet really goes
function DoTrace (Vector InitialStart, Rotator Dir)
{
	local int						PenCount, WallCount;
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLoc, ExitNormal;
	local Material					HitMaterial, ExitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

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
				if (VSize(HitLocation - Start) > 1)
					WaterHitLoc=HitLocation;
				Start = HitLocation;
				Dist *= WaterRangeFactor;
				End = Start + X * Dist;
				Weapon.bTraceWater=false;
				continue;
			}

			LastHitLoc = HitLocation;
				
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{
				DoDamage(Other, HitLocation, InitialStart, X, PenCount, WallCount, WaterHitLoc);
			
				LastOther = Other;

				if (CanPenetrate(Other, HitLocation, X, PenCount))
				{
					PenCount++;
					Start = HitLocation + (X * Other.CollisionRadius * 2);
					End = Start + X * Dist;
					Weapon.bTraceWater=true;
					if (Vehicle(Other) != None)
						HitVehicleEffect (HitLocation, HitNormal, Other);
					continue;
				}
				else if (Vehicle(Other) != None)
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				else if (Mover(Other) == None)
					break;
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
				WallCount++;
				if (Other.bCanBeDamaged)
				{
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
					DoDamage(Other, HitLocation, InitialStart, X, PenCount, WallCount, WaterHitLoc);
					break;
				}
				if (WallCount <= MaxWalls && MaxWallSize > 0 && GoThroughWall(Other, HitLocation, HitNormal, MaxWallSize * ScaleBySurface(Other, HitMaterial), X, Start, ExitNormal, ExitMaterial))
				{
					WallPenetrateEffect(Other, HitLocation, HitNormal, HitMaterial);
					WallPenetrateEffect(Other, Start, ExitNormal, ExitMaterial, true);
					Weapon.bTraceWater=true;
					continue;
				}
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				
				break;
			}
			// Still in the same guy
			if (Other == Instigator || Other == LastOther)
			{
				Start = HitLocation + (X * FMax(32, Other.CollisionRadius * 2));
				End = Start + X * Dist;
				Weapon.bTraceWater=true;
				continue;
			}
			break;
		}
		else
		{
			LastHitLoc = End;
			break;
		}
	}
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall)
		NoHitEffect(X, InitialStart, LastHitLoc, WaterHitLoc);
}

// Called to do the effects for a bullet going in or coming out a wall
function HitVehicleEffect(vector HitLocation, vector HitNormal, Actor Other)
{
	local int Surf;

	if (Other == None)
		return;
	if (Other.SurfaceType > 0)
		Surf = int(Other.SurfaceType);
	else
		Surf = 3;

	BallisticAttachment(Weapon.ThirdPersonActor).UpdateDirectHit(HitLocation, HitNormal, Surf);
//	BallisticAttachment(Weapon.ThirdPersonActor).UpdateWallPenetrate(HitLocation, HitNormal, Surf);
}

// Called to do the effects for a bullet going in or coming out a wall
function WallPenetrateEffect(Actor Other, vector HitLocation, vector HitNormal, Material HitMat, optional bool bExit)
{
	local int Surf;
	if (HitMat == None)Surf = int(Other.SurfaceType); else Surf = int(HitMat.SurfaceType);
	BallisticAttachment(Weapon.ThirdPersonActor).UpdateWallPenetrate(HitLocation, HitNormal, Surf, bExit);
}

// Tells the attachment to play fire anims and so on, but without impact effects
function NoHitEffect (Vector Dir, optional vector Start, optional vector HitLocation, optional vector WaterHitLoc)
{
	if (Weapon != None && level.NetMode != NM_Client)
	{
		if (HitLocation != vect(0,0,0) && HitLocation != WaterHitLoc)
			SendFireEffect(none, HitLocation, vect(0,0,0), 0, WaterHitLoc);
		else
			SendFireEffect(none, Start + Dir * TraceRange.Max, vect(0,0,0), 0, WaterHitLoc);
	}
}

// Does something to make the effects appear
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;

	if (!Other.bWorldGeometry && Mover(Other) == None && Vehicle(Other) == None || level.NetMode == NM_Client)
		return false;

	if (Vehicle(Other) != None)
		Surf = 3;
	else if (HitMat == None)
		Surf = int(Other.SurfaceType);
	else
		Surf = int(HitMat.SurfaceType);

	// Tell the attachment to spawn effects and so on
	SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	if (!bAISilent)
		Instigator.MakeNoise(1.0);
	return true;
}

// Returns true if the trace hit the back of a surface, i.e. the surface normal and trace normal
// are pointed in the same direction...
static function bool IsBackface(vector Norm, vector Dir)	{	return (Normal(Dir) Dot Normal(Norm) > 0.0);	}
// Returns true if point is in a solid, i.e. FastTrace() fails at the point
function bool PointInSolid(vector V)				{	return !Weapon.FastTrace(V, V+vect(1,1,1));		}

function TraceInfo GetTraceInfo (Vector End, Vector Start, optional bool bTraceActors, optional Vector Extent)
{
	local TraceInfo TI;
	TI.Start = Start;	TI.End = End;	TI.Extent = Extent;
	TI.HitActor = Trace(TI.HitLocation, TI.HitNormal, TI.End, TI.Start, bTraceActors, TI.Extent, TI.HitMaterial);
	if (TI.HitActor == None)
		TI.HitLocation = TI.End;
	return TI;
}

//Fixme handle BallisticDecorations
function bool GoThroughWall(actor Other, vector FirstLoc, vector FirstNorm, float MaxWallDepth, vector Dir, out vector ExitLocation, out vector ExitNormal, optional out Material ExitMat)
{
	local TraceInfo TBack, TFore;
	local float CheckDist;
	local Vector Test, HLoc, HNorm;
	local Pawn A;

	if (MaxWallDepth <= 0)
		return false;
	// First, try shorcut method...
	foreach Weapon.CollidingActors ( class'pawn', A, MaxWallDepth, FirstLoc)
	{
		if (A == None || A == Instigator || A.TraceThisActor(HLoc, HNorm, FirstLoc + Dir * MaxWallDepth, FirstLoc))
			continue;
		TBack = GetTraceInfo(FirstLoc, HLoc, false);
		if (TBack.HitActor != None)
		{
			if (VSize(TBack.HitLocation - FirstLoc) <= MaxWallDepth)
			{
				ExitLocation = TBack.HitLocation + Dir * 1;
				ExitNormal = TBack.HitNormal;
				ExitMat = TBack.HitMaterial;
				return true;
			}
		}
		else
		{
			ExitLocation = FirstLoc + Dir * 48;
			ExitNormal = Dir;
			return true;
		}
	}
	// Start testing as far in as possible, then move closer until we're back at the start
	for (CheckDist=MaxWallDepth;CheckDist>0;CheckDist-=48)
	{
		Test = FirstLoc + Dir * CheckDist;
		// Test point is in a solid, try again
		if (PointInSolid(Test))
			continue;
		// Found space, check to make sure its open space and not just inside a static
		else
		{
			// First, Trace back and see whats there...
			TBack = GetTraceInfo(Test-Dir*CheckDist, Test, true);
			// We're probably in thick terrain, otherwise we'd have found something
			if (TBack.HitActor == None)	{
				return false;	}
			// A non world actor! Must be in valid space
			if (!TBack.HitActor.bWorldGeometry && Mover(TBack.HitActor) == None)	{
				ExitLocation = TBack.HitLocation - Dir * TBack.HitActor.CollisionRadius;
				ExitNormal = Dir;
				return true;
			}
			// Found the front face of a surface(normal parallel to Fire Dir, Opposite to Back Trace dir)
			if (VSize(TBack.HitLocation - TBack.Start) > 0.5 && IsbackFace(TBack.HitNormal, Dir))	{
				ExitLocation = TBack.HitLocation + Dir * 1;
				ExitNormal = TBack.HitNormal;
				ExitMat = TBack.HitMaterial;
				return true;
			}
			// Found a back face,
			else{	// Trace forward(along fire Dir) and see if we're inside a mesh or if the surface was just a plane
				TFore = GetTraceInfo(Test+Dir*2000, Test, true);
				if (VSize(TFore.HitLocation - TFore.Start) > 0.5)	{
					// Hit nothing, we're probably not inside a mesh (hopefully)
					if (TFore.HitActor == None)	{
						ExitLocation = TBack.HitLocation + Dir * 1;
						ExitNormal = -TBack.HitNormal;
						ExitMat = TBack.HitMaterial;
						return true;
					}
					// Found backface. Looks like its a mesh bigger than MaxWallDepth
					if (IsBackFace(TFore.HitNormal, Dir))
						return false;
					// Hit a front face...
					else	{
						ExitLocation = TBack.HitLocation + Dir * 1;
						ExitNormal = -TBack.HitNormal;
						ExitMat = TBack.HitMaterial;
						return true;
					}
				}
				else
					return false;
			}
			break;
		}
	}
	return false;
}

function StartBerserk()
{
	if (FireModes.Length == 0 || BW.CurrentWeaponMode == 0)
	{
		FireRate = default.FireRate * 0.75;
		FireAnimRate = default.FireAnimRate/0.75;
		RecoilPerShot = default.RecoilPerShot * 0.75;
		FireChaos = default.FireChaos * 0.75;
	}
	else
	{
		FireRate = FireModes[BW.CurrentWeaponMode-1].mFireRate * 0.75;
		FireAnimRate = default.FireAnimRate/0.75;
		RecoilPerShot = FireModes[BW.CurrentWeaponMode-1].mRecoil * 0.75;
		FireChaos = FireModes[BW.CurrentWeaponMode-1].mFireChaos * 0.75;
	}
}

function StopBerserk()
{
	if (FireModes.Length == 0 || BW.CurrentWeaponMode == 0)
	{
		FireRate = default.FireRate;
		FireAnimRate = default.FireAnimRate;
		RecoilPerShot = default.RecoilPerShot;
		FireChaos = default.FireChaos;
	}
	else
	{
		FireRate = FireModes[BW.CurrentWeaponMode-1].mFireRate;
		FireAnimRate = default.FireAnimRate;
		RecoilPerShot = FireModes[BW.CurrentWeaponMode-1].mRecoil;
		FireChaos = FireModes[BW.CurrentWeaponMode-1].mFireChaos;
	}
}

// Set firemode-specific props on mode switch if requested
simulated function SwitchWeaponMode (byte NewMode)
{
	if (FireModes.Length > 0)
	{
		if (NewMode == 0)
		{
			Damage			=					default.Damage;
			DamageType 	= 					default.DamageType;
			DamageTypeArm = 				default.DamageTypeArm;
			DamageTypeHead = 				default.DamageTypeHead;
			FireRate 		= 					default.FireRate;
			FireChaos 		=					default.FireChaos;
			BallisticFireSound.Sound = 	default.BallisticFireSound.Sound;
			FireLoopAnim 	= 					default.FireLoopAnim;
			FireAnim 		= 					default.FireAnim;
			FireEndAnim = 					default.FireEndAnim;
			RecoilPerShot = 					default.RecoilPerShot;
			AmmoPerFire = 					default.AmmoPerFire;
			GoToState('');
			
			//AI info
			bLeadTarget = 					default.bLeadTarget;
			bInstantHit = 						default.bInstantHit;
			bSplashDamage = 				default.bSplashDamage;
			bRecommendSplashDamage = default.bRecommendSplashDamage;
		}
		
		else
		{
			NewMode--;
			
			Damage = FireModes[NewMode].mDamage;
			DamageType = FireModes[NewMode].mDamageType;
			DamageTypeArm = FireModes[NewMode].mDamageType;
			DamageTypeHead = FireModes[NewMode].mDamageTypeHead;
			FireRate = FireModes[NewMode].mFireRate;
			FireChaos = FireModes[NewMode].mFireChaos;
			BallisticFireSound.Sound = FireModes[NewMode].mFireSound;
			if (FireModes[NewMode].bLoopedAnim)
			{
				FireLoopAnim = FireModes[NewMode].mFireAnim;
				FireAnim = '';
			}
			else
			{
				FireLoopAnim = '';
				FireAnim = FireModes[NewMode].mFireAnim;
			}

			FireEndAnim = FireModes[NewMode].mFireEndAnim;
			RecoilPerShot = FireModes[NewMode].mRecoil;
			AmmoPerFire = FireModes[NewMode].mAmmoPerFire;
			GoToState(FireModes[NewMode].TargetState);
			
			//AI info
			bLeadTarget = FireModes[NewMode].bModeLead;
			bInstantHit = FireModes[NewMode].bModeInstantHit;
			bSplashDamage = FireModes[NewMode].bModeSplash;
			bRecommendSplashDamage = FireModes[NewMode].bModeRecommendSplash;
			
			NewMode++;
		}
		
		if (Weapon.bBerserk)
		{
			FireRate *= 0.75;
			RecoilPerShot *= 0.75;
			FireChaos *= 0.75;
		}
		
		if ( Level.GRI.WeaponBerserk > 1.0 )
			FireRate /= Level.GRI.WeaponBerserk;

		Load=AmmoPerFire;
	}
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;
	
	FS.DamageInt = default.Damage;
	FS.Damage = String(FS.DamageInt);
	FS.DPS = FS.DamageInt / default.FireRate;
	FS.TTK = default.FireRate * (Ceil(175/FS.DamageInt) - 1);
	if (default.FireRate < 0.5)
		FS.RPM = String(int((1 / default.FireRate) * 60))@default.ShotTypeString$"/min";
	else FS.RPM = 1/default.FireRate@"times/second";
	FS.RPShot = default.RecoilPerShot;
	FS.RPS = default.RecoilPerShot / default.FireRate;
	FS.FCPShot = default.FireChaos;
	FS.FCPS = default.FireChaos / default.FireRate;
	FS.Range = "Max:"@(int(default.TraceRange.Max / 52.5))@"metres";
	
	return FS;
}

defaultproperties
{
     TraceRange=(Min=5000.000000,Max=5000.000000)
     WaterRangeFactor=1.000000
     RangeAtten=1.000000
     WaterRangeAtten=1.000000
     PDamageFactor=0.700000
     WallPDamageFactor=0.700000
     DamageModHead=1.500000
     DamageModLimb=0.750000
}
