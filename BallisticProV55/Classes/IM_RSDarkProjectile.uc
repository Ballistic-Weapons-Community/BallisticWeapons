//=============================================================================
// IM_RSDarkProjectile.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_RSDarkProjectile extends BCImpactManager;

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
     HitEffects(0)=Class'BallisticProV55.IE_RSDarkGeneral'
     HitEffects(1)=Class'BallisticProV55.IE_RSDarkPlayerHit'
     HitEffects(2)=Class'BallisticProV55.IE_RSDarkPlayerKill'
     HitEffects(3)=Class'BallisticProV55.IE_RSDarkFastGeneral'
     HitEffects(4)=Class'BallisticProV55.IE_RSDarkFastPlayerHit'
     HitEffects(5)=Class'BallisticProV55.IE_RSProjectileCombo'
     HitDecals(0)=Class'BallisticProV55.AD_RSDarkSlow'
     HitDecals(1)=Class'BallisticProV55.AD_RSDarkSlow'
     HitDecals(2)=Class'BallisticProV55.AD_RSDarkSlow'
     HitDecals(3)=Class'BallisticProV55.AD_RSDarkFast'
     HitDecals(4)=Class'BallisticProV55.AD_RSDarkFast'
     HitSounds(0)=Sound'BWBP4-Sounds.DarkStar.Dark-SlowImpact'
     HitSounds(1)=Sound'BWBP4-Sounds.DarkStar.Dark-SlowImpact'
     HitSounds(2)=Sound'BWBP4-Sounds.DarkStar.Dark-SlowImpact'
     HitSounds(3)=Sound'BallisticSounds2.A73.A73Impact'
     HitSounds(4)=Sound'BallisticSounds2.A73.A73Impact'
     HitSoundVolume=1.300000
     HitSoundRadius=256.000000
}
