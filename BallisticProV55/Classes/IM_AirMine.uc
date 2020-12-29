//=============================================================================
// IM_AirMine.
//
// ImpactManager subclass for Air Mines
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_AirMine extends BCImpactManager;

simulated function SpawnEffects (int HitSurfaceType, vector Norm, optional byte Flags)
{
	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (PhysicsVolume.bWaterVolume)
		HitSounds[0]=SoundGroup'BW_Core_WeaponSound.Explosions.Explode-UW';

	super.SpawnEffects(HitSurfaceType, Norm, Flags);
}

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_AirMineExplosion'
     HitDecals(0)=Class'BallisticProV55.AD_Explosion'
     HitSounds(0)=SoundGroup'BW_Core_WeaponSound.Explosions.Explode'
     HitSoundVolume=1.000000
     HitSoundRadius=1024.000000
     EffectBackOff=32.000000
}
