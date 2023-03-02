//=============================================================================
// DTM50GrenadeRadius.
//
// Damage type for the M900 grenade fired from the M50
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFM14GrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o lost a few teeth to %k's S900 grenade."
     DeathStrings(1)="%k's S900 grenade turned %o into chunky red ash."
     DeathStrings(2)="%o found %k's S900 grenade."
     SimpleKillString="FM14 Grenade"
     InvasionDamageScaling=2.000000
     WeaponClass=Class'BWBP_APC_Pro.FM14Shotgun'
     DeathString="%o lost a few teeth to %k's S900 grenade."
     FemaleSuicide="%o found one of her S900 grenades."
     MaleSuicide="%o found one of his S900 grenades."
     bDelayedDamage=True
}
