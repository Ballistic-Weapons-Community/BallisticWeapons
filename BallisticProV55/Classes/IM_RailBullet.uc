//=============================================================================
// IM_RailBullet.
//
// ImpactManager subclass for Railgun hits
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_RailBullet extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_M75General'
     HitEffects(1)=Class'BallisticProV55.IE_M75General'
     HitEffects(2)=Class'BallisticProV55.IE_M75General'
     HitEffects(3)=Class'BallisticProV55.IE_M75General'
     HitEffects(4)=Class'BallisticProV55.IE_M75General'
     HitEffects(5)=Class'BallisticProV55.IE_M75General'
     HitEffects(6)=Class'BallisticProV55.IE_M75General'
     HitEffects(7)=Class'BallisticProV55.IE_M75General'
     HitEffects(8)=Class'BallisticProV55.IE_M75General'
     HitEffects(9)=Class'BallisticProV55.IE_BulletWater'
     HitEffects(10)=Class'BallisticProV55.IE_M75General'
     HitDecals(0)=Class'BallisticProV55.AD_RailGeneral'
     HitDecals(1)=Class'BallisticProV55.AD_RailGeneral'
     HitDecals(2)=Class'BallisticProV55.AD_RailGeneral'
     HitDecals(3)=Class'BallisticProV55.AD_RailGeneral'
     HitDecals(4)=Class'BallisticProV55.AD_RailGeneral'
     HitDecals(5)=Class'BallisticProV55.AD_RailGeneral'
     HitDecals(6)=Class'BallisticProV55.AD_RailGeneral'
     HitDecals(7)=Class'BallisticProV55.AD_RailGeneral'
     HitDecals(8)=Class'BallisticProV55.AD_RailGeneral'
     HitDecals(10)=Class'BallisticProV55.AD_RailGeneral'
     HitSounds(0)=Sound'BW_Core_WeaponSound.M75.M75Impact'
     HitSounds(1)=Sound'BW_Core_WeaponSound.M75.M75Impact'
     HitSounds(2)=Sound'BW_Core_WeaponSound.M75.M75Impact'
     HitSounds(3)=Sound'BW_Core_WeaponSound.M75.M75Impact'
     HitSounds(4)=Sound'BW_Core_WeaponSound.M75.M75Impact'
     HitSounds(5)=Sound'BW_Core_WeaponSound.M75.M75Impact'
     HitSounds(6)=Sound'BW_Core_WeaponSound.M75.M75Impact'
     HitSounds(7)=Sound'BW_Core_WeaponSound.M75.M75Impact'
     HitSounds(8)=Sound'BW_Core_WeaponSound.M75.M75Impact'
     HitSounds(9)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletWater'
     HitSounds(10)=Sound'BW_Core_WeaponSound.M75.M75Impact'
}
