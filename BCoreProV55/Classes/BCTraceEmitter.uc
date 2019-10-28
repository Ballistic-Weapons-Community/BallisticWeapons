//=============================================================================
// BCTraceEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BCTraceEmitter extends BallisticEmitter;

var() float	StopShortDist;

simulated function Initialize(float Distance, optional float Power)
{
	if (Emitters[0] != None)
	{
		Emitters[0].LifeTimeRange.Min = FMax(0, Distance-StopShortDist) / Emitters[0].StartVelocityRange.X.Max;
		Emitters[0].LifeTimeRange.Max = FMax(0, Distance-StopShortDist) / Emitters[0].StartVelocityRange.X.Min;
	}
}

defaultproperties
{
     StopShortDist=128.000000
     AutoDestroy=True
}
