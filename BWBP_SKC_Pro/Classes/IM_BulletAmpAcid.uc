//=============================================================================
// IM_BulletAmpAcid.
//
// ImpactManager subclass for acid bullets
//
// by Sarge
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_BulletAmpAcid extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_A500BlastImpact'
     HitDecals(0)=Class'BWBP_SKC_Pro.AD_BulletAcid'
     HitSounds(0)=Sound'BW_Core_WeaponSound.Reptile.Rep_Impact01'
     HitSounds(1)=Sound'BW_Core_WeaponSound.Reptile.Rep_PlayerImpact'
     HitSoundVolume=0.750000
}
