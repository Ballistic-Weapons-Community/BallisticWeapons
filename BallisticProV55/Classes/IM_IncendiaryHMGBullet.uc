//=============================================================================
// IM_IncendiaryBullet.
//
// ImpactManager subclass for incendiary HMG bullets which need to be faster
// and get custom effects. Used by FG50
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_IncendiaryHMGBullet extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'IE_IncMinigunBulletConcrete'
     HitEffects(1)=Class'IE_IncMinigunBulletConcrete'
     HitEffects(2)=Class'IE_IncBulletDirt'
     HitEffects(3)=Class'IE_IncBulletMetal'
     HitEffects(4)=Class'IE_IncBulletWood'
     HitEffects(5)=Class'IE_IncBulletGrass'
     HitEffects(6)=Class'KFMod.FleshHitEmitter'
     HitEffects(7)=Class'IE_IncBulletIce'
     HitEffects(8)=Class'IE_IncBulletSnow'
     HitEffects(9)=Class'BallisticProV55.IE_BulletWater'
     HitEffects(10)=Class'IE_IncBulletGlass'
     HitDecals(0)=Class'BallisticProV55.AD_BulletConcrete'
     HitDecals(1)=Class'BallisticProV55.AD_BulletConcrete'
     HitDecals(2)=Class'BallisticProV55.AD_BulletDirt'
     HitDecals(3)=Class'BallisticProV55.AD_BulletMetal'
     HitDecals(4)=Class'BallisticProV55.AD_BulletWood'
     HitDecals(5)=Class'BallisticProV55.AD_BulletConcrete'
     HitDecals(6)=Class'BallisticProV55.AD_BulletConcrete'
     HitDecals(7)=Class'BallisticProV55.AD_BulletIce'
     HitDecals(8)=Class'BallisticProV55.AD_BulletDirt'
     HitDecals(10)=Class'BallisticProV55.AD_BulletConcrete'
     HitSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletConcrete'
     HitSounds(1)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletConcrete'
     HitSounds(2)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletDirt'
     HitSounds(3)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletMetal'
     HitSounds(4)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletWood'
     HitSounds(5)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletDirt'
     HitSounds(6)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletConcrete'
     HitSounds(7)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletConcrete'
     HitSounds(8)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletDirt'
     HitSounds(9)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletWater'
     HitSounds(10)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletConcrete'
     HitSoundVolume=0.850000
     HitSoundRadius=160.000000
     HitDelay=0.080000
}
