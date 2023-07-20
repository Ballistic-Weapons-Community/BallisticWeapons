//=============================================================================
// IM_RPG.
//
// ImpactManager subclass for small rpg rocketlets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_RGPX extends BCImpactManager;

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
			HitSounds[0]=SoundGroup'BW_Core_WeaponSound.Explosions.Explode-UW';
		}
	}
	super.SpawnEffects(HitSurfaceType, Norm, Flags);
}

defaultproperties
{
     SurfaceRange=256.000000
     MinFluidDepth=128.000000
     HitEffects(0)=Class'BWBP_JCF_Pro.IE_RGPXExplosion'
     HitDecals(0)=Class'BWBP_JCF_Pro.AD_RGPXExplosion'
     HitSounds(0)=SoundGroup'BW_Core_WeaponSound.MRL.MRL-Explode'
     HitSoundVolume=0.900000
     HitSoundRadius=386.000000
     EffectBackOff=96.000000
}
