//=============================================================================
// IM_GasTankExplode.
//
// ImpactManager subclass for RX22A Gas Tank Explosions
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_GasTankExplode extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_RX22APackExplosion'
     HitDecals(0)=Class'BallisticProV55.AD_FireExplosion'
     HitSounds(0)=Sound'BallisticSounds2.RX22A.RX22A-PackExplode'
     HitSoundVolume=1.000000
     HitSoundRadius=192.000000
}
