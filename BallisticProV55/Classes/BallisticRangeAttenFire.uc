class BallisticRangeAttenFire extends BallisticProInstantFire;

var() float CutOffDistance;
var() float CutOffStartRange;

simulated function ApplyFireEffectParams(FireEffectParams params)
{
    local InstantEffectParams effect_params;

    super.ApplyFireEffectParams(params);

    effect_params = InstantEffectParams(params);

    CutOffStartRange = effect_params.DecayRange.Min;

    // handle params
    if (effect_params.DecayRange.Max > 0)
        CutOffDistance = effect_params.DecayRange.Max;
    else 
        CutOffDistance = effect_params.TraceRange.Max - effect_params.DecayRange.Min;
}

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

    if (default.RangeAtten < 1f)
	    FS.Damage 		= FS.DamageInt @ "-" @ int(default.Damage * default.RangeAtten);
    else 
        FS.Damage = String(FS.DamageInt);

    FS.HeadMult = default.HeadMult;
    FS.LimbMult = default.LimbMult;

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

	FS.RangeOpt = "Max damage:"@ opt_range @"metres";
    FS.RangeDecayed = "Min damage:"@ decay_range @"metres";
    FS.RangeMax = "Max range:"@ max_range @"metres";
	
	return FS;
}

defaultproperties
{
}
