//=============================================================================
// IM_GunHit.
//
// ImpactManager subclass for blunt gun melee hits
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_GunHit extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_GunConcrete'
     HitEffects(1)=Class'BallisticProV55.IE_GunConcrete'
     HitEffects(2)=Class'BallisticProV55.IE_BulletDirt'
     HitEffects(3)=Class'BallisticProV55.IE_BulletMetal'
     HitEffects(4)=Class'BallisticProV55.IE_BulletWood'
     HitEffects(5)=Class'BallisticProV55.IE_BulletGrass'
     HitEffects(6)=Class'BallisticProV55.IE_BulletDirt'
     HitEffects(7)=Class'BallisticProV55.IE_BulletIce'
     HitEffects(8)=Class'BallisticProV55.IE_BulletIce'
     HitEffects(9)=Class'BallisticProV55.IE_ProjWater'
     HitEffects(10)=Class'BallisticProV55.IE_BulletGlass'
     HitDecals(0)=Class'BallisticProV55.AD_GunBash'
     HitDecals(1)=Class'BallisticProV55.AD_GunBash'
     HitDecals(2)=Class'BallisticProV55.AD_GunBash'
     HitDecals(3)=Class'BallisticProV55.AD_GunBash'
     HitDecals(4)=Class'BallisticProV55.AD_GunBashWood'
     HitDecals(5)=Class'BallisticProV55.AD_GunBashWood'
     HitDecals(6)=Class'BallisticProV55.AD_GunBash'
     HitDecals(7)=Class'BallisticProV55.AD_GunBash'
     HitDecals(8)=Class'BallisticProV55.AD_GunBash'
     HitDecals(10)=Class'BallisticProV55.AD_GunBash'
     HitSounds(0)=Sound'BW_Core_WeaponSound.M763.M763ConcreteHit1'
     HitSounds(1)=Sound'BW_Core_WeaponSound.M763.M763ConcreteHit1'
     HitSounds(2)=Sound'BW_Core_WeaponSound.M763.M763ConcreteHit1'
     HitSounds(3)=Sound'BW_Core_WeaponSound.M763.M763MetalHit1'
     HitSounds(4)=Sound'BW_Core_WeaponSound.M763.M763WoodHit1'
     HitSounds(5)=Sound'BW_Core_WeaponSound.M763.M763WoodHit1'
     HitSounds(6)=Sound'BW_Core_WeaponSound.M763.M763ConcreteHit1'
     HitSounds(7)=Sound'BW_Core_WeaponSound.M763.M763ConcreteHit1'
     HitSounds(8)=Sound'BW_Core_WeaponSound.M763.M763ConcreteHit1'
     HitSounds(9)=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Water'
     HitSounds(10)=Sound'BW_Core_WeaponSound.M763.M763ConcreteHit1'
     HitSoundVolume=0.700000
     HitSoundRadius=48.000000
     HitDelay=0.130000
}
