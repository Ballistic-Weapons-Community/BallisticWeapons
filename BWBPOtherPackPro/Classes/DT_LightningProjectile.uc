//=============================================================================
// DTR78Rifle.
//
// Damage type for the R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LightningProjectile extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was fried by %k's lightning projectile."
	DeathStrings(1)="%o felt the shock from %k's lightning projectile."
	DeathStrings(2)="%k's lightning projectile broke every bone in %o's body."
	SimpleKillString="ARC-79 Lightning Projectile"
     InvasionDamageScaling=2.000000
     DamageIdent="Energy"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=50
     AimDisplacementDuration=0.400000
     WeaponClass=Class'BWBPOtherPackPro.LightningRifle'
     DeathString="%o was fried by %k's lightning projectile."
     FemaleSuicide="%o was fried by her own lightning projectile."
     MaleSuicide="%o was fried by his own lightning projectile."
	DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     VehicleDamageScaling=3.000000
     VehicleMomentumScaling=0.300000
}
