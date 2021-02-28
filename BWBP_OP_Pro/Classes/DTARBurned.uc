//=============================================================================
// DTFP7Burned.
//
// Damage type for FP7 fires.
// Melts stuff.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTARBurned extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o went out in a blaze of %k's glory."
     DeathStrings(1)="%k reduced %o to ashes."
     SimpleKillString="RCS-715 Grenade Burn"
     bIgnoredOnLifts=True
     InvasionDamageScaling=2.000000
     DamageIdent="Grenade"
     WeaponClass=Class'BWBP_OP_Pro.ARShotgun'
     DeathString="%o went out in a blaze of %k's glory."
     FemaleSuicide="%o went out in a blaze of her own glory."
     MaleSuicide="%o went out in a blaze of his own glory."
     bDelayedDamage=True
     PawnDamageSounds(0)=Sound'BW_Core_WeaponSound.FP7.FP7BurnFlesh'
     KDamageImpulse=20000.000000
}
