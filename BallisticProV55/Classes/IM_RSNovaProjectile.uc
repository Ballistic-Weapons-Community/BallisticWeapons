//=============================================================================
// IM_RSNovaProjectile.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_RSNovaProjectile extends BCImpactManager;

simulated function Initialize (int HitSurfaceType, vector Norm, optional byte Flags)
{
	if (HitSurfaceType > 2)
	{
		HitSoundVolume = 0.700000;
		HitSoundRadius = 96.000000;
	}
	super.Initialize(HitSurfaceType, Norm, Flags);
}

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_RSNova1General'
     HitEffects(1)=Class'BallisticProV55.IE_RSNovaPlayerHit'
     HitEffects(2)=Class'BallisticProV55.IE_RSNovaPlayerKill'
     HitEffects(3)=Class'BallisticProV55.IE_RSNovaFastGeneral'
     HitEffects(4)=Class'BallisticProV55.IE_RSNovaFastPlayerHit'
     HitEffects(5)=Class'BallisticProV55.IE_RSProjectileCombo'
     HitDecals(0)=Class'BallisticProV55.AD_RSNovaSlow'
     HitDecals(1)=Class'BallisticProV55.AD_RSNovaSlow'
     HitDecals(2)=Class'BallisticProV55.AD_RSNovaSlow'
     HitDecals(3)=Class'BallisticProV55.AD_RSNovaFast'
     HitDecals(4)=Class'BallisticProV55.AD_RSNovaFast'
     HitSounds(0)=Sound'BW_Core_WeaponSound.NovaStaff.Nova-SlowImpact'
     HitSounds(1)=Sound'BW_Core_WeaponSound.NovaStaff.Nova-SlowImpact'
     HitSounds(2)=Sound'BW_Core_WeaponSound.NovaStaff.Nova-SlowImpact'
     HitSounds(3)=Sound'BW_Core_WeaponSound.A73.A73Impact'
     HitSounds(4)=Sound'BW_Core_WeaponSound.A73.A73Impact'
     HitSoundVolume=1.300000
     HitSoundRadius=256.000000
}
