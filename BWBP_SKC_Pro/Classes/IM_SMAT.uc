//=============================================================================
// IM_RPG.
//
// ImpactManager subclass for G5 Rockets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_SMAT extends BCImpactManager;

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
				Spawn (Class'BallisticProV55.IE_WaterSurfaceBlast', Owner,, WLoc);
			HitEffects[HitSurfaceType]=Class'BallisticProV55.IE_UnderWaterExplosion';
			HitSounds[HitSurfaceType]=SoundGroup'BW_Core_WeaponSound.Explosions.Explode-UW';
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
     HitEffects(0)=Class'BallisticProV55.IE_RocketExplosion'
     HitEffects(1)=Class'BallisticProV55.IE_RocketExplosion'
     HitEffects(2)=Class'BallisticProV55.IE_HAMRExplosionDirt'
     HitEffects(3)=Class'BallisticProV55.IE_RocketExplosion'
     HitEffects(4)=Class'BallisticProV55.IE_HAMRExplosionDirt'
     HitEffects(5)=Class'BallisticProV55.IE_HAMRExplosionDirt'
     HitEffects(6)=Class'BallisticProV55.IE_RocketExplosion'
     HitEffects(7)=Class'BallisticProV55.IE_RocketExplosion'
     HitEffects(8)=Class'BallisticProV55.IE_HAMRExplosion'
     HitEffects(9)=Class'BallisticProV55.IE_HAMRExplosionDirt'
     HitEffects(10)=Class'BallisticProV55.IE_RocketExplosion'
     HitDecals(0)=Class'BallisticProV55.AD_Explosion'
     HitSounds(0)=Sound'BWBP_SKC_Sounds.SMAA.SMAT-Explosion'
     HitSoundVolume=1.000000
     HitSoundRadius=1024.000000
     EffectBackOff=96.000000
}
