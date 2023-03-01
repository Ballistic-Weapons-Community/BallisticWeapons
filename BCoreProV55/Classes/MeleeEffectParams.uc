class MeleeEffectParams extends InstantEffectParams;

var() float         ChargeDamageBonusFactor;
var() float         FlankDamageMult;
var() float         BackDamageMult;
var() float         Fatigue;


//Accessor for stats
// sigh
function FireModeStats GetStats() 
{
	local FireModeStats FS;

    FS = Super(FireEffectParams).GetStats();
	
	FS.DamageInt = default.Damage;

	if (ChargeDamageBonusFactor > 1f)
		FS.Damage = String(FS.DamageInt)@"-"@String(int(FS.DamageInt * ChargeDamageBonusFactor));
	else
        FS.Damage = String(FS.DamageInt);

	FS.RangeOpt = "Max range: "@(default.TraceRange.Max / 52.5)@"metres";
	
	return FS;
}

defaultproperties
{
    TraceRange=(Min=145.000000,Max=145.000000)
    Damage=50.000000
    HeadMult=1f 
    LimbMult=1f
    RangeAtten=1.0f
    ChargeDamageBonusFactor=1f
    FlankDamageMult=1.15f
    BackDamageMult=1.3f
    PenetrationEnergy=0
    PDamageFactor=0.500000
    RunningSpeedThreshold=1000.000000
    ShotTypeString="attacks"
}