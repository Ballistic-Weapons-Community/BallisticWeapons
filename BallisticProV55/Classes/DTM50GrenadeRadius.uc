//=============================================================================
// DTM50GrenadeRadius.
//
// Damage type for the M900 grenade fired from the M50
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM50GrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o lost a few teeth to %k's M900 grenade."
     DeathStrings(1)="%k's M900 grenade turned %o into chunky red ash."
     DeathStrings(2)="%o found %k's M900 grenade."
     SimpleKillString="M50 Grenade"
     InvasionDamageScaling=2.500000
     WeaponClass=Class'BallisticProV55.M50AssaultRifle'
     DeathString="%o lost a few teeth to %k's M900 grenade."
     FemaleSuicide="%o found one of her M900 grenades."
     MaleSuicide="%o found one of his M900 grenades."
     bDelayedDamage=True
}
