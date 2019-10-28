//=============================================================================
// IM_SlugHE
//
// ImpactManager subclass for SK-410 explosive shells
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_SlugHE extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBPRecolorsPro.IE_SlugHE'
     HitDecals(0)=Class'BallisticProV55.AD_Explosion'
     HitSounds(0)=Sound'PackageSounds4Pro.Bulldog.Bulldog-Impact'
     HitSoundVolume=1.400000
     HitSoundRadius=384.000000
     EffectBackOff=96.000000
}
