//=============================================================================
// IM_A500AcidExplode.
//
// ImpactManager subclass for A500 Acid Explosions
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_A500AcidExplode extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_A500BlobImpact'
     HitDecals(0)=Class'BallisticProV55.AD_A500BlobSplat'
     HitSounds(0)=Sound'BW_Core_WeaponSound.Reptile.Rep_AltImpact'
     HitSoundVolume=2.000000
     HitSoundRadius=1024.000000
     EffectBackOff=32.000000
}
