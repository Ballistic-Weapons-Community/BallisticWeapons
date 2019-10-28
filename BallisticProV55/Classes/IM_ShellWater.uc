//=============================================================================
// IM_ShellWater.
//
// ImpactManager subclass for shotgun pellets hitting water
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_ShellWater extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_ShellWater'
     HitSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.BulletWater'
}
