//=============================================================================
// IM_RadarWave.
//
// ImpactManager subclass for radar pings
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_RadarWave extends BCImpactManager;


defaultproperties
{
     HitEffects(0)=Class'BWBP_SKC_Pro.IE_RadarWave'
     HitSounds(0)=Sound'BWBP_SKC_Sounds.MJ51.MJ51-SensorPing'
     HitSoundVolume=0.750000
     HitSoundRadius=900.000000
     EffectBackOff=96.000000
}
