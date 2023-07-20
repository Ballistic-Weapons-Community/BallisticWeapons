//=============================================================================
// IM_BulletAmpRad.
// 
// ImpactManager subclass for amp'd rad bullets
// 
// by Sarge + other pack dudes
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_BulletAmpRad extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBP_SKC_Pro.IE_BulletRadLarge'
     HitDecals(0)=Class'BWBP_SKC_Pro.AD_SX45Scorch'
     HitSounds(0)=Sound'BWBP_SKC_Sounds.SX45.SX45-RadImpact'
     HitSoundVolume=1.000000
     HitSoundRadius=256.000000
}
