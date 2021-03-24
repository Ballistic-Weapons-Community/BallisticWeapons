//=============================================================================
// M46Grenade.
//
// Proximity Grenade fired by M46 Attached grenade launcher.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class M46Grenade extends BallisticGrenade;

var Actor StuckActor;
var bool bPlaced;
var M46AssaultRifle M46;

simulated function ApplyImpactEffect(Actor Other, Vector HitLocation)
{
    if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );
			
    class'BallisticDamageType'.static.GenericHurt(Other, ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
}

simulated function bool Impact(Actor Other, Vector HitLocation)
{
    local Vector HitNormal;
    local Vector VNorm;

    if(Pawn(Other) != None)
	{
		HitNormal = Normal(HitLocation - Other.Location);
		VNorm = (Velocity dot HitNormal) * HitNormal;
		Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

		if (RandomSpin != 0)
			RandSpin(100000);
		Speed = VSize(Velocity);

        return true;
	}

     return false;
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	if(Pawn(Wall) != None)
		StuckActor = Wall;
	Explode(Location, HitNormal);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local Actor 	LastTrace;
	local Vector	Start, End, LastHitLoc, LastHitNorm;
	local Rotator 	R;
	local M46Mine   Proj;
	local float     BoneDist;

	if(bPlaced)
		return;

	bPlaced = true;
    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController());
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	if(Role < ROLE_Authority)
	{
		Destroy();
		Return;
	}

	// Check for wall
	if(StuckActor == None)
	{
		Start = HitLocation - (Normal(Velocity) *16.0);
		End = Start + (Normal(Velocity) * 128);
		LastTrace = Trace(LastHitLoc, LastHitNorm, End, Start, false);
		if (LastTrace == None || (!LastTrace.bWorldGeometry && Mover(LastTrace) == None))
			return;

		if (LastTrace == None)
			return;

		LastHitLoc += (5.0 * LastHitNorm);
		LastHitNorm = -LastHitNorm;
	}
	else
	{
		R = Rotation;
		LastHitLoc = Location;
		LastHitNorm = Normal(Velocity);
	}
	R = Rotator(LastHitNorm);
	R.Roll = Rand(65536);
	
	//Didn't hit a pawn
	if(StuckActor == None)
	{
		Proj = Spawn (class'M46ProximityMine',,, LastHitLoc, R);
		if (Proj != None)
		{
			Proj.Instigator = Instigator;
			Proj.InstigatorController = InstigatorController;
			M46ProximityMine(Proj).OriginalPlacer = Instigator;
			Proj.bHardAttach = true;
			Proj.SetBase(LastTrace);
		}

	}
	else
	{
		Proj = Spawn (class'M46StickyMine',,, LastHitLoc, R);
		Proj.Instigator = Instigator;
		Proj.SetPhysics(PHYS_None);
		Proj.bHardAttach = true;
		if (StuckActor != Instigator && StuckActor.DrawType == DT_Mesh)
			StuckActor.AttachToBone(Proj, StuckActor.GetClosestBone(LastHitLoc, Velocity, BoneDist));
		else
			Proj.SetBase(StuckActor);
	}
	
	if(M46 != None && M46.AddMine(Proj))
		Proj.SetManualMode(true);
	Proj.SetRotation(R);
	Proj.Velocity = vect(0,0,0);

	Destroy();
}

defaultproperties
{
     ModeIndex=1
     DetonateOn=DT_Impact
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=0.000000
     ImpactDamage=20
     ImpactDamageType=Class'BallisticProV55.DTM46GrenadeHit'
     ImpactManager=Class'BallisticProV55.IM_M46GrenadeImpact'
     TrailClass=Class'BallisticProV55.M50GrenadeTrail'
     TrailOffset=(X=-8.000000)
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     Speed=2700.000000
     MyDamageType=None
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.OA-AR.OA-AR_Grenade'
     DrawScale=0.450000
	 ModeIndex=1
}
