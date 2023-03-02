//=============================================================================
// IM_A73Projectile.
//
// ImpactManager subclass for A73 projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_HVPCProjectileTriple extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBP_SKCExp_Pro.IE_HVPCTriple'
     HitDecals(0)=Class'BallisticProV55.AD_HVCRedDecal'
     HitSounds(0)=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Impact'
     HitSoundVolume=0.800000
     HitSoundRadius=256.000000
}
