//=============================================================================
// IM_A73Projectile.
//
// ImpactManager subclass for A73 projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_BFGProjectileSmall extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBPRecolorsPro.IE_BFGSmall'
     HitDecals(0)=Class'BallisticProV55.AD_MRLExplosion'
     HitSounds(0)=Sound'BWBP_SKC_Sounds.BFG.BFG-SmallImpact'
     HitSoundVolume=1.000000
     HitSoundRadius=128.000000
}
