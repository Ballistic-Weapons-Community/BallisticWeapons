//=============================================================================
// DTXM84GrenadeRadius.
//
// Damage type for the XM84 Grenade radius damage
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXM84GrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o's fragile brain was fried by %k's XM84."
     DeathStrings(1)="%k's XM84 hemorrhaged %o's fragile brain."
     DeathStrings(2)="%o succumbed to %k's XM84 psionic blast."
     FlashThreshold=0
     FlashV=(X=128.000000,Y=128.000000,Z=128.000000)
     FlashF=-2.000000
     DamageIdent="Grenade"
     MinMotionBlurDamage=1.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=9.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBPRecolorsPro.XM84Flashbang'
     DeathString="%o was fatally corrupted by %k's tech grenade."
     FemaleSuicide="%o had a tactical error with her tactical grenade."
     MaleSuicide="%o had a tactical error with his tactical grenade."
     bArmorStops=False
     bCauseConvulsions=True
     bDelayedDamage=True
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'PackageSounds4Pro.Misc.XM84-StunEffect'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     VehicleMomentumScaling=0.500000
}
