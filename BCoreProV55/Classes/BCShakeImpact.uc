//=============================================================================
// BCShakeImpact.
//
// Impact manager that has an extra effect, view shake.
// A junkwar addition
//
// RED!!! This is just a legacy place holder, view shake is now part of the ImpactManger itself...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BCShakeImpact extends BCImpactManager;
/*
// camera shakes //
var() vector ShakeRotMag;           // how far to rot view
var() vector ShakeRotRate;          // how fast to rot view
var() float  ShakeRotTime;          // how much time to rot the instigator's view
var() vector ShakeOffsetMag;        // max view offset vertically
var() vector ShakeOffsetRate;       // how fast to offset view vertically
var() float  ShakeOffsetTime;       // how much time to offset view
var() float	 ShakeRadius;			// Shake the view of players withing this radius
var() bool	 bShakeOnWaterHit;		// Do viewshake when hit surface is water

simulated function SpawnEffects (int HitSurfaceType, vector Norm, optional byte Flags)
{
	local PlayerController PC;
	local float Dist, ScaleFactor;

	super.SpawnEffects (HitSurfaceType, Norm, Flags);

	if (Level.NetMode == NM_DedicatedServer)
		return;
	if (!bShakeOnWaterHit && HitSurfaceType == 9) // EST_Water
		return;

	PC = level.GetLocalPlayerController();
	if ( PC != None && PC.ViewTarget != None)
	{
		Dist = VSize(Location - PC.ViewTarget.Location);
		if (Dist < ShakeRadius)
		{
			if (Dist < ShakeRadius/3)
				ScaleFactor = 1.0;
			else
				ScaleFactor = (ShakeRadius - Dist) / ShakeRadius;
			PC.ShakeView(ShakeRotMag*ScaleFactor, ShakeRotRate, ShakeRotTime, ShakeOffsetMag*ScaleFactor, ShakeOffsetRate, ShakeOffsetTime);
		}
	}
}
*/

defaultproperties
{
     ShakeRotMag=(X=256.000000,Y=256.000000,Z=256.000000)
     ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     ShakeRotTime=6.000000
     ShakeOffsetMag=(X=10.000000,Y=10.000000,Z=20.000000)
     ShakeOffsetRate=(X=200.000000,Y=200.000000,Z=200.000000)
     ShakeOffsetTime=6.000000
     ShakeRadius=384.000000
}
