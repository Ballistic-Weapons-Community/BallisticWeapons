//=============================================================================
// BloodMan_Exploded.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodMan_Exploded extends BloodMan_Bullet;

static function class<Projector> GetWallSplat(class<BallisticBloodSet> BS, optional name Bone)
{
	return BS.default.ExplodeSplat;
}
static function class<Actor> GetBloodEffect(class<BallisticBloodSet> BS, optional name Bone)
{
	return BS.default.ExplodeEffect;
}

simulated function bool CanSpawnStuff()
{
	if (!bUseBloodExplodes || class'GameInfo'.static.UseLowGore())
		return false;
	return true;
}

simulated function SpawnEffects ()
{
	local Actor T;
	local vector HitLoc, HitNorm, End;

	if (Level.NetMode == NM_DedicatedServer || !CanSpawnStuff())
		return;

	End = Location + Vector(Rotation)*default.SplatRange;
	T = Trace(HitLoc, HitNorm, End, Location, false);
	if (T != None && T.bWorldGeometry)
		Spawn(GetWallSplat(BloodSet),,,HitLoc, Rotator(-HitNorm));

	T = Trace(HitLoc, HitNorm, Location - vect(0,0,1)*default.SplatRange, Location, false);
	if (T != None && T.bWorldGeometry)
		Spawn(GetWallSplat(BloodSet),,,HitLoc, Rot(-16384,0,0));

	Spawn(GetBloodEffect(BloodSet),,,Location, Rotation);
}

static function DoBloodHit(Pawn Victim, name Bone, vector HitLoc, vector HitRay, int Damage)
{

}

static function DoSeverStump(Pawn Victim, name Bone, vector HitRay, float Damage)
{
	local Actor T;
	local vector TraceHit, TraceNorm;
	local class<BallisticBloodSet> BS;

	super.DoSeverStump(Victim, Bone, HitRay, Damage);

	if (Victim.Level.NetMode == NM_DedicatedServer || class'GameInfo'.static.UseLowGore() || (Bone != 'spine' && Bone != 'pelvis'))
		return;
	BS = GetBloodSet(Victim);
	if (BS == None)
		return;

	// Spawn a decal within splat range and in the direction of the HitRay
	if (default.bUseBloodExplodes)
	{
		T = Victim.Trace(TraceHit, TraceNorm, Victim.Location + HitRay * default.SplatRange, Victim.Location, false);
		if (T != None && T.bWorldGeometry)
			Victim.Spawn(GetWallSplat(BS),,,TraceHit, Rotator(-TraceNorm));

		T = Victim.Trace(TraceHit, TraceNorm, Victim.Location - vect(0,0,1)*default.SplatRange, Victim.Location, false);
		if (T != None && T.bWorldGeometry)
			Victim.Spawn(GetWallSplat(BS),,,TraceHit, Rot(-16384,0,0));
	}
	// Spawn an effect in the direction of the HitRay
	if (default.bUseBloodEffects)
		Victim.Spawn(GetBloodEffect(BS),Victim,,Victim.Location, Rotator(HitRay));
}

defaultproperties
{
     SplatRange=400.000000
}
