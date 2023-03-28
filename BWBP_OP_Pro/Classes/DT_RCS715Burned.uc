//=============================================================================
// DTFP7Burned.
//
// Damage type for FP7 fires.
// Melts stuff.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RCS715Burned extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o lit up the night sky after being burned to death by %k."
     DeathStrings(1)="%k collected %o's ashes after cremating %vm with a Buster."
     DeathStrings(2)="%o got busted and burned by %k's tactical buster."
     SimpleKillString="RCS-715 Grenade Burn"
     bIgnoredOnLifts=True
     InvasionDamageScaling=2.000000
     DamageIdent="Grenade"
     WeaponClass=Class'BWBP_OP_Pro.RCS715Shotgun'
     DeathString="%o went out in a blaze of %k's glory."
     FemaleSuicide="%o went out as she lived, burned out."
     MaleSuicide="%o went out as he lived, burned out."
     bDelayedDamage=True
     PawnDamageSounds(0)=Sound'BW_Core_WeaponSound.FP7.FP7BurnFlesh'
     KDamageImpulse=20000.000000
}
