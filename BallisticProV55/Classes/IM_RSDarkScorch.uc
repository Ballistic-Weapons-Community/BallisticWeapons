//=============================================================================
// IM_RSDarkScorch.
//
// ImpactManager subclass for Dark Star plasme Scorches. Uses Decal only
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_RSDarkScorch extends BCImpactManager;

static function EvilStartSpawn (vector V, vector Norm, int Surface, actor OwnedBy, optional float DelayTime)
{
	default.HitDelay = DelayTime;
	super.StartSpawn(V, Norm, Surface, OwnedBy, 0);
}

defaultproperties
{
     HitDecals(0)=Class'BallisticProV55.AD_RX22AScorch'
     HitSoundVolume=1.000000
     HitSoundRadius=1024.000000
     EffectBackOff=96.000000
}
