//=============================================================================
// DT_FM13Burned.
//
// Damage type for FM13 primary fire spray
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FM13Burned extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k's Pitbull took a fiery leak all over %o, scorching %vm to death."
     DeathStrings(1)="%o tried to play with %k's fiery Pitbull, only to be burned, literally."
     DeathStrings(2)="%k has a very naughty Pitbull, poor %o got third degree burns all over %vh body."
     DeathStrings(3)="%o got cooked alive by %k's Pitbull. Good boy."
     DeathStrings(4)="%k let %kh Pitbull play with his new toy, a burning %o."
     InvasionDamageScaling=1.500000
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBP_OP_Pro.FM13Shotgun'
     DeathString="%k sprayed %o with fire."
     FemaleSuicide="%o mistreated his Pitbull and burned herself to death."
     MaleSuicide="%o mistreated his Pitbull and burned himself to death."
     bDelayedDamage=True
     KDamageImpulse=2000.000000
}
