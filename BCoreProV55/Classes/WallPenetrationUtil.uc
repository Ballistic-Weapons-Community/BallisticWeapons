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

// Returns true if point is in a solid, i.e. FastTrace() fails at the point. A line that starts in BSP solid is stopped at
// once however short it is; one this short does not reach a surface beside the point
static function bool PointInSolid(Actor tracer, vector V) 
{	
    return !tracer.FastTrace(V, V+vect(0.05,0.05,0.05));		
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

// Where the surface is that a trace along Dir hit at HitLocation. The engine puts a hit in front of the surface it found,
// along the trace: 4 units for a static mesh met by a long trace, half a unit for BSP and terrain. A second trace over 5
// units from just in front of the hit is pulled back half a unit on any of these, so that one says where the surface is
static function vector OnSurface(Actor tracer, vector HitLocation, vector Dir)
{
	local vector HL, HN;

	if (tracer.Trace(HL, HN, HitLocation + Dir * 4.5, HitLocation - Dir * 0.5, false) == None)
		return HitLocation;
	return HL + Dir * 0.5;
}

// What point Test along the shot is, for a wall the shot entered at Entry (on its surface):
// 0 inside that wall, or in something that cannot be read (under terrain, right on a surface)
// 1 out of it, behind the rear face at Exit
// 2 inside something further on, whose front face is at Front
// Closed holds what was found out about the wall itself: 0 not yet known, 1 a closed solid, 2 a sheet with no thickness
static function int ProbeWallPoint(Actor source, vector Entry, vector Test, vector Dir, out vector Exit, out vector ExitNormal, out Material ExitMat, out vector Front, out byte Closed)
{
	local TraceInfo TBack, TFore;
	local vector Surface;

	// in BSP solid (a static mesh's simple collision hull answers the same)
	if (PointInSolid(source, Test))
		return 0;

	TBack = GetTraceInfo(source, Entry - Dir, Test, false);
	if (TBack.HitActor == None)
		return 0;

	// The hit is pulled back toward the point, by as much as a tenth of the trace's length (all the way to the point when
	// the face is that close): where the face is comes from a short trace. A point right on it is left to the next one
	Surface = OnSurface(source, TBack.HitLocation, -Dir);
	if ((Test - Surface) dot Dir < 0.1)
		return 0;

	// a face turned away from the shooter, seen from behind it: a rear face, and the point is out
	if (IsBackFace(TBack.HitNormal, Dir))
	{
		Exit = Surface;
		ExitNormal = TBack.HitNormal;
		ExitMat = TBack.HitMaterial;
		return 1;
	}

	// a face turned toward the shooter. One past the entry is the front of something further on, and the point is in it
	Front = Surface;
	if ((Front - Entry) dot Dir > 1)
		return 2;

	// The entry face itself, from behind: the point is inside a closed wall, or behind a sheet with no thickness. A trace
	// on along the shot tells them apart (once): from inside a closed wall it meets that wall's rear face. It starts a
	// little short of the point, which a line starting right on a face would not see
	if (Closed == 0)
	{
		TFore = GetTraceInfo(source, Test + Dir * 2000, Test - Dir * 0.5, false);
		if (TFore.HitActor != None && IsBackFace(TFore.HitNormal, Dir))
			Closed = 1;
		else
			Closed = 2;
	}
	if (Closed == 1)
		return 0;
	Exit = Front;
	ExitNormal = -TBack.HitNormal;
	ExitMat = TBack.HitMaterial;
	return 1;
}

// Where a shot that hit a wall at EntryLocation (a trace's hit, so a little in front of the surface) comes out of it, at
// most MaxWallDepth past the surface. Points along the shot are tried from the entry outward, so the exit found is that of
// the first wall: whatever stands behind it, another wall or an actor, is met by the shot's next trace. Only world
// geometry is traced. Two walls closer together than one step (4 units, more for a deep search) count as one.
// WallDepth is how thick the wall is from surface to surface, what going through it costs.
static function bool GoThroughWall(Actor source, Actor Instigator, vector EntryLocation, vector EntryNormal, float MaxWallDepth, vector Dir, out vector ExitLocation, out vector ExitNormal, optional out Material ExitMat, optional out float WallDepth)
{
	local vector Entry, Test, Exit, N, Front;
	local Material M;
	local float Step, CheckDist;
	local byte Closed;
	local int Found;
	local bool bLast;

	if (MaxWallDepth <= 0)
		return false;

	// The tracer can be gone by the time we get here: a projectile destroyed by something in its own blast, a
	// weapon whose owner the shot killed. The iterator below must not be run on an actor that is gone: the script
	// VM skips the call but then runs the loop's end offset as code ("Unknown code token").
	if (source == None)
		return false;

	Dir = Normal(Dir);
	Entry = OnSurface(source, EntryLocation, Dir);
	Step = FMax(4, MaxWallDepth / 32);

	for (CheckDist = Step; !bLast; CheckDist += Step)
	{
		if (CheckDist >= MaxWallDepth)
		{
			CheckDist = MaxWallDepth;
			bLast = true;
		}
		Test = Entry + Dir * CheckDist;
		Found = ProbeWallPoint(source, Entry, Test, Dir, Exit, N, M, Front, Closed);
		// in something further on: the way out of the wall is in the gap before it
		if (Found == 2)
		{
			Found = ProbeWallPoint(source, Entry, Front - Dir, Dir, Exit, N, M, Front, Closed);
			if (Found == 2)
				Found = 0;
		}
		if (Found != 1)
			continue;

		WallDepth = FMax(0, (Exit - Entry) dot Dir);
		if (WallDepth > MaxWallDepth)
			return false;
		ExitLocation = Exit + Dir;
		ExitNormal = N;
		ExitMat = M;
		return true;
	}

	return false;
}
