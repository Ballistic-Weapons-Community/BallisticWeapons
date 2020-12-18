//=============================================================================
// IM_Bullet.
//
// ImpactManager subclass for ordinary bullets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_Bullet extends BCImpactManager;

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
     HitSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(1)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(2)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSounds(3)=SoundGroup'BallisticSounds2.BulletImpacts.BulletMetal'
     HitSounds(4)=SoundGroup'BallisticSounds2.BulletImpacts.BulletWood'
     HitSounds(5)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSounds(6)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(7)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(8)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSounds(9)=SoundGroup'BallisticSounds2.BulletImpacts.BulletWater'
     HitSounds(10)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSoundVolume=0.700000
     HitSoundRadius=128.000000
     HitDelay=0.080000
}
