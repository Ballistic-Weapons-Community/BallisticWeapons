//=============================================================================
// IM_F2000Wave.
//
// ImpactManager subclass for mini blue organ liquifying waves of death
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_F2000Wave extends BCImpactManager;

var() float		SurfaceRange;
var() float		MinFluidDepth;

simulated function SpawnEffects (int HitSurfaceType, vector Norm, optional byte Flags)
{
	local vector WLoc, WNorm;
	local bool bHitWater;
	local float ImpactDepth;
	local Projector P;

	if (Level.NetMode == NM_DedicatedServer)
		return;
		
	if (Flags == 1)
		HitEffects[0]=Class'IE_F2000ShockwaveRed';
	else HitEffects[0]=Class'IE_F2000Shockwave';

	if (PhysicsVolume.bWaterVolume)
	{
		bHitWater = !PhysicsVolume.TraceThisActor(WLoc, WNorm, Location, Location + vect(0,0,1)*SurfaceRange);
		ImpactDepth = WLoc.Z - Location.Z;
		if (ImpactDepth > MinFluidDepth)
		{
			if (bHitWater && ImpactDepth < SurfaceRange)
				Spawn (Class'IE_WaterSurfaceBlast', Owner,, WLoc);
			HitEffects[HitSurfaceType]=Class'IE_UnderWaterExplosion';
			HitSounds[HitSurfaceType]=SoundGroup'BW_Core_WeaponSound.Explosions.Explode-UW';
		}
	}
	
	HitSoundPitch = 0.8 + (0.4 * FRand());

	if (HitSounds.Length > 0)
	{
		if (HitSurfaceType >= HitSounds.Length)
			PlaySound(HitSounds[0], SLOT_Interact, HitSoundVolume,,HitSoundRadius,HitSoundPitch,true);
		else if (HitSounds[HitSurfaceType] != None)
			PlaySound(HitSounds[HitSurfaceType], SLOT_Interact, HitSoundVolume,,HitSoundRadius,HitSoundPitch,true);
	}
	if (HitEffects.Length > 0)
	{
		if (HitSurfaceType >= HitEffects.Length)
			Spawn (HitEffects[0], Owner,, Location+EffectBackOff*Norm, Rotation);
		else if (HitEffects[HitSurfaceType] != None)
			Spawn (HitEffects[HitSurfaceType], Owner,, Location, Rotation);
	}
	if (HitDecals.Length > 0)
	{
		if (HitSurfaceType >= HitDecals.Length)
			P = Spawn (HitDecals[0], Owner,, Location, Rotator(-Norm));
		else if (HitDecals[HitSurfaceType] != None)
			P = Spawn (HitDecals[HitSurfaceType], Owner,, Location, Rotator(-Norm));
		if (BallisticDecal(P) != None && BallisticDecal(P).bWaitForInit)
		{
			P.SetDrawScale(P.DrawScale*DecalScale);
			BallisticDecal(P).InitDecal();
		}
	}

	if (ShakeRadius > 0 && (HitSurfaceType != 9 || bShakeOnWaterHit))
		DoViewShake();
}

defaultproperties
{
     SurfaceRange=684.000000
     MinFluidDepth=128.000000
     HitEffects(0)=Class'BWBP_SKC_Pro.IE_F2000Shockwave'
     HitSounds(0)=Sound'BWBP_SKC_Sounds.MARS.F2000-Pulse'
     HitSoundVolume=3.000000
     HitSoundRadius=900.000000
     EffectBackOff=96.000000
}
