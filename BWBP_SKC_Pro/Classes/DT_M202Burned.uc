//=============================================================================
// DT_M202Burned.
//
// Damage type for M202 fires
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_M202Burned extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o blindingly walked into %k's literal field of fire."
     DeathStrings(1)="%k scorched the earth with napalm and %o rolled in it."
     DeathStrings(2)="%o dove headfirst into %k's napalm blaze."
     DeathStrings(3)="%o tried to dance in %k's inferno, but the third degree burns said no."
     InvasionDamageScaling=2.000000
     DamageIdent="Killstreak"
     WeaponClass=Class'BWBP_SKC_Pro.FLASHLauncher'
     DeathString="%o dove headfirst into %k's napalm blaze."
     FemaleSuicide="%o leapt into her own fire like an idiot."
     MaleSuicide="%o leapt into his own fire like an idiot."
     bDelayedDamage=True
     PawnDamageSounds(0)=Sound'BW_Core_WeaponSound.FP7.FP7BurnFlesh'
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.350000
}
