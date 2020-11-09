class WallPenetrationUtil extends Actor;

struct TraceInfo					                            // This holds info about a trace
{
	var() Vector 	Start, End, HitNormal, HitLocation, Extent;
	var() Material	HitMaterial;
	var() Actor		HitActor;
};

// Returns true if the trace hit the back of a surface, i.e. the surface normal and trace normal
// are pointed in the same direction...
static function bool IsBackface(vector Norm, vector Dir)	
{	
    return (Normal(Dir) Dot Normal(Norm) > 0.0);	
}

// Returns true if point is in a solid, i.e. FastTrace() fails at the point
static function bool PointInSolid(Actor tracer, vector V) 
{	
    return !tracer.FastTrace(V, V+vect(1,1,1));		
}

static function TraceInfo GetTraceInfo (Actor tracer, Vector End, Vector Start, optional bool bTraceActors, optional Vector Extent)
{
	local TraceInfo TI;

	TI.Start = Start;	
    TI.End = End;	
    TI.Extent = Extent;

	TI.HitActor = tracer.Trace(TI.HitLocation, TI.HitNormal, TI.End, TI.Start, bTraceActors, TI.Extent, TI.HitMaterial);

	if (TI.HitActor == None)
		TI.HitLocation = TI.End;

	return TI;
}

// Finds the surface type and returns returns SurfaceScale() for that surface...
static function int GetSurfaceType(Actor Other, Material HitMaterial)
{
	local int Surf;
	if (Vehicle(Other) != None)
		Surf = 3;
	else if (HitMaterial == None)
		Surf = int(Other.SurfaceType);
	else
		Surf = int(HitMaterial.SurfaceType);
	return Surf;
}

//Fixme handle BallisticDecorations
static function bool GoThroughWall(Actor source, Actor Instigator, vector FirstLoc, vector FirstNorm, float MaxWallDepth, vector Dir, out vector ExitLocation, out vector ExitNormal, optional out Material ExitMat)
{
	local TraceInfo TBack, TFore;
	local float CheckDist;
	local Vector Test, HLoc; //, HNorm;
	local Pawn A;

    //Log("GoThroughWall: Src "$source$" Instigator "$Instigator$" FirstLoc "$FirstLoc$" FirstNorm "$FirstNorm$" MaxWallDepth "$MaxWallDepth$" Dir "$Dir);

	if (MaxWallDepth <= 0)
		return false;

	// First, try shortcut method...
	foreach source.CollidingActors(class'Pawn', A, MaxWallDepth, FirstLoc)
	{
		if (A == None || A == Instigator || A.FastTrace(source.Location, A.Location)) // FIXME: Changed from TraceThisActor
			continue;
            
		TBack = GetTraceInfo(source, FirstLoc, HLoc, false);

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
	for (CheckDist = MaxWallDepth; CheckDist > 0; CheckDist -= 48)
	{
		Test = FirstLoc + Dir * CheckDist;
		// Test point is in a solid, try again
		if (PointInSolid(source, Test))
			continue;
		// Found space, check to make sure its open space and not just inside a static
		else
		{
			// First, Trace back and see whats there...
			TBack = GetTraceInfo(source, Test-Dir*CheckDist, Test, true);
			// We're probably in thick terrain, otherwise we'd have found something
			if (TBack.HitActor == None)
            {
				return false;	
            }

			// A non world actor! Must be in valid space
			if (!TBack.HitActor.bWorldGeometry && Mover(TBack.HitActor) == None)	
            {
				ExitLocation = TBack.HitLocation - Dir * TBack.HitActor.CollisionRadius;
				ExitNormal = Dir;
				return true;
			}
			// Found the front face of a surface(normal parallel to Fire Dir, Opposite to Back Trace dir)
			if (VSize(TBack.HitLocation - TBack.Start) > 0.5 && IsbackFace(TBack.HitNormal, Dir))	
            {
				ExitLocation = TBack.HitLocation + Dir * 1;
				ExitNormal = TBack.HitNormal;
				ExitMat = TBack.HitMaterial;
				return true;
			}
			// Found a back face,
			else
            {	// Trace forward(along fire Dir) and see if we're inside a mesh or if the surface was just a plane
				TFore = GetTraceInfo(source, Test+Dir*2000, Test, true);
				if (VSize(TFore.HitLocation - TFore.Start) > 0.5)	
                {
					// Hit nothing, we're probably not inside a mesh (hopefully)
					if (TFore.HitActor == None)	
                    {
						ExitLocation = TBack.HitLocation + Dir * 1;
						ExitNormal = -TBack.HitNormal;
						ExitMat = TBack.HitMaterial;
						return true;
					}
					// Found backface. Looks like its a mesh bigger than MaxWallDepth
					if (IsBackFace(TFore.HitNormal, Dir))
						return false;
					// Hit a front face...
					else	
                    {
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