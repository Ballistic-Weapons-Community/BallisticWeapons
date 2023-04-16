//=============================================================================
// IM_LonghornShatter.
//
// It done broke
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_LonghornShatter extends BCImpactManager;

/*
	EST_Default,	0
	EST_Rock,		1
	EST_Dirt,		2
	EST_Metal,		3
	EST_Wood,		4
	EST_Plant,		5
	EST_Flesh,		6
    EST_Ice,		7
    EST_Snow,		8
    EST_Water,		9
    EST_Glass,		10
*/

defaultproperties
{
     HitEffects(0)=Class'BWBP_SKC_Pro.IE_BulletHE'
     HitDecals(0)=Class'BallisticProV55.AD_Explosion'
     HitSounds(0)=Sound'BWBP_SKC_Sounds.Longhorn.Longhorn-DudImpact'
     HitSoundVolume=1.200000
     HitSoundRadius=256.000000
     EffectBackOff=96.000000
     DecalScale=0.100000
}
