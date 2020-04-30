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

defaultproperties
{
}
