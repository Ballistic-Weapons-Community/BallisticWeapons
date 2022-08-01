class PD97TrackerProj extends BallisticGrenade;

var PD97Bloodhound Master;
var bool bPlaced;
var Actor StuckActor;

function DoDamage(Actor Other, vector HitLocation)
{
	if (Pawn(Other) != None && Master != None && Level.TimeSeconds - Pawn(Other).SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime)
	{
		Master.GotTarget(Pawn(Other));
		//if (Pawn(Other).Controller != None && InstigatorController != None && !Pawn(Other).Controller.SameTeamAs(InstigatorController))
			
	}
	Super.DoDamage(Other, HitLocation);
}

simulated function ApplyImpactEffect(Actor Other, Vector HitLocation)
{
    if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

    if (PlayerImpactType == PIT_Detonate || DetonateOn == DT_Impact)
        class'BallisticDamageType'.static.GenericHurt (Other, Damage, Instigator, HitLocation, GetMomentumVector(Normal(Velocity)), ImpactDamageType);
    else 
        class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, GetMomentumVector(Normal(Velocity)), ImpactDamageType);
		
    DoDamage(Other, HitLocation);
}

simulated event ProcessTouch(Actor Other, vector HitLocation )
{
	Log("Master: "$Master);
	Log("Actor: "$Other);
	if (Other == Instigator && (!bCanHitOwner))
		return;
	if (Base != None)
		return;

	if(Pawn(Other) != None)
	{
		StuckActor = Other;
		HitActor = Other;
		Explode(HitLocation, Normal(HitLocation-Other.Location));
		class'BallisticDamageType'.static.GenericHurt(Other, ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
		if (Pawn(Other) != None && Master != None && Level.TimeSeconds - Pawn(Other).SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime)
		{
			Master.GotTarget(Pawn(Other));
			//if (Pawn(Other).Controller != None && InstigatorController != None && !Pawn(Other).Controller.SameTeamAs(InstigatorController))
				
		}
	}
	else
		Super.ProcessTouch(Other,HitLocation);
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
	local Rotator R;
	local Projectile Proj;
	local float BoneDist;

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

	if(Role != ROLE_Authority)
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
	if(StuckActor == None)
	{
		Proj = Spawn (class'PD97TrackerBeacon',,, LastHitLoc, R);
		Proj.Instigator = Instigator;
		Proj.bHardAttach = true;
		Proj.SetBase(LastTrace);
	}
	else
	{
		Proj = Spawn (class'PD97TrackerBeacon',,, LastHitLoc, R);
		Proj.Instigator = Instigator;
		Proj.SetPhysics(PHYS_None);
		Proj.bHardAttach = true;
		if (StuckActor != Instigator && StuckActor.DrawType == DT_Mesh)
			StuckActor.AttachToBone(Proj, StuckActor.GetClosestBone(LastHitLoc, Velocity, BoneDist));
		else
			Proj.SetBase(StuckActor);
	}
	Proj.SetRotation(R);
	Proj.Velocity = vect(0,0,0);

	Destroy();
}


defaultproperties
{
	ModeIndex=1
     ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
     //TrailClass=Class'BWBP_OP_Pro.PD97TrackerTrail'
     TrailClass=Class'BWBP_SKC_Pro.MGLNadeTrail'
     MyRadiusDamageType=Class'BWBP_OP_Pro.DTPD97Tazer'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ImpactDamageType=Class'BWBP_OP_Pro.DTPD97Tazer'
     ImpactDamage=15
     ShakeRadius=0.000000
     MotionBlurRadius=0.000000
     MotionBlurFactor=0.000000
     MotionBlurTime=0.000000
     Speed=10240.000000
     Damage=10.000000
     MyDamageType=Class'BWBP_OP_Pro.DTPD97Tazer'
     DrawType=DT_None
     StaticMesh=StaticMesh'BWBP_OP_Static.Bloodhound.BHTazerDart'
     LifeSpan=1.000000
     DrawScale=1.500000
     bIgnoreTerminalVelocity=True
}
