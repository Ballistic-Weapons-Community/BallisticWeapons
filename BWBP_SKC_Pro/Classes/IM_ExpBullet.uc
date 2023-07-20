//=============================================================================
// IM_ExpBullet.
//
// ImpactManager subclass for explosive rounds
// Used on the X83 and AH104
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_ExpBullet extends IM_Bullet;

defaultproperties
{
     HitEffects(0)=Class'BWBP_SKC_Pro.IE_BulletExpConcrete'
     HitEffects(1)=Class'BWBP_SKC_Pro.IE_BulletExpConcrete'
     HitEffects(2)=Class'BWBP_SKC_Pro.IE_BulletExpDirt'
     HitEffects(3)=Class'BWBP_SKC_Pro.IE_BulletExpMetal'
     HitEffects(4)=Class'BWBP_SKC_Pro.IE_BulletExpWood'
     HitEffects(5)=Class'BWBP_SKC_Pro.IE_BulletExpGrass'
     HitEffects(7)=Class'BWBP_SKC_Pro.IE_BulletExpIce'
     HitEffects(8)=Class'BWBP_SKC_Pro.IE_BulletExpSnow'
     HitDecals(0)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(1)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(3)=Class'BallisticProV55.AD_BigBulletMetal'
     HitDecals(4)=Class'BallisticProV55.AD_BigBulletWood'
     HitDecals(5)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(6)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(7)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(10)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletConcreteBig' //
     HitSounds(1)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletConcreteBig' //
     HitSounds(2)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletDirtBig'
     HitSounds(3)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletMetalBig'
     HitSounds(4)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletWoodBig' //
     HitSounds(5)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletDirtBig'
     HitSounds(6)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletConcreteBig' //
     HitSounds(7)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletConcreteBig' //
     HitSounds(8)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletDirtBig'
     HitSounds(9)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletWater'
     HitSounds(10)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletGlassBig'
     HitSoundVolume=1.500000
     HitSoundRadius=124.000000
     HitDelay=0.050000
}
