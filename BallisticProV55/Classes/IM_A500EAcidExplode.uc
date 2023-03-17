//=============================================================================
// IM_A500AcidExplode.
//
// ImpactManager subclass for A500 Acid Explosions
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_A500EAcidExplode extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_A500EBlobImpact'
     HitDecals(0)=Class'BallisticProV55.AD_A500EBlobSplat'
     HitSounds(0)=Sound'BW_Core_WeaponSound.Reptile.Rep_AltImpact'
     HitSoundVolume=2.000000
     HitSoundRadius=1024.000000
     EffectBackOff=32.000000
}
