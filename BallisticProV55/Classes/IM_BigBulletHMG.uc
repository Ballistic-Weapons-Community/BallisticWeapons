//=============================================================================
// IM_BigBulletHMG.
//
// ImpactManager subclass for larger bullets, 50 cal and up
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_BigBulletHMG extends IM_Bullet;

defaultproperties
{
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
     HitSoundVolume=1.200000
     HitSoundRadius=124.000000
     HitDelay=0.060000
}
