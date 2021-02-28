//=============================================================================
// DTLAWMineDet.
//
// DamageType for the LAW mine's final detonation
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTLAWMineDet extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o happily sat on %k's idle LAW rocket."
     DeathStrings(1)="%o thought %k's idle LAW rocket was a dud."
     DeathStrings(2)="%k's LAW missile took %o out with its dying pulse."
     FemaleSuicides(0)="%o couldn't part ways with her dying LAW rocket."
     FemaleSuicides(1)="%o stupidly stood on her dying LAW rocket."
     MaleSuicides(0)="%o couldn't part ways with his dying LAW rocket."
     MaleSuicides(1)="%o stupidly stood on his dying LAW rocket."
     SimpleKillString="LAW Mine Explosion"
     InvasionDamageScaling=3.000000
     DamageIdent="Killstreak"
     WeaponClass=Class'BWBP_SKC_Pro.LAWLauncher'
     DeathString="%o happily sat on %k's idle LAW rocket."
     FemaleSuicide="%o couldn't part ways with her dying LAW rocket."
     MaleSuicide="%o couldn't part ways with his dying LAW rocket."
     bDelayedDamage=True
     VehicleDamageScaling=1.900000
     VehicleMomentumScaling=0.800000
}
