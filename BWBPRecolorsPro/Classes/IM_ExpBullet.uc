//=============================================================================
// IM_Bullet.
//
// ImpactManager subclass for ordinary bullets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_ExpBullet extends IM_Bullet;

defaultproperties
{
     HitEffects(0)=Class'BWBPRecolorsPro.IE_BulletExpConcrete'
     HitEffects(1)=Class'BWBPRecolorsPro.IE_BulletExpConcrete'
     HitEffects(2)=Class'BWBPRecolorsPro.IE_BulletExpDirt'
     HitEffects(3)=Class'BWBPRecolorsPro.IE_BulletExpMetal'
     HitEffects(4)=Class'BWBPRecolorsPro.IE_BulletExpWood'
     HitEffects(5)=Class'BWBPRecolorsPro.IE_BulletExpGrass'
     HitEffects(7)=Class'BWBPRecolorsPro.IE_BulletExpIce'
     HitEffects(8)=Class'BWBPRecolorsPro.IE_BulletExpSnow'
     HitDecals(0)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(1)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(3)=Class'BallisticProV55.AD_BigBulletMetal'
     HitDecals(4)=Class'BallisticProV55.AD_BigBulletWood'
     HitDecals(5)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(6)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(7)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitDecals(10)=Class'BallisticProV55.AD_BigBulletConcrete'
     HitSoundVolume=0.900000
     HitSoundRadius=124.000000
}
