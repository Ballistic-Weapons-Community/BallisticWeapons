class ShotgunEffectParams extends InstantEffectParams;

var() int						TraceCount;		// Number of fire traces to use
var() class<Emitter>			TracerClass;	// Type of tracer to use
var() class<BCImpactManager>	ImpactManager;	// Impact manager to use for ListenServer and StandAlone impacts
var() bool						bDoWaterSplash;	// splash when hitting water, duh...
var() int                       MaxHits;        // Cannot hit a single target more times than this

defaultproperties
{

}