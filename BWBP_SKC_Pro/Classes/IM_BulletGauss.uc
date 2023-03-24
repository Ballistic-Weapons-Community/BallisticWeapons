//=============================================================================
// IM_BulletGauss.
//
// ImpactManager subclass for gauss rifles (M30A2, M2020, ZX98, T9CN Alt)
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_BulletGauss extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBP_SKC_Pro.IE_BulletGauss'
     HitEffects(1)=Class'BWBP_SKC_Pro.IE_BulletGauss'
     HitEffects(2)=Class'BWBP_SKC_Pro.IE_BulletGauss'
     HitEffects(3)=Class'BWBP_SKC_Pro.IE_BulletGauss'
     HitEffects(4)=Class'BWBP_SKC_Pro.IE_BulletGauss'
     HitEffects(5)=Class'BWBP_SKC_Pro.IE_BulletGauss'
     HitEffects(6)=Class'BWBP_SKC_Pro.IE_BulletGauss'
     HitEffects(7)=Class'BWBP_SKC_Pro.IE_BulletGauss'
     HitEffects(8)=Class'BWBP_SKC_Pro.IE_BulletGauss'
     HitDecals(0)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(1)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(3)=Class'BallisticProV55.AD_BigBulletMetal'
     HitDecals(4)=Class'BallisticProV55.AD_BigBulletWood'
     HitDecals(5)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(6)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(7)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(10)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitSounds(0)=SoundGroup'BW_Core_WeaponSound.Gauss.Gauss-Impact'
     HitSounds(1)=SoundGroup'BW_Core_WeaponSound.Gauss.Gauss-Impact'
     HitSounds(2)=SoundGroup'BW_Core_WeaponSound.Gauss.Gauss-Impact'
     HitSounds(3)=SoundGroup'BW_Core_WeaponSound.Gauss.Gauss-Impact'
     HitSounds(4)=SoundGroup'BW_Core_WeaponSound.Gauss.Gauss-Impact'
     HitSounds(5)=SoundGroup'BW_Core_WeaponSound.Gauss.Gauss-Impact'
     HitSounds(6)=SoundGroup'BW_Core_WeaponSound.Gauss.Gauss-Impact'
     HitSounds(7)=SoundGroup'BW_Core_WeaponSound.Gauss.Gauss-Impact'
     HitSounds(8)=SoundGroup'BW_Core_WeaponSound.Gauss.Gauss-Impact'
     HitSounds(10)=SoundGroup'BW_Core_WeaponSound.Gauss.Gauss-Impact'
     HitSoundVolume=1.500000
     HitSoundRadius=174.000000
}
