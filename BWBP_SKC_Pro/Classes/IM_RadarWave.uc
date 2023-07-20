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
     HitSoundVolume=0.650000
	 // UT sound attenuation mechanics
	 // The sensor radius is 768, and sounds play at full volume for your sound radius,
	 // and then the sound decays until 100 times the sound radius, where it is inaudible
	 // 64 is a reasonable full volume value
     HitSoundRadius=128.000000 
     EffectBackOff=96.000000
}
