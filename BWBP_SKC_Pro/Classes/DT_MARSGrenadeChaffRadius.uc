//=============================================================================
// DTChaffGrenadeRadius.
//
// Damage type for the MOA-C grenade radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MARSGrenadeChaffRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o unexpectedly died to %k's MARS chaff grenade."
     DeathStrings(1)="%k got excited and shot a smoke grenade at %o ."
     DeathStrings(2)="%k whipped a MARS grenade to the wind and smoked out %o."
     SimpleKillString="MARS-2 Grenade Radius"
     WeaponClass=Class'BWBP_SKC_Pro.MARSAssaultRifle'
     DeathString="%o unexpectedly died to %k's MARS chaff grenade."
     FemaleSuicide="%o underestimated the strength of a smoke grenade."
     MaleSuicide="%o carelessly dropped a live grenade at his feet."
     bDelayedDamage=True
     bExtraMomentumZ=True
     VehicleDamageScaling=0.500000
}
