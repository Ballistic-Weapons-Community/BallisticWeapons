class BallisticRangeAttenFire extends BallisticProInstantFire;

var() float CutOffDistance;
var() float CutOffStartRange;

static function float GetRangeAttenFactor(vector start, vector end, int cut_off_start, int cut_off_dist, float range_atten)
{
	local float dist;

	dist = VSize(end - start);

	if (dist <= cut_off_start)
		return 1.0f;

	if (dist >= cut_off_start + cut_off_dist)
		return range_atten;

	return Lerp( (dist - cut_off_start) / cut_off_dist, 1.0f, range_atten);
}

function float ResolveDamageFactors(Actor Other, vector TraceStart, vector HitLocation, int PenetrateCount, int WallCount, int WallPenForce, Vector WaterHitLocation)
{
	local float  DamageFactor;

	DamageFactor = 1;

	if (WaterRangeAtten < 1.0 && WaterHitLocation != vect(0,0,0))
		DamageFactor *= GetRangeAttenFactor(TraceStart, HitLocation, CutOffStartRange, CutOffDistance, WaterRangeAtten);
	else if (RangeAtten != 1.0)
		DamageFactor *= GetRangeAttenFactor(TraceStart, HitLocation, CutOffStartRange, CutOffDistance, RangeAtten);
	
	if (PenetrateCount > 0)
		DamageFactor *= PDamageFactor * PenetrateCount;

	if (WallCount > 0 && WallPenetrationForce > 0)
	{
		DamageFactor *= WallPDamageFactor * WallCount;
		DamageFactor *= WallPenForce / WallPenetrationForce;
	}

	return DamageFactor;
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;

    local int opt_range, decay_range, max_range;
	
	FS.DamageInt 	= default.Damage;
	FS.Damage 		= String(FS.DamageInt);
	FS.DPS 			= FS.DamageInt / default.FireRate;
	FS.TTK 			= default.FireRate * (Ceil(175/FS.DamageInt) - 1);

	if (default.FireRate < 0.5)
		FS.RPM = String(int((1 / default.FireRate) * 60))@default.ShotTypeString$"/min";
	else 
		FS.RPM 	= 1/default.FireRate@"times/second";
		
	FS.RPShot 		= default.FireRecoil;
	FS.RPS 			= default.FireRecoil / default.FireRate;
	FS.FCPShot 		= default.FireChaos;
	FS.FCPS 		= default.FireChaos / default.FireRate;

    opt_range =         default.CutOffStartRange / 52.5f;
    decay_range =     (default.CutOffStartRange + default.CutOffDistance) / 52.5f;
    max_range =         default.TraceRange.Max / 52.5f;

	FS.Range = "Opt:"@ opt_range @"m, Dcy:"@ decay_range @"m, Max:"@ max_range @"m";
	
	return FS;
}

defaultproperties
{
}
