//=============================================================================
// IM_Tranq.
//
// ImpactManager subclass for tranq darts
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_Tranq extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_BulletConcrete'
     HitEffects(1)=Class'BallisticProV55.IE_BulletConcrete'
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
     HitSounds(0)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(1)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(2)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(3)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(4)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(5)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(6)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(7)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(8)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(9)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletWater'
     HitSounds(10)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSoundVolume=0.700000
     HitSoundRadius=128.000000
     HitDelay=0.100000
}
