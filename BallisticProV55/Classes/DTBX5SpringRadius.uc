//=============================================================================
// DTBX5SpringRadius.
//
// Damage type for the BX5 spring mine.
// Far less deadly against vehicle, because it jumps out of the ground rather than hitting the vulnerable underside.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBX5SpringRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k's mine jumped into %o's face."
     DeathStrings(1)="%o tried to kick %k's BX5."
     DeathStrings(2)="%k's BX5 attacked %o as %ve tried to sneak past."
     WeaponClass=Class'BallisticProV55.BX5Mine'
     DeathString="%k's mine jumped into %o's face."
     FemaleSuicide="%o caught her own spring mine out of the air."
     MaleSuicide="%o caught his own spring mine out of the air."
     bDelayedDamage=True
     VehicleMomentumScaling=0.500000
}
