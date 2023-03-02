//=============================================================================
// DTRX22ACloudBomb.
//
// Damage type for RX22A gas cloud explosion
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFM13CloudBomb extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k bombed %o with fire."
     DeathStrings(1)="%o got caught up in %k's firestorm."
     DeathStrings(2)="%k's firebomb charred %o into ash."
     InvasionDamageScaling=1.500000
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBP_APC_Pro.FM13Shotgun'
     DeathString="%k bombed %o with fire."
     FemaleSuicide="%o bombed herself."
     MaleSuicide="%o bombed himself."
     bDelayedDamage=True
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.800000
}
