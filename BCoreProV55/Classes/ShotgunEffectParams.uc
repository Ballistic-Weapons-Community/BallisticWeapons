class ShotgunEffectParams extends InstantEffectParams;

var() int						TraceCount;		// Number of fire traces to use
var() class<Emitter>			TracerClass;	// Type of tracer to use
var() class<BCImpactManager>	ImpactManager;	// Impact manager to use for ListenServer and StandAlone impacts
var() bool						bDoWaterSplash;	// splash when hitting water, duh...
var() int                       MaxHits;        // Cannot hit a single target more times than this
var() float						HipSpreadFactor;//Spread increases by this amount when shooting from the hip

//Accessor for stats
function FireModeStats GetStats() 
{
	local FireModeStats FS;

    FS = Super.GetStats();
	
	FS.DamageInt = Damage * TraceCount;

    if (RangeAtten < 1f)
	    FS.Damage = String(FS.DamageInt) @ "-" @ String(int(FS.DamageInt * RangeAtten));
    else 
        FS.Damage = String(FS.DamageInt);

	return FS;
}

defaultproperties
{
     HipSpreadFactor=2.00000
     ShotTypeString="shots"
}