//=============================================================================
// IM_MRLRocket.
//
// ImpactManager subclass for MRL Rocket Explosions
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_MRLRocket extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_MRLExplosion'
     HitDecals(0)=Class'BallisticProV55.AD_MRLExplosion'
     DecalScale=0.250000
     HitSounds(0)=SoundGroup'BWBP4-Sounds.MRL.MRL-Explode'
     HitSoundVolume=0.700000
     HitSoundRadius=256.000000
     HitSoundPitch=1.300000
     EffectBackOff=48.000000
}
