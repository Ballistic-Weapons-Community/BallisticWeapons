//=============================================================================
// IM_E23Projectile.
//
// ImpactManager subclass for E23 projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_E23Projectile extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_E23General'
     HitEffects(1)=Class'BallisticProV55.IE_E23Enemy'
     HitDecals(0)=Class'BallisticProV55.AD_E23General'
     HitSounds(0)=Sound'BWBP4-Sounds.VPR.VPR-Impact'
}
