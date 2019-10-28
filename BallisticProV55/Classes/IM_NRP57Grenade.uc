//=============================================================================
// IM_NRP57Grenade.
//
// ImpactManager subclass for NRP57 Grenade Explosions
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_NRP57Grenade extends BCImpactManager;

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
			HitEffects[0]=Class'IE_UnderWaterExplosion';
			HitSounds[0]=SoundGroup'BallisticSounds2.Explosions.Explode-UW';
		}
	}
	super.SpawnEffects(HitSurfaceType, Norm, Flags);
}

defaultproperties
{
     SurfaceRange=384.000000
     MinFluidDepth=128.000000
     HitEffects(0)=Class'BallisticProV55.IE_NRP57Explosion'
     HitDecals(0)=Class'BallisticProV55.AD_Explosion'
     HitSounds(0)=SoundGroup'BallisticSounds2.Explosions.Explode-Small'
     HitSoundVolume=1.000000
     HitSoundRadius=1024.000000
     EffectBackOff=64.000000
}
