//=============================================================================
// IM_A500Projectile.
//
// ImpactManager subclass for A500 projectiles
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyrightę 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_A500EProjectile extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_A500EBlastImpact'
     HitDecals(0)=Class'BallisticProV55.AD_A500EBlastSplat'
     HitSounds(0)=Sound'BW_Core_WeaponSound.Reptile.Rep_Impact01'
     HitSounds(1)=Sound'BW_Core_WeaponSound.Reptile.Rep_PlayerImpact'
     HitSoundVolume=0.750000
}
