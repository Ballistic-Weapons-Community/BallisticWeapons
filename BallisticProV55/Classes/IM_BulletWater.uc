//=============================================================================
// IM_BulletWater.
//
// ImpactManager subclass for ordinary bullets hitting water
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_BulletWater extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_BulletWater'
     HitSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.BulletWater'
}
