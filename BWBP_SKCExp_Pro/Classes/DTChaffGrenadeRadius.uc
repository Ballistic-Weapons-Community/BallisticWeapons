//=============================================================================
// DTChaffGrenadeRadius.
//
// Damage type for the MOA-C grenade radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTChaffGrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o unexpectedly died to %k's MOA-C chaff grenade."
     DeathStrings(1)="%k got excited and tossed a smoke grenade at %o ."
     DeathStrings(2)="%k whipped an MOA-C to the wind and smoked out %o."
     WeaponClass=Class'BWBP_SKCExp_Pro.MJ51Carbine'
     DeathString="%o unexpectedly died to %k's MOA-C chaff grenade."
     FemaleSuicide="%o underestimated the strength of a smoke grenade."
     MaleSuicide="%o carelessly dropped a live grenade at his feet."
     bDelayedDamage=True
     bExtraMomentumZ=True
     VehicleDamageScaling=0.500000
}
