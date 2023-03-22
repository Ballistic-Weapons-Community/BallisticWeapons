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

    //Log("GetTraceInfo: Start: " $ TI.Start $ " End: " $ TI.End);

	TI.HitActor = tracer.Trace(TI.HitLocation, TI.HitNormal, TI.End, TI.Start, bTraceActors, TI.Extent, TI.HitMaterial);

	if (TI.HitActor == None)
		TI.HitLocation = TI.End;

    //Log("GetTraceInfo: Hit: " $ TI.HitActor $ " TI.HitLocation: " $ TI.HitLocation);

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
static function bool GoThroughWall(Actor source, Actor Instigator, vector EntryLocation, vector EntryNormal, float MaxWallDepth, vector Dir, out vector ExitLocation, out vector ExitNormal, optional out Material ExitMat)
{
	local TraceInfo TBack, TFore;
	local float CheckDist;
	local Vector Test, HLoc, HNorm;
	local Pawn A;

    // Log("GoThroughWall: Max wall depth "$MaxWallDepth);

	if (MaxWallDepth <= 0)
		return false;

	// First, try shortcut method...
	foreach source.CollidingActors(class'Pawn', A, MaxWallDepth, EntryLocation)
	{
		if (A == None || A == Instigator || A.TraceThisActor(HLoc, HNorm, EntryLocation + Dir * MaxWallDepth, EntryLocation))
			continue;
            
		TBack = GetTraceInfo(source, EntryLocation, HLoc, false);

		if (TBack.HitActor != None)
		{
			if (VSize(TBack.HitLocation - EntryLocation) <= MaxWallDepth)
			{
				ExitLocation = TBack.HitLocation + Dir * 1;
				ExitNormal = TBack.HitNormal;
				ExitMat = TBack.HitMaterial;

                //Log("GoThroughWall: Actor 1: TBack.HitLocation: "$TBack.HitLocation$" ExitLocation: "$ExitLocation$" ExitNormal: "$ExitNormal);
				return true;
			}
		}
		else
		{
			ExitLocation = EntryLocation + Dir * 48;
			ExitNormal = Dir;
            //Log("GoThroughWall: Actor 2: ExitLocation: "$ExitLocation$" ExitNormal: "$ExitNormal);
			return true;
		}
	}

	// Start testing as far in as possible, then move closer until we're back at the start
	for ( CheckDist = MaxWallDepth; CheckDist > 0; CheckDist -= MaxWallDepth / 4)
	{
		Test = EntryLocation + Dir * CheckDist;

		// Test point is in a solid, move closer
		if (PointInSolid(source, Test))
			continue;
			
		// Found space, check to make sure its open space and not just inside a static

		// First, trace back and see what's there...
		TBack = GetTraceInfo(source, Test-Dir*CheckDist, Test, true);
		// We're probably in thick terrain, otherwise we'd have found something
		if (TBack.HitActor == None)
		{
			//Log("GoThroughWall: Hit nothing");
			return false;	
		}

		// A non world actor! Must be in valid space
		if (!TBack.HitActor.bWorldGeometry && Mover(TBack.HitActor) == None)	
		{
			ExitLocation = TBack.HitLocation - Dir * TBack.HitActor.CollisionRadius;
			ExitNormal = Dir;
			//Log("GoThroughWall: Trace hit non-world Actor: ExitLocation: "$ExitLocation$" ExitNormal: "$ExitNormal);
			return true;
		}

		// Found the front face of a surface(normal parallel to Fire Dir, Opposite to Back Trace dir)
		if (VSize(TBack.HitLocation - TBack.Start) > 0.5 && IsBackFace(TBack.HitNormal, Dir))	
		{
			ExitLocation = TBack.HitLocation + Dir * 1;
			ExitNormal = TBack.HitNormal;
			ExitMat = TBack.HitMaterial;
			//Log("GoThroughWall: Front face of surface: ExitLocation: "$ExitLocation$" ExitNormal: "$ExitNormal);
			return true;
		}

		// Found a back face.
		// Trace forward(along fire Dir) and see if we're inside a mesh or if the surface was just a plane
		TFore = GetTraceInfo(source, Test+Dir*2000, Test, true);
		if (VSize(TFore.HitLocation - TFore.Start) > 0.5)	
		{
			// Hit nothing, we're probably not inside a mesh (hopefully)
			if (TFore.HitActor == None)	
			{
				ExitLocation = TBack.HitLocation + Dir * 1;
				ExitNormal = -TBack.HitNormal;
				ExitMat = TBack.HitMaterial;
				//Log("GoThroughWall: Back face (empty space): ExitLocation: "$ExitLocation$" ExitNormal: "$ExitNormal);
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
				//Log("GoThroughWall: Plane: ExitLocation: "$ExitLocation$" ExitNormal: "$ExitNormal);
				return true;
			}
		}

        return false;
	}

	return false;
}