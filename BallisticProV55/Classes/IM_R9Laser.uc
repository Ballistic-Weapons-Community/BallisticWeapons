//=============================================================================
// IM_RSDarkProjectile.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_R9Laser extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_RSDarkFastGeneral'
     HitEffects(1)=Class'BallisticProV55.IE_RSDarkFastPlayerHit'
     HitEffects(2)=Class'BallisticProV55.IE_RSDarkFastPlayerHit'
     HitEffects(3)=Class'BallisticProV55.IE_RSDarkFastGeneral'
     HitEffects(4)=Class'BallisticProV55.IE_RSDarkFastPlayerHit'
     HitEffects(5)=Class'BallisticProV55.IE_RSProjectileCombo'
     HitDecals(0)=Class'BallisticProV55.AD_RSDarkFast'
     HitDecals(1)=Class'BallisticProV55.AD_RSDarkFast'
     HitDecals(2)=Class'BallisticProV55.AD_RSDarkFast'
     HitDecals(3)=Class'BallisticProV55.AD_RSDarkFast'
     HitDecals(4)=Class'BallisticProV55.AD_RSDarkFast'
     HitSounds(0)=Sound'BW_Core_WeaponSound.DarkStar.Dark-SlowImpact'
     HitSounds(1)=Sound'BW_Core_WeaponSound.DarkStar.Dark-SlowImpact'
     HitSounds(2)=Sound'BW_Core_WeaponSound.DarkStar.Dark-SlowImpact'
     HitSounds(3)=Sound'BW_Core_WeaponSound.A73.A73Impact'
     HitSounds(4)=Sound'BW_Core_WeaponSound.A73.A73Impact'
     HitSoundRadius=128.000000
}
