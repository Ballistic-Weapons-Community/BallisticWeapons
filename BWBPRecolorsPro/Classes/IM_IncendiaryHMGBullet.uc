//=============================================================================
// IM_IncendiaryBullet.
//
// ImpactManager subclass for incendiary minigun bullets which need to be faster
// and get custom effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_IncendiaryHMGBullet extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBPRecolorsPro.IE_IncMinigunBulletConcrete'
     HitEffects(1)=Class'BWBPRecolorsPro.IE_IncMinigunBulletConcrete'
     HitEffects(2)=Class'BWBPRecolorsPro.IE_IncBulletDirt'
     HitEffects(3)=Class'BWBPRecolorsPro.IE_IncBulletMetal'
     HitEffects(4)=Class'BWBPRecolorsPro.IE_IncBulletWood'
     HitEffects(5)=Class'BWBPRecolorsPro.IE_IncBulletGrass'
     HitEffects(6)=Class'XEffects.pclredsmoke'
     HitEffects(7)=Class'BWBPRecolorsPro.IE_IncBulletIce'
     HitEffects(8)=Class'BWBPRecolorsPro.IE_IncBulletSnow'
     HitEffects(9)=Class'BallisticProV55.IE_BulletWater'
     HitEffects(10)=Class'BWBPRecolorsPro.IE_IncBulletGlass'
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
     HitSoundVolume=0.850000
     HitSoundRadius=160.000000
     HitDelay=0.080000
}
