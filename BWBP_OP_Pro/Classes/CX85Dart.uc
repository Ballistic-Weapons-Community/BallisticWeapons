class CX85Dart extends BallisticProjectile;

var Actor StuckActor;
var bool bPlaced;

var CX85AssaultWeapon Master;

simulated function bool Impact(Actor Other, vector HitLocation )
{
	if(Pawn(Other) != None)
	{
		StuckActor = Other;
		HitActor = Other;
		Explode(HitLocation, Normal(HitLocation-Other.Location));
        return true;
	}

    return false;
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local Vector	        LastHitLoc, LastHitNorm;
	local Rotator 	        R;
	local CX85DartDirect    Proj, MasterProj;
	local float             BoneDist;

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

	if(Role < ROLE_Authority || Pawn(StuckActor) == None || Master == None)
	{
		Destroy();
		Return;
	}
	
	R = Rotation;
	LastHitLoc = Location;
	LastHitNorm = Normal(Velocity);
	R = Rotator(LastHitNorm);
	R.Roll = Rand(65536);
	
	//If we already have a dart attached, it becomes a slave of the existing one.
	foreach StuckActor.BasedActors(class'CX85DartDirect', Proj)
	{
		if (Proj.Instigator == Instigator)
		{
			MasterProj = Proj;
			break;
		}
	}

	if (MasterProj != None)
	{
		Proj = Spawn (class'CX85DartDirect',MasterProj,, LastHitLoc, R);
		Proj.Tracked = Pawn(StuckActor);
	}
	else
	{
		Master.bPendingReceive=True; //Weapon needs to wait for acknowledgement for the leader dart, which is used clientside for tracking.
		Proj = Spawn (class'CX85DartDirect',Master,, LastHitLoc, R);
		Proj.Tracked = Pawn(StuckActor);
		Proj.SetMaster();
	}

	Proj.Instigator = Instigator;
	Proj.SetPhysics(PHYS_None);
	Proj.bHardAttach = true;
	if (StuckActor != Instigator && StuckActor.DrawType == DT_Mesh)
		StuckActor.AttachToBone(Proj, StuckActor.GetClosestBone(LastHitLoc, Velocity, BoneDist));
	else
		Proj.SetBase(StuckActor);

	Proj.SetRotation(R);
	Proj.Velocity = vect(0,0,0);

	Destroy();
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
     TrailClass=Class'BallisticProV55.PineappleTrail'
     MyRadiusDamageType=Class'BWBP_OP_Pro.DTCX85Dart'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=0.000000
     MotionBlurFactor=0.000000
     MotionBlurTime=0.000000
	 Speed=35000.000000
	 MaxSpeed=100000.000000
	 AccelSpeed=100000.000000
     Damage=3.000000
     MyDamageType=Class'BWBP_OP_Pro.DTCX85Dart'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.OA-SMG.OA-SMG_Dart'
     LifeSpan=1.500000
     bIgnoreTerminalVelocity=True
}
