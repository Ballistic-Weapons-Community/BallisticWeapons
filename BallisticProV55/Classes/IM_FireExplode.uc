//=============================================================================
// IM_FireExplode.
//
// ImpactManager subclass for Fire Explosions
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_FireExplode extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_FireExplosion'
     HitDecals(0)=Class'BallisticProV55.AD_FireExplosion'
     HitSounds(0)=Sound'BallisticSounds3.FP7.FP7Ignition'
     HitSoundVolume=1.000000
     HitSoundRadius=1024.000000
     EffectBackOff=32.000000
}
