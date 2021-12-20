//=============================================================================
// DTM50GrenadeRadius.
//
// Damage type for the M900 grenade fired from the M50
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTZ250GrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o lost a few teeth to %k's M900 Gas grenade."
     DeathStrings(1)="%k's M900 Gas grenade turned %o into chunky red ash."
     DeathStrings(2)="%o found %k's M900 Gas grenade."
     SimpleKillString="Z250 Gas Grenade"
     InvasionDamageScaling=2.000000
     WeaponClass=Class'BWBP_OP_Pro.Z250Minigun'
     DeathString="%o lost a few teeth to %k's M900 Gas grenade."
     FemaleSuicide="%o found one of her M900 Gas grenades."
     MaleSuicide="%o found one of his M900 Gas grenades."
     bDelayedDamage=True
}
