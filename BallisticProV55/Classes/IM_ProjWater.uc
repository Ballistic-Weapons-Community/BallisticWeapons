//=============================================================================
// IM_ProjWater.
//
// ImpactManager subclass for projectiles and grenades hitting water
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_ProjWater extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_ProjWater'
     HitSounds(0)=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Water'
}
