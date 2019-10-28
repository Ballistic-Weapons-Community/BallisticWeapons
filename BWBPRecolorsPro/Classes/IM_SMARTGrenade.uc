//=============================================================================
// IM_SMARTGrenade.
//
// ImpactManager subclass for Longhorn primary grenades
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_SMARTGrenade extends BCImpactManager;

var() float		SurfaceRange;
var() float		MinFluidDepth;

simulated function SpawnEffects (int HitSurfaceType, vector Norm, optional byte Flags)
{
	local vector WLoc, WNorm;
	local bool bHitWater;
	local float ImpactDepth;

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (PhysicsVolume.bWaterVolume)
	{
		bHitWater = !PhysicsVolume.TraceThisActor(WLoc, WNorm, Location, Location + vect(0,0,1)*SurfaceRange);
		ImpactDepth = WLoc.Z - Location.Z;
		if (ImpactDepth > MinFluidDepth)
		{
			if (bHitWater && ImpactDepth < SurfaceRange)
				Spawn (Class'IE_WaterSurfaceBlast', Owner,, WLoc);
			HitEffects[HitSurfaceType]=Class'IE_UnderWaterExplosion';
			HitSounds[HitSurfaceType]=SoundGroup'BallisticSounds2.Explosions.Explode-UW';
		}
	}
	super.SpawnEffects(HitSurfaceType, Norm, Flags);
}
/*
	EST_Default,	0
	EST_Rock,		1
	EST_Dirt,		2
	EST_Metal,		3
	EST_Wood,		4
	EST_Plant,		5
	EST_Flesh,		6
    EST_Ice,		7
    EST_Snow,		8
    EST_Water,		9
    EST_Glass,		10
*/

defaultproperties
{
     SurfaceRange=384.000000
     MinFluidDepth=128.000000
     HitEffects(0)=Class'BWBPRecolorsPro.IE_LongHornGrenade'
     HitDecals(0)=Class'BallisticProV55.AD_Explosion'
     HitSounds(0)=Sound'PackageSounds4ProExp.Longhorn.Longhorn-Expl'
     HitSoundVolume=1.000000
     HitSoundRadius=1024.000000
     EffectBackOff=96.000000
}
