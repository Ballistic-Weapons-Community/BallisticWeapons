//=============================================================================
// DT_AK47Slash.
//
// Damagetype for the AL48 bayonette attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AK490Slash extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k shared %kh bayonet with %o the communist way."
     DeathStrings(1)="%k speared %o in a vodka induced rage."
     DeathStrings(2)="%o was split like small bear by %k's AK490 blade."
     DeathStrings(3)="%o is now leaking borscht thanks to %k's bayonet."
     DeathStrings(4)="%k slaughtered %o like small baby man."
     DamageDescription=",Stab,"
     WeaponClass=Class'BWBP_SKC_Pro.AK490BattleRifle'
     DeathString="%k shared %kh bayonet with %o the communist way."
     FemaleSuicide="%o stumbled onto her AK490 bayonet."
     MaleSuicide="%o stumbled onto his AK490 bayonet."
     bArmorStops=False
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'BW_Core_WeaponSound.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.500000
}
