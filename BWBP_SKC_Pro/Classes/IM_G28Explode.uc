//=============================================================================
// IM_G28Explode.
//
// ImpactManager subclass for Fire Explosions
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_G28Explode extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBP_SKC_Pro.IE_G28Explosion'
     HitDecals(0)=Class'BallisticProV55.AD_FireExplosion'
     HitSounds(0)=Sound'BW_Core_WeaponSound.FP7.FP7Ignition'
     HitSoundVolume=1.000000
     HitSoundRadius=1024.000000
     EffectBackOff=32.000000
}
