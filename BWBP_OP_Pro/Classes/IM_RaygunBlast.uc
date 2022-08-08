//=============================================================================
// IM_RaygunBlast.
//
// ImpactManager subclass for Classic/Realistic raygun projectiles
//
// by SK, adapted from Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_RaygunBlast extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBP_OP_Pro.IE_RaygunBlast'
     HitDecals(0)=Class'BallisticProV55.AD_HVCRedDecal'
     HitSounds(0)=Sound'BWBP_OP_Sounds.Raygun.Raygun-BlastImpact'
     HitSoundVolume=1.300000
     HitSoundRadius=256.000000
}
