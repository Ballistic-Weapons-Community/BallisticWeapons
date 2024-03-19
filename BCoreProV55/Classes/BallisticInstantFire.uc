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

const MAX_WALLS = 5;

//const TORSO_RADIUS = 11;
var() int						HeadRadius;						// radius for head
var() int 						HeadOffset;						// offset for head

//General Vars ----------------------------------------------------------------
var() Range				        TraceRange;				        // Min and Max range of trace
var() Range                     DecayRange;                     // Decays from 1 to range atten over min to max
var() float				        MaxWaterTraceRange;		        // Maximum distance this fire should trace after entering water
var() float				        WallPenetrationForce;	        // Maximum thickness of the walls that this bullet gan go through

//-----------------------------------------------------------------------------

//Damage Vars -----------------------------------------------------------------
var() float						Damage;							// Damage for nomal shots
var() float						DamageSpecial;					// Alternate damage for unique effects (DoT, AoE, etc)
var() float                     HeadMult;                       // Multiplier for mode's effect on head (damage, etc)
var() float                     LimbMult;                       // Multiplier for mode's effect on limb (damage, etc)
var() float						RangeAtten;						// Attenuates damage depending on range. At max range, damage is multiplied by this.
var() float						WaterRangeAtten;				// Extra attenuation applied when bullet goes through water. Damage *= Lerp(WaterDist / (MaxRange*WaterRangeFactor), 1, This)
var() class<DamageType>			DamageType;						// Damage type to use
var() class<DamageType>			DamageTypeHead;					// Damage type to use for head
var() class<DamageType>			DamageTypeArm;					// Damage type to use for unimportant limbs
var() int						KickForce;						// Strength of momentum
var() float						HookStopFactor;					// How much force is applied to counteract victim running. This * Victim.GroundSpeed
var() float						HookPullForce;					// Velocity amount added to pull victim towards instigator
var() int						PenetrateForce;					// The penetrating power of these bullets.
var() bool						bPenetrate;						// Bullets can go though enemies
var() float						PDamageFactor;					// Damage multiplied by this with each penetration
var() float						WallPDamageFactor;				// Damage multiplied by this for each wall penetration
var() bool						bUseRunningDamage;				// Enable damage variations when running towards/away from enemies
var() float						RunningSpeedThresh;				// Instigator speed divided by this to figure out Running damage bonus
var	bool						bNoPositionalDamage;
//-----------------------------------------------------------------------------

// Mode info - Azarael
// Added here to simplify the process a bit as well as for BWStats support
struct InstantFireModeInfo
{
	var int 				mDamage;
	var class<DamageType> 	mDamageType;
	var class<DamageType> 	mDamageTypeHead;
	var float 				mFireRate;
	var float 				mFireChaos;
	var Sound 				mFireSound;
	var Name 				mFireAnim;
	var bool 				bLoopedAnim; // If true, ModeFireAnim is set to FireLoopAnim and FireAnim is cleared.
	var Name 				mFireEndAnim;
	var float 				mRecoil;
	var int 				mAmmoPerFire;
	var Name 				TargetState; // Name of the state to switch to.
	//AI info
	var bool 				bModeLead;
	var bool 				bModeInstantHit;
	var bool 				bModeSplash;
	var bool 				bModeRecommendSplash;
};

var array<InstantFireModeInfo> FireModes;

simulated function ApplyFireEffectParams(FireEffectParams params)
{
    local InstantEffectParams effect_params;

    super.ApplyFireEffectParams(params);

    effect_params = InstantEffectParams(params);

	if (effect_params == None) // RX22A
		return;
		
    TraceRange = effect_params.TraceRange;             // Maximum range of this shot type
    DecayRange = effect_params.DecayRange;

    // handle params
    if (DecayRange.Max == 0 || DecayRange.Max <= DecayRange.Min)
        DecayRange.Max = TraceRange.Max;

    MaxWaterTraceRange = effect_params.WaterTraceRange;        // Maximum range through water
    // FIXME - CutOffStartRange
    RangeAtten = effect_params.RangeAtten;        // Multiplier at max falloff
	default.TraceRange = effect_params.TraceRange;             // Maximum range of this shot type
    default.DecayRange = DecayRange;
    default.MaxWaterTraceRange = effect_params.WaterTraceRange;        // Maximum range through water
    default.RangeAtten = effect_params.RangeAtten;        // Multiplier at max falloff

    Damage = effect_params.Damage;
    DamageSpecial = effect_params.DamageSpecial;
    HeadMult = effect_params.HeadMult;
    LimbMult = effect_params.LimbMult;   

	default.Damage = effect_params.Damage;
    default.HeadMult = effect_params.HeadMult;
    default.LimbMult = effect_params.LimbMult;

    DamageType = effect_params.DamageType;
    DamageTypeHead = effect_params.DamageTypeHead;	
    DamageTypeArm = effect_params.DamageTypeArm;
    bUseRunningDamage = effect_params.UseRunningDamage;
    RunningSpeedThresh = effect_params.RunningSpeedThreshold;    
	default.DamageType = effect_params.DamageType;
    default.DamageTypeHead = effect_params.DamageTypeHead;	
    default.DamageTypeArm = effect_params.DamageTypeArm;
    default.bUseRunningDamage = effect_params.UseRunningDamage;
    default.RunningSpeedThresh = effect_params.RunningSpeedThreshold;

    WallPenetrationForce = effect_params.PenetrationEnergy;
    PenetrateForce = effect_params.PenetrateForce;
    bPenetrate = effect_params.bPenetrate;    
	default.WallPenetrationForce = effect_params.PenetrationEnergy;
    default.PenetrateForce = effect_params.PenetrateForce;
    default.bPenetrate = effect_params.bPenetrate;

    // Note - Deprecate these two
    PDamageFactor = effect_params.PDamageFactor;		    // Damage multiplied by this with each penetration
    WallPDamageFactor = effect_params.WallPDamageFactor;		// Damage multiplied by this for each wall penetration    
	default.PDamageFactor = effect_params.PDamageFactor;
    default.WallPDamageFactor = effect_params.WallPDamageFactor;

    HookStopFactor = effect_params.HookStopFactor;	
    HookPullForce = effect_params.HookPullForce;    
	default.HookStopFactor = effect_params.HookStopFactor;	
    default.HookPullForce = effect_params.HookPullForce;
}

// Maximum range. Used by AI and such...
function float MaxRange()	{	return TraceRange.Max;	}

// Returns the amount by which WallPenetrationForce should be scaled for each surface type. Override in subclasses to change...
function float SurfaceScale (int Surf)
{
	switch (Surf)
	{
		Case 0:/*EST_Default*/	return 1.0; 	// bricks, concrete, drywall and such
		Case 1:/*EST_Rock*/		return 1.0;		// sometimes refers to bricks so let's be safe
		Case 2:/*EST_Dirt*/		return 2.0;
		Case 3:/*EST_Metal*/	return 0.33;
		Case 4:/*EST_Wood*/		return 6.0;		// this modifier should realistically be higher, however, we don't want to shoot straight through boxes on maps
		Case 5:/*EST_Plant*/	return 16.0;		
		Case 6:/*EST_Flesh*/	return 1.0;	 	// this refers to flesh as a surface type, which is very rare in maps - we assume it traps
		Case 7:/*EST_Ice*/		return 6.0;
		Case 8:/*EST_Snow*/		return 16.0;
		Case 9:/*EST_Water*/	return 0.25;
		Case 10:/*EST_Glass*/	return 16.0;
		default:				return 1.0;
	}
}

// Get aim then run trace...
function DoFireEffect()
{
    local Vector StartTrace;
    local Rotator Aim;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

    if (Level.NetMode == NM_DedicatedServer)
        BW.RewindCollisions();

	DoTrace(StartTrace, Aim);

    if (Level.NetMode == NM_DedicatedServer)
        BW.RestoreCollisions();

	Super.DoFireEffect();
}

// Check if bullet should go through enemy
function bool CanPenetrate (Actor Other, vector HitLocation, vector Dir, int PenCount)
{
	local float Resistance;

	if (!bPenetrate || Other == None || Other.bWorldGeometry || Mover(Other) != None)
		return false;

	if (BallisticShield(Other) != None)
		return BallisticShield(Other).EffectiveThickness < WallPenetrationForce;

	// Resistance is random between 0 and enemy max health
	if (Pawn(Other) != None)
		Resistance = FRand() * Pawn(Other).HealthMax;
	// Add target shield to resistance
	if (xPawn(Other) != None)
		Resistance += xPawn(Other).ShieldStrength;
	// Half resistance for legs
	if (Vehicle(Other) == None && HitLocation.Z < Other.Location.Z - 5)
		Resistance *= 0.5;
	// half resitance for head
	else if (Vehicle(Other) == None && Normal(Dir).Z > -0.5 && (HitLocation.Z > Other.Location.Z + Other.CollisionHeight*0.8) )
		Resistance *= 0.5;

	if (PenetrateForce/(PenCount+1) > Resistance)
		return true;
}

// Figure out the damage, damagetype and potentially change victim, e.g. driver instead of vehicle
final function float GetDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	local float		Dmg;
	local Pawn		DriverPawn;
    local Vector    HeadLocation;

	Dmg = Damage;

	DT = DamageType;
	Victim = Other;
	
	if (bNoPositionalDamage || Monster(Other) != None)
		return Dmg;
		
    if (Vehicle(Other) != None)
    {
        // Try to relieve driver of his head...
        DriverPawn = Vehicle(Other).CheckForHeadShot(HitLocation, Dir, 1.0);

        if (DriverPawn != None)
        {
            Victim = DriverPawn;

            Dmg *= HeadMult;
            DT = DamageTypeHead;
        }

        return Dmg;
    }
    
    // Pawn target - check for locational damage
    if (Pawn(Other) != None)
    {
		// Head shots - check bone
        HeadLocation = Other.GetBoneCoords('head').Origin;

        if (class'BUtil'.static.GetClosestDistanceTo(HeadLocation, TraceStart, Dir) <= HeadRadius)
        {
            Dmg *= HeadMult;
            DT = DamageTypeHead;
        }

        // Limb shots
        else if (HitLocation.Z <= Other.Location.Z - 5) // && VSize(HitLocation - Other.Location) <= TORSO_RADIUS)
		{
        	Dmg *= LimbMult;
        	DT = DamageTypeArm;
		}
    }

	return Dmg;
}

/*
hit algo for unlagged collisions

- first extend to closest point to saved head location and check if in radius - if so, return head damage
- then extend to vector between head and body, check within radius - if so, return body damage
- else return limb damage
*/

final function float GetDamageForCollision(UnlaggedPawnCollision Other, vector HitLocation, vector TraceStart, vector Dir, optional out class<DamageType> DT)
{
	local float	Dmg;
    local Vector HeadPositionApprox;
    local Vector HeadTestPoint;

	Dmg = Damage;
	DT = DamageType;

    // must be approximated. animation sync online is simply too poor
    HeadPositionApprox = Other.Location;
    HeadPositionApprox.Z += Other.CollisionHeight;
    HeadPositionApprox.Z -= HeadOffset;

    // fixme: try doing a crouch check too

	if (class'BUtil'.static.GetClosestDistanceTo(HeadPositionApprox, TraceStart, Dir) <= HeadRadius)
    {
        Dmg *= HeadMult;
        DT = DamageTypeHead;
	}

	/*
	HeadTestPoint = class'BUtil'.static.GetClosestPointTo(HeadPositionApprox, TraceStart, Dir);

    if (Abs(HeadTestPoint.Z - HeadPositionApprox.Z) <= HeadHeightHalf)
    { 
        HeadTestPoint.Z = HeadPositionApprox.Z;

        if(VSize(HeadTestPoint - HeadPositionApprox) <= HeadRadius)
        {
            Dmg *= HeadMult;
            DT = DamageTypeHead;
            return Dmg;
        }
    }
	*/

	else if (HitLocation.Z <= Other.Location.Z - 5) // && VSize(HitLocation - Other.Location) <= TORSO_RADIUS)
	{
		Dmg *= LimbMult;
		DT = DamageTypeArm;
	}
      
	return Dmg;
}

// Actor can be Pawn-derived or UnlaggedPawnCollision
function Vector GetDamageHitLocation(Actor Other, Vector HitLocation, vector TraceStart, vector Dir)
{	
    local Vector ClosestLocation;
    //local Vector BoneTestLocation;

	// Find a point on the victim's Z axis at the same height as the HitLocation.
    // FIXME: This needs a serious rethink
	ClosestLocation = Other.Location;
	ClosestLocation.Z += (HitLocation - Other.Location).Z;

    return class'BUtil'.static.GetClosestPointTo(ClosestLocation, TraceStart, Dir);
}

    /*
	//Extend the shot along its direction to a point where it is closest to the victim's Z axis.
	BoneTestLocation = Dir;
	BoneTestLocation *= VSize(ClosestLocation - HitLocation);
	BoneTestLocation *= normal(ClosestLocation - HitLocation) dot Dir; // normal(HitLocation - TraceStart); // tracestart to hitlocation is dir...
	BoneTestLocation += HitLocation;
	
	return BoneTestLocation;
    */

final function float GetRangeAttenFactor(vector start, vector end)
{
	local float dist;
    local float alpha;

	dist = VSize(end - start);

	if (dist <= DecayRange.Min)
		return 1.0f;

	if (dist >= DecayRange.Max)
		return RangeAtten;

    alpha = (dist - DecayRange.Min) / (DecayRange.Max - DecayRange.Min);

	return Lerp(alpha, 1.0f, RangeAtten);
}

function float ResolveDamageFactors(Actor Other, vector TraceStart, vector HitLocation, int PenetrateCount, int WallCount, int WallPenForce, Vector WaterHitLocation)
{
	local float  DamageFactor;
	local Vector RelativeVelocity;

	DamageFactor = 1;

	if (RangeAtten != 1.0)
		DamageFactor *= GetRangeAttenFactor(TraceStart, HitLocation);

	if (WaterRangeAtten != 1.0 && WaterHitLocation != vect(0,0,0))
		DamageFactor *= Lerp(VSize(HitLocation-WaterHitLocation) / MaxWaterTraceRange, 1, WaterRangeAtten);

	if (PenetrateCount > 0)
		DamageFactor *= PDamageFactor * PenetrateCount;

	if (WallPenetrationForce > 0 && WallCount > 0)
	{
		DamageFactor *= WallPDamageFactor * WallCount;
		DamageFactor *= WallPenForce / WallPenetrationForce;
	}
	
	if (bUseRunningDamage)
	{
		RelativeVelocity = Instigator.Velocity - Other.Velocity;
		DamageFactor += DamageFactor * (VSize(RelativeVelocity) / RunningSpeedThresh) * (Normal(RelativeVelocity) Dot Normal(Other.Location-Instigator.Location));
	}

	return DamageFactor;
}

// This is called for any actor found by this fire.
function OnTraceHit (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, int WallPenForce, optional vector WaterHitLocation)
{
	local float				Dmg;
	local float				ScaleFactor;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local Vector 			DamageHitLocation;

    if (UnlaggedPawnCollision(Other) != None)
    {
        DamageHitLocation = GetDamageHitLocation(Other, HitLocation, TraceStart, Dir);
        Dmg = GetDamageForCollision(UnlaggedPawnCollision(Other), DamageHitLocation, TraceStart, Dir, HitDT);
        Victim = UnlaggedPawnCollision(Other).UnlaggedPawn;
    }
	else 
    {   
        if (Other.IsA('xPawn') && !Other.IsA('Monster'))
        {
            DamageHitLocation = GetDamageHitLocation(xPawn(Other), HitLocation, TraceStart, Dir);
        }
        else
        {
            DamageHitLocation = HitLocation;
        }
	
	    Dmg = GetDamage(Other, DamageHitLocation, TraceStart, Dir, Victim, HitDT);
    }

	ScaleFactor = ResolveDamageFactors(Other, TraceStart, HitLocation, PenetrateCount, WallCount, WallPenForce, WaterHitLocation);
	
	Dmg *= ScaleFactor;

	if (Pawn(Victim) != None)
		ApplyForce(Pawn(Victim), TraceStart, ScaleFactor);

	ApplyDamage(Victim, Ceil(Dmg), Instigator, HitLocation, KickForce * Dir * ScaleFactor, HitDT); 
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	class'BallisticDamageType'.static.GenericHurt(Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
}

function ApplyForce(Pawn Victim, Vector Start, float ScaleFactor)
{
	local Vector ForceDir;
	if (HookStopFactor != 0 && HookPullForce != 0 && Victim.bProjTarget)
	{
		ForceDir = Normal(Victim.Location - Start) * ScaleFactor;
		ForceDir.Z *= 0.3;

		Victim.AddVelocity( Normal(Victim.Acceleration) * HookStopFactor * -FMin(Victim.GroundSpeed, VSize(Victim.Velocity)) - ForceDir * HookPullForce );
	}
}

// Do the trace to find out where bullet really goes
function DoTrace (Vector InitialStart, Rotator Dir)
{
	local int						PenCount, WallCount, WallPenForce;
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLoc, ExitNormal;
	local Material					HitMaterial, ExitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	WallPenForce = WallPenetrationForce;
	BW.UpdatePenetrationStatus(0);
	
	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLoc = End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		BW.UpdatePenetrationStatus(PenCount + WallCount);
		
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Weapon.bTraceWater=false;
		Dist -= VSize(HitLocation - Start);

		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;

		if (Other == None)
		{
			LastHitLoc = End;
			break;
		}

		// Water
		if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
		{
			if (VSize(HitLocation - Start) > 1)
				WaterHitLoc=HitLocation;
			Start = HitLocation;
			Dist = Min(Dist, MaxWaterTraceRange);
			End = Start + X * Dist;
			Weapon.bTraceWater=false;
			continue;
		}

		LastHitLoc = HitLocation;
			
		// Got something interesting
		if (!Other.bWorldGeometry && Other != LastOther)
		{
			OnTraceHit(Other, HitLocation, InitialStart, X, PenCount, WallCount, WallPenForce, WaterHitLoc);
		
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
				OnTraceHit(Other, HitLocation, InitialStart, X, PenCount, WallCount, WallPenForce, WaterHitLoc);
				break;
			}

			//log("BallisticInstantFire: Attempting wall penetration: force "$WallPenForce$" with surface scaler "$ SurfaceScale(class'WallPenetrationUtil'.static.GetSurfaceType(Other, HitMaterial)));

			if (
                    WallCount < MAX_WALLS && WallPenForce > 0 && 
                    class'WallPenetrationUtil'.static.GoThroughWall
                    (
                        Weapon, Instigator, 
                        HitLocation, HitNormal, 
                        WallPenForce * SurfaceScale(class'WallPenetrationUtil'.static.GetSurfaceType(Other, HitMaterial)), 
                        X, Start, 
                        ExitNormal, ExitMaterial
                    )
                )
			{

				//log("BallisticInstantFire: Penetrated: distance "$VSize(Start - HitLocation)$" units, energy cost "$ (VSize(Start - HitLocation) / SurfaceScale(class'WallPenetrationUtil'.static.GetSurfaceType(Other, HitMaterial))) $", initial force "$WallPenForce);
			
				WallPenForce -= (VSize(Start - HitLocation) / SurfaceScale(class'WallPenetrationUtil'.static.GetSurfaceType(Other, HitMaterial)));

				// todo: reduce dist by energy loss

				// deviate next shot slightly, to stop player firing through concealment / cover in front of them, accurately, at distant target
				Dir.Yaw += 32 - (FRand() * 64);
				Dir.Pitch += 32 - (FRand() * 64);
				X = Normal(Vector(Dir));

				//log("BallisticInstantFire: remaining force "$WallPenForce);

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

	BallisticAttachment(Weapon.ThirdPersonActor).UpdateDirectHit(ThisModeNum, HitLocation, HitNormal, Surf);
//	BallisticAttachment(Weapon.ThirdPersonActor).UpdateWallPenetrate(ThisModeNum, HitLocation, HitNormal, Surf);
}

// Called to do the effects for a bullet going in or coming out a wall
function WallPenetrateEffect(Actor Other, vector HitLocation, vector HitNormal, Material HitMat, optional bool bExit)
{
	local int Surf;

	if (HitMat == None) 
        Surf = int(Other.SurfaceType); 
    else 
        Surf = int(HitMat.SurfaceType);

	BallisticAttachment(Weapon.ThirdPersonActor).UpdateWallPenetrate(ThisModeNum, HitLocation, HitNormal, Surf, bExit);
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

function StartBerserk()
{
	if (FireModes.Length == 0 || BW.CurrentWeaponMode == 0)
	{
        Super.StartBerserk();
    }
	else
	{
		FireRate = FireModes[BW.CurrentWeaponMode-1].mFireRate * 0.75;
		FireAnimRate = default.FireAnimRate/0.75;
		FireRecoil = FireModes[BW.CurrentWeaponMode-1].mRecoil * 0.75;
		FireChaos = FireModes[BW.CurrentWeaponMode-1].mFireChaos * 0.75;
	}
}

function StopBerserk()
{
	if (FireModes.Length == 0 || BW.CurrentWeaponMode == 0)
	{
		Super.StopBerserk();
	}
	else
	{
		FireRate = FireModes[BW.CurrentWeaponMode-1].mFireRate;
		FireAnimRate = default.FireAnimRate;
		FireRecoil = FireModes[BW.CurrentWeaponMode-1].mRecoil;
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
			Damage			=				default.Damage;
			DamageType 		= 				default.DamageType;
			DamageTypeArm 	= 				default.DamageTypeArm;
			DamageTypeHead 	= 				default.DamageTypeHead;
			FireRate 		= 				default.FireRate;
			FireChaos 		=				default.FireChaos;
			BallisticFireSound.Sound 	= 	default.BallisticFireSound.Sound;
			FireLoopAnim 	= 				default.FireLoopAnim;
			FireAnim 		= 				default.FireAnim;
			FireEndAnim = 					default.FireEndAnim;
			FireRecoil = 					default.FireRecoil;
			AmmoPerFire = 					default.AmmoPerFire;
			GoToState('');
			
			//AI info
			bLeadTarget = 					default.bLeadTarget;
			bInstantHit = 					default.bInstantHit;
			bSplashDamage = 				default.bSplashDamage;
			bRecommendSplashDamage 		= default.bRecommendSplashDamage;
		}
		
		else
		{
			NewMode--;
			
			Damage 						= FireModes[NewMode].mDamage;
			DamageType 					= FireModes[NewMode].mDamageType;
			DamageTypeArm 				= FireModes[NewMode].mDamageType;
			DamageTypeHead 				= FireModes[NewMode].mDamageTypeHead;
			FireRate 					= FireModes[NewMode].mFireRate;
			FireChaos 					= FireModes[NewMode].mFireChaos;
			BallisticFireSound.Sound 	= FireModes[NewMode].mFireSound;

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

			FireEndAnim 				= FireModes[NewMode].mFireEndAnim;
			FireRecoil 					= FireModes[NewMode].mRecoil;
			AmmoPerFire 				= FireModes[NewMode].mAmmoPerFire;

			GoToState(FireModes[NewMode].TargetState);
			
			//AI info
			bLeadTarget 				= FireModes[NewMode].bModeLead;
			bInstantHit 				= FireModes[NewMode].bModeInstantHit;
			bSplashDamage 				= FireModes[NewMode].bModeSplash;
			bRecommendSplashDamage 		= FireModes[NewMode].bModeRecommendSplash;
			
			NewMode++;
		}
		
		if (Weapon.bBerserk)
		{
			FireRate *= 0.75;
			FireRecoil *= 0.75;
			FireChaos *= 0.75;
		}
		
		if ( Level.GRI.WeaponBerserk > 1.0 )
			FireRate /= Level.GRI.WeaponBerserk;

		Load=AmmoPerFire;
	}
}

defaultproperties
{
	TraceRange=(Min=5000.000000,Max=5000.000000)
	MaxWaterTraceRange=128 // ~ 3 feet
	RangeAtten=1.000000
	WaterRangeAtten=0.000000
	PDamageFactor=0.700000
	WallPDamageFactor=0.95

	// backup values in case of failure to assign
	HeadMult=2.0f
	LimbMult=0.75f

	HeadOffset=12
	HeadRadius=12
}
