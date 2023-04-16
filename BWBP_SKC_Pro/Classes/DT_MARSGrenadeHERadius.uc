//=============================================================================
// DT_MARSGrenadeHERadius.
//
// Damage type for the MARS grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MARSGrenadeHERadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was liquified by %k's MARS grenade."
     DeathStrings(1)="%k blasted %o apart with a MARS grenade."
     DeathStrings(2)="%k delivered a live MARS grenade to %o."
     SimpleKillString="MARS HE Grenade Radius"
     DamageIdent="Grenade"
     WeaponClass=Class'BWBP_SKC_Pro.MARSAssaultRifle'
     DeathString="%o was liquified by %k's MARS grenade."
     FemaleSuicide="%o tested to see if her MARS grenades worked."
     MaleSuicide="%o tested to see if his MARS grenades worked."
     bDelayedDamage=True
     bExtraMomentumZ=True
     VehicleDamageScaling=0.500000
}
