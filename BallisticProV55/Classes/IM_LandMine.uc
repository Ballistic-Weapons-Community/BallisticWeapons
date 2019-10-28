//=============================================================================
// IM_LandMine.
//
// ImpactManager subclass for Land Mines
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_LandMine extends BCImpactManager;

simulated function SpawnEffects (int HitSurfaceType, vector Norm, optional byte Flags)
{
	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (PhysicsVolume.bWaterVolume)
		HitSounds[0]=SoundGroup'BallisticSounds2.Explosions.Explode-UW';

	super.SpawnEffects(HitSurfaceType, Norm, Flags);
}

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_LandMineExplosion'
     HitDecals(0)=Class'BallisticProV55.AD_Explosion'
     HitSounds(0)=SoundGroup'BallisticSounds2.Explosions.Explode'
     HitSoundVolume=1.000000
     HitSoundRadius=1024.000000
     EffectBackOff=32.000000
}
