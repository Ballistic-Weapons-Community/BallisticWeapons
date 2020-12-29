//=============================================================================
// IM_MinigunBullet.
//
// ImpactManager subclass for minigun bullets which need to be faster
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_MinigunBullet extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_MinigunBulletConcrete'
     HitEffects(1)=Class'BallisticProV55.IE_MinigunBulletConcrete'
     HitEffects(2)=Class'BallisticProV55.IE_BulletDirt'
     HitEffects(3)=Class'BallisticProV55.IE_BulletMetal'
     HitEffects(4)=Class'BallisticProV55.IE_BulletWood'
     HitEffects(5)=Class'BallisticProV55.IE_BulletGrass'
     HitEffects(6)=Class'XEffects.pclredsmoke'
     HitEffects(7)=Class'BallisticProV55.IE_BulletIce'
     HitEffects(8)=Class'BallisticProV55.IE_BulletSnow'
     HitEffects(9)=Class'BallisticProV55.IE_BulletWater'
     HitEffects(10)=Class'BallisticProV55.IE_BulletGlass'
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
     HitSoundVolume=0.700000
     HitSoundRadius=128.000000
     HitDelay=0.080000
}
