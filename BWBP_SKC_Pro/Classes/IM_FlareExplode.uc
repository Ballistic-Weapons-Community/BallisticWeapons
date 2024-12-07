//=============================================================================
// IM_FireExplode.
//
// ImpactManager subclass for FLASH explosions
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_FlareExplode extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBP_SKC_Pro.IE_WillyPete'
     HitDecals(0)=Class'BallisticProV55.AD_FireExplosion'
     HitSounds(0)=Sound'BWBP_SKC_Sounds.Misc.M202-Boom3'
     HitSoundVolume=1.000000
     HitSoundRadius=512.000000
     EffectBackOff=32.000000
}
