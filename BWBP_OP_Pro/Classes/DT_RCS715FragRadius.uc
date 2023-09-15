//=============================================================================
// DTMRS138ShotgunFragRadius.
//
// Damage type for MRS138 Shotgun explosive slug radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RCS715FragRadius extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k blasted %o apart with an RCS barrage."
     DeathStrings(1)="%o was massacred by %k's explosive auto shotgun."
     DeathStrings(2)="%k fragged %o with %kh RCS."
     DeathStrings(3)="%k slugged %o out with %kh RCS explosive shell."
     WeaponClass=Class'BWBP_OP_Pro.RCS715Shotgun'
     SimpleKillString="RCS715 FRAG"
     InvasionDamageScaling=2
     DamageIdent="Ordnance, Shotgun"
     DeathString="%k blasted %o apart with an RCS barrage."
     FemaleSuicide="%o forgot she loaded frag rounds."
     MaleSuicide="%o forgot he loaded frag rounds."
     bDelayedDamage=True
}
