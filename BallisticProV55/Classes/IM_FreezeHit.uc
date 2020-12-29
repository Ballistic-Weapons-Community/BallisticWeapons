//=============================================================================
// IM_A73Projectile.
// 
// ImpactManager subclass for A73 projectiles
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_FreezeHit extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_FreezeImpact'
     HitDecals(0)=Class'BallisticProV55.AD_BulletIce'
     HitSounds(0)=Sound'BW_Core_WeaponSound.A73.A73Impact'
}
